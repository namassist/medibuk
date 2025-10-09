import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:medibuk/domain/entities/anak_record.dart';
import 'package:medibuk/domain/entities/gynecology_record.dart';
import 'package:medibuk/domain/entities/laktasi_record.dart';
import 'package:medibuk/domain/entities/obstetric_record.dart';

class _HistoryDataRow extends StatelessWidget {
  final String label;
  final String value;

  const _HistoryDataRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textToCopy = value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SelectableText.rich(
              TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                children: [
                  TextSpan(text: '$label: '),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.copy, size: 16),
            tooltip: 'Copy Value',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: textToCopy));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Value copied to clipboard'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  final String title;
  final Map<String, dynamic> data;

  const _HistorySection({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Divider(height: 16),
          ...entries.map(
            (e) => _HistoryDataRow(
              label: e.key,
              value: e.value?.toString() ?? '-',
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final Widget subtitle;
  final List<Widget> children;

  const _CustomExpansionTile({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  State<_CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<_CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [widget.title, widget.subtitle],
                  ),
                ),
                Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...widget.children,
      ],
    );
  }
}

class HistoryDialog extends StatelessWidget {
  final List<dynamic> historyRecords;
  final String sectionType;

  const HistoryDialog({
    super.key,
    required this.historyRecords,
    required this.sectionType,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = (screenWidth * 0.7).clamp(320.0, 800.0);

    return AlertDialog(
      title: SelectableText('Riwayat $sectionType'),
      content: SizedBox(
        width: dialogWidth,
        child: historyRecords.isEmpty
            ? const Center(child: Text('Tidak ada data riwayat.'))
            : ListView.separated(
                itemCount: historyRecords.length,
                itemBuilder: (context, index) {
                  final record = historyRecords[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildHistoryTile(record),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Tutup'),
        ),
      ],
    );
  }

  Widget _buildHistoryTile(dynamic record) {
    if (record is ObstetricRecord) {
      return _buildObstetricHistoryTile(record);
    }
    if (record is GynecologyRecord) {
      return _buildGynecologyHistoryTile(record);
    }
    if (record is AnakRecord) {
      return _buildAnakHistoryTile(record);
    }
    if (record is LaktasiRecord) {
      return _buildLaktasiHistoryTile(record);
    }

    return ListTile(title: Text('Data riwayat tidak dikenali: ${record.id}'));
  }

  Widget _buildObstetricHistoryTile(ObstetricRecord record) {
    return _CustomExpansionTile(
      title: SelectableText('Pemeriksaan: ${record.visitDate ?? '-'}'),
      subtitle: SelectableText('Dokter: ${record.doctorId?.identifier ?? '-'}'),
      children: [
        _HistorySection(
          title: "Keluhan Pasien",
          data: {
            "Keluhan": record.chiefComplaint,
            "Note": record.note,
            "Internal Note": record.internalNote,
          },
        ),
        _HistorySection(
          title: "Info Umum",
          data: {
            "Tekanan Darah":
                "${record.systolicPressure ?? '-'}/${record.diastolicPressure ?? '-'}",
            "Tinggi Badan": record.bodyHeight,
            "Berat Badan": record.bodyWeight,
            "BMI": record.bmi,
          },
        ),
        _HistorySection(
          title: "Info Ibu",
          data: {
            "Hamil ke-": record.pregnancyNo,
            "Keguguran": record.miscarriage,
            "Usia": record.age,
            "HPL": record.hpl,
          },
        ),
        _HistorySection(
          title: "Info Janin",
          data: {
            "Jenis Kelamin": record.gender?.identifier,
            "Presentasi": record.presentation?.identifier,
            "Berat": record.weight,
            "Plasenta": record.placentaPosition?.identifier,
          },
        ),
        _HistorySection(
          title: "Pemeriksaan Janin",
          data: {
            "Cairan Ketuban": record.cairanKetuban?.identifier,
            "AFI": record.afi,
            "SDP": record.sdp,
            "BPD": record.bpd,
            "HC": record.hc,
            "AC": record.ac,
            "FL": record.fl,
            "CRL": record.crl,
            "GS": record.gs,
            "YS": record.ys,
          },
        ),
        _HistorySection(
          title: "Diagnosa",
          data: {"ICD-10": record.icd10?.identifier},
        ),
      ],
    );
  }

  Widget _buildGynecologyHistoryTile(GynecologyRecord record) {
    return _CustomExpansionTile(
      title: SelectableText('Pemeriksaan: ${record.visitDate ?? '-'}'),
      subtitle: SelectableText('Dokter: ${record.doctorId?.identifier ?? '-'}'),
      children: [
        _HistorySection(
          title: "Keluhan Pasien",
          data: {
            "Keluhan": record.chiefComplaint,
            "Note": record.note,
            "Internal Note": record.internalNote,
          },
        ),
        _HistorySection(
          title: "Info Umum",
          data: {
            "Tekanan Darah":
                "${record.systolicPressure ?? '-'}/${record.diastolicPressure ?? '-'}",
            "HPHT": record.firstDayOfMenstrualPeriod,
            "Berat Badan": record.bodyWeight,
            "KB": record.birthControlMethod?.identifier,
          },
        ),
        _HistorySection(
          title: "Uterus",
          data: {
            "Endometrium": record.endometriumThickness,
            "Position": record.uterusPosition?.identifier,
            "Ukuran (LxWxT)":
                "${record.uterusLength ?? '-'}x${record.uterusWidth ?? '-'}x${record.uterusThickness ?? '-'}",
            "Notes": record.uterusNote,
          },
        ),
        _HistorySection(
          title: "Ovary Kanan",
          data: {
            "Jumlah Folikel": record.rightOvaryFollicleCount,
            "Ukuran (LxWxT)":
                "${record.rightOvaryLength ?? '-'}x${record.rightOvaryWidth ?? '-'}x${record.rightOvaryThickness ?? '-'}",
            "Notes": record.rightOvaryNote,
          },
        ),
        _HistorySection(
          title: "Ovary Kiri",
          data: {
            "Jumlah Folikel": record.leftOvaryFollicleCount,
            "Ukuran (LxWxT)":
                "${record.leftOvaryLength ?? '-'}x${record.leftOvaryWidth ?? '-'}x${record.leftOvaryThickness ?? '-'}",
            "Notes": record.leftOvaryNote,
          },
        ),
        _HistorySection(
          title: "Diagnosa",
          data: {"ICD-10": record.icd10?.identifier},
        ),
      ],
    );
  }

  Widget _buildAnakHistoryTile(AnakRecord record) {
    return _CustomExpansionTile(
      title: SelectableText('Pemeriksaan: ${record.visitDate ?? '-'}'),
      subtitle: SelectableText('Dokter: ${record.doctorID?.identifier ?? '-'}'),
      children: [
        _HistorySection(
          title: "Keluhan Pasien",
          data: {
            "Keluhan": record.keluhanUtama,
            "Description": record.description,
          },
        ),
        _HistorySection(
          title: "Info Umum",
          data: {
            "Berat Lahir": record.birthWeight,
            "Lingkar Kepala": record.headCircumference,
            "Pernafasan": "${record.pernafasan}",
          },
        ),
        _HistorySection(
          title: "Info Ibu",
          data: {
            "Berat Badan": record.bodyWeight,
            "Tinggi Badan": record.bodyHeight,
            "Temperatur": record.bodyTemperature,
            "Tekanan Darah": record.tekananDarah,
          },
        ),
        _HistorySection(
          title: "Diagnosa",
          data: {"ICD-10": record.icd10?.identifier},
        ),
      ],
    );
  }

  Widget _buildLaktasiHistoryTile(LaktasiRecord record) {
    String formatDate(DateTime? date) {
      if (date == null) return '-';
      return DateFormat('dd/MM/yyyy').format(date);
    }

    return _CustomExpansionTile(
      title: SelectableText('Pemeriksaan: ${formatDate(record.visitDate)}'),
      subtitle: SelectableText('Dokter: ${record.doctorID?.identifier ?? '-'}'),
      children: [
        _HistorySection(
          title: "Keluhan Pasien",
          data: {
            "Keluhan Utama": record.keluhanUtama,
            "Puting Lecet": record.scratched,
            "ASI Lancar": record.breastMilk,
            "Bayi Menyusu Langsung": record.suckling,
          },
        ),
        _HistorySection(
          title: "Info Ibu",
          data: {
            "Tekanan Darah":
                "${record.systolicPressureMother ?? '-'}/${record.diastolicPressureMother ?? '-'}",
            "Suhu Badan": record.bodyTemperatureMother,
            "Berat Badan": record.bodyWeightMother,
          },
        ),
        _HistorySection(
          title: "Info Bayi",
          data: {
            "Nama Anak": record.child?.identifier,
            "Tanggal Lahir": formatDate(record.birthday),
            "Jenis Kelamin": record.gender?.identifier,
            "Berat Lahir": record.birthWeight,
          },
        ),
        _HistorySection(
          title: "Diagnosa",
          data: {"ICD-10": record.icd10?.identifier},
        ),
      ],
    );
  }
}
