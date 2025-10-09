import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/medical_record_repository.dart';
import 'package:medibuk/domain/entities/field_config.dart';
import 'package:medibuk/presentation/providers/form_data_provider.dart';
import 'package:medibuk/presentation/widgets/core/app_fields.dart';
import 'package:medibuk/presentation/widgets/core/responsive_grid.dart';
import 'package:medibuk/presentation/widgets/shared/history_dialog.dart';

// 1. Ubah menjadi ConsumerStatefulWidget
// Perannya adalah sebagai "Manajer Layout" yang cerdas
class AppFormSection extends ConsumerStatefulWidget {
  final String title;
  final Map<String, dynamic> originalData;
  final bool isEditable;
  final String sectionType;
  final int sectionIndex;
  final String recordId;
  final bool initiallyExpanded;
  final VoidCallback? onDelete;
  final bool collapsible;

  const AppFormSection({
    super.key,
    required this.title,
    required this.originalData,
    required this.isEditable,
    required this.sectionType,
    required this.sectionIndex,
    required this.recordId,
    this.initiallyExpanded = true,
    this.onDelete,
    this.collapsible = true,
  });

  @override
  ConsumerState<AppFormSection> createState() => _AppFormSectionState();
}

class _AppFormSectionState extends ConsumerState<AppFormSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // State yang dikelola HANYA untuk UI (expand/collapse)
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  Future<void> _showHistoryDialog() async {
    // Hanya tampilkan jika ini adalah section dari medical record
    if (!widget.sectionType.startsWith('medrec_')) return;

    final recordId = widget.originalData['id'];
    if (recordId == null || recordId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data baru belum memiliki riwayat.')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      List<dynamic> historyData = [];
      String historyType = '';

      if (widget.sectionType.contains('obstetric')) {
        historyData = await ref
            .read(medicalRecordRepositoryProvider)
            .getObstetricHistory(recordId);
        historyType = 'Obstetric';
      } else if (widget.sectionType.contains('gynecology')) {
        historyData = await ref
            .read(medicalRecordRepositoryProvider)
            .getGynecologyHistory(recordId);
        historyType = 'Gynecology';
      } else if (widget.sectionType.contains('anak')) {
        historyData = await ref
            .read(medicalRecordRepositoryProvider)
            .getAnakHistory(recordId);
        historyType = 'Anak';
      } else if (widget.sectionType.contains('laktasi')) {
        historyData = await ref
            .read(medicalRecordRepositoryProvider)
            .getLaktasiHistory(recordId);
        historyType = 'Laktasi';
      }

      if (context.mounted) Navigator.of(context).pop(); // Tutup loading

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => HistoryDialog(
            historyRecords: historyData,
            sectionType: historyType,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop(); // Tutup loading
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  // 2. Logika visibilitas dan layout sekarang ada di dalam `build`
  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Langkah A: Bangun data terbaru yang dibutuhkan oleh rules
    final dataForRules = _buildDataForRules(
      ref,
      widget.originalData,
      widget.recordId,
    );

    // Langkah B: Dapatkan daftar kunci (nama field) yang VISIBLE saja
    final visibleFieldKeys = _getVisibleFieldKeys(dataForRules);

    // Langkah C: Bangun widget AppFields HANYA untuk field yang visible
    final fieldWidgets = _buildVisibleFormFields(visibleFieldKeys);

    // Langkah D: Siapkan data layout (spans, breaks) HANYA untuk field yang visible
    final spans = <int>[];
    final breaks = <bool>[];
    for (final key in visibleFieldKeys) {
      final config = FieldConfig.getConfig(key, section: widget.sectionType);
      spans.add(config.wideCount);
      breaks.add(config.newLine);
    }

    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          _buildHeader(),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // ResponsiveGrid sekarang hanya menerima widget yang sudah pasti terlihat
                  return ResponsiveGrid(
                    maxWidth: constraints.maxWidth,
                    spans: spans,
                    breakBefore: breaks,
                    children: fieldWidgets,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // Helper untuk memantau field-field yang menjadi dependency
  Map<String, dynamic> _buildDataForRules(
    WidgetRef ref,
    Map<String, dynamic> originalData,
    String recordId,
  ) {
    // Pantau nilai M_Specialist_ID. Widget ini akan rebuild jika specialist berubah.
    final specialistValue = ref.watch(
      formDataProvider.select((state) {
        final key =
            '$recordId|encounter_main:0'; // Asumsi Specialist ada di section main
        return state.current[key]?['M_Specialist_ID'] ??
            originalData['M_Specialist_ID'];
      }),
    );

    // Pantau nilai C_DocType_ID
    final docTypeValue = ref.watch(
      formDataProvider.select((state) {
        final key = '$recordId|encounter_main:0';
        return state.current[key]?['C_DocType_ID'] ??
            originalData['C_DocType_ID'];
      }),
    );

    // Buat salinan data dan timpa dengan nilai-nilai terbaru yang relevan untuk rules
    final dataForRules = Map<String, dynamic>.from(originalData);
    dataForRules['M_Specialist_ID'] = specialistValue;
    dataForRules['C_DocType_ID'] = docTypeValue;

    // Tambahkan field lain di sini jika dibutuhkan oleh rules di masa depan
    return dataForRules;
  }

  // Helper untuk memfilter field yang visible
  List<String> _getVisibleFieldKeys(Map<String, dynamic> dataForRules) {
    final allKeys = FieldConfig.orderedKeysForSection(widget.sectionType);
    final visibleKeys = <String>[];

    for (final key in allKeys) {
      final cfg = FieldConfig.getConfig(key, section: widget.sectionType);
      bool isHidden = false;
      if (cfg.isHiddenRule != null) {
        isHidden = cfg.isHiddenRule!(dataForRules);
      }
      if (!isHidden) {
        visibleKeys.add(key);
      }
    }
    return visibleKeys;
  }

  // Helper untuk membangun daftar widget AppFields
  List<Widget> _buildVisibleFormFields(List<String> visibleFieldKeys) {
    final fields = <Widget>[];
    for (final key in visibleFieldKeys) {
      fields.add(
        AppFields(
          key: ValueKey(
            '${widget.recordId}_${widget.sectionType}_${widget.sectionIndex}_$key',
          ),
          fieldName: key,
          originalData: widget.originalData,
          isEditable: widget.isEditable, // isEditable dari level section
          sectionType: widget.sectionType,
          sectionIndex: widget.sectionIndex,
          recordId: widget.recordId,
        ),
      );
    }
    return fields;
  }

  // --- Sisa dari kode UI Anda (tidak ada perubahan) ---
  Widget _buildHeader() {
    final colorScheme = Theme.of(context).colorScheme;
    final header = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.sectionType.startsWith('medrec_'))
            IconButton(
              onPressed: _showHistoryDialog,
              tooltip: 'Lihat Riwayat',
              icon: Icon(Icons.history, color: colorScheme.primary),
            ),
          if (widget.sectionType.contains('obstetric') &&
              widget.isEditable &&
              widget.onDelete != null)
            IconButton(
              onPressed: widget.onDelete,
              tooltip: 'Delete',
              icon: Icon(Icons.delete_forever, color: colorScheme.error),
            ),
          Icon(Icons.info_outline, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: 8),
          if (widget.collapsible)
            Icon(
              _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
              color: colorScheme.onSecondaryContainer,
            ),
        ],
      ),
    );

    if (!widget.collapsible) return header;
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      child: header,
    );
  }
}
