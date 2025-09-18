import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/medical_record.dart';
import '../providers/medical_record_providers.dart';
import '../widgets/form_section_widget.dart';

class MedicalRecordPage extends ConsumerStatefulWidget {
  final String medicalRecordId;

  const MedicalRecordPage({super.key, required this.medicalRecordId});

  @override
  ConsumerState<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends ConsumerState<MedicalRecordPage> {
  late MedicalRecord? _currentRecord;
  bool _isModified = false;

  @override
  Widget build(BuildContext context) {
    final medicalRecordAsync = ref.watch(
      medicalRecordNotifierProvider(widget.medicalRecordId),
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Medical Record - ${widget.medicalRecordId}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          medicalRecordAsync.when(
            data: (record) =>
                record != null ? _buildActionButtons(record) : const SizedBox(),
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
        ],
      ),
      body: medicalRecordAsync.when(
        data: (record) =>
            record != null ? _buildContent(record) : _buildEmptyState(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(error.toString()),
      ),
    );
  }

  Widget _buildActionButtons(MedicalRecord record) {
    final isCompleted = record.docStatus.id == 'CO';
    final canEdit = !isCompleted;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green[50] : Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isCompleted ? Colors.green[200]! : Colors.orange[200]!,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.edit,
                size: 16,
                color: isCompleted ? Colors.green[600] : Colors.orange[600],
              ),
              const SizedBox(width: 4),
              Text(
                record.docStatus.identifier,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isCompleted ? Colors.green[700] : Colors.orange[700],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (canEdit && _isModified) ...[
          TextButton.icon(
            onPressed: _saveChanges,
            icon: const Icon(Icons.save, size: 18),
            label: const Text('Save'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[50],
              foregroundColor: Colors.blue[700],
            ),
          ),
          const SizedBox(width: 8),
        ],
        if (canEdit)
          ElevatedButton.icon(
            onPressed: _markAsComplete,
            icon: const Icon(Icons.check, size: 18),
            label: const Text('Complete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
            ),
          ),
      ],
    );
  }

  Widget _buildContent(MedicalRecord record) {
    _currentRecord = record;
    final isEditable = record.docStatus.id != 'CO';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(record),
          const SizedBox(height: 24),
          _buildMainInformation(record, isEditable),
          const SizedBox(height: 16),
          if (record.obstetric?.isNotEmpty ?? false) ...[
            ...record.obstetric!.asMap().entries.map((entry) {
              final index = entry.key;
              final obstetricData = entry.value;
              return FormSectionWidget(
                title: 'Obstetric ${index + 1}',
                data: obstetricData.toJson(),
                isEditable: isEditable,
                onDataChanged: (data) =>
                    _onSectionDataChanged('obstetric', index, data),
              );
            }),
          ],
          if (record.gynecology?.isNotEmpty ?? false) ...[
            ...record.gynecology!.asMap().entries.map((entry) {
              final index = entry.key;
              final gynecologyData = entry.value;
              return FormSectionWidget(
                title: 'Gynecology ${index + 1}',
                data: gynecologyData.toJson(),
                isEditable: isEditable,
                onDataChanged: (data) =>
                    _onSectionDataChanged('gynecology', index, data),
              );
            }),
          ],
          if (record.prescriptions?.isNotEmpty ?? false) ...[
            ...record.prescriptions!.asMap().entries.map((entry) {
              final index = entry.key;
              final prescriptionData = entry.value;
              return FormSectionWidget(
                title: 'Prescription ${index + 1}',
                data: prescriptionData.toJson(),
                isEditable: isEditable,
                onDataChanged: (data) =>
                    _onSectionDataChanged('prescriptions', index, data),
              );
            }),
          ],
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildHeader(MedicalRecord record) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.medical_information,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Document No: ${record.documentNo}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Patient: ${record.cBPartnerId?.identifier ?? 'N/A'}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.calendar_today,
                label: 'Date',
                value: record.dateTrx,
              ),
              const SizedBox(width: 12),
              if (record.gestationalAgeWeek != null)
                _buildInfoChip(
                  icon: Icons.schedule,
                  label: 'Gestational Age',
                  value:
                      '${record.gestationalAgeWeek}w ${record.gestationalAgeDay ?? 0}d',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainInformation(MedicalRecord record, bool isEditable) {
    final mainData = <String, dynamic>{
      'DocumentNo': record.documentNo,
      'DateTrx': record.dateTrx,
      'GestationalAgeWeek': record.gestationalAgeWeek,
      'GestationalAgeDay': record.gestationalAgeDay,
      'AD_Client_ID': record.adClientId,
      'AD_Org_ID': record.adOrgId,
      'C_SalesRegion_ID': record.cSalesRegionId,
      'OrderType_ID': record.orderTypeId,
      'M_Specialist_ID': record.mSpecialistId,
      'C_BPartner_ID': record.cBPartnerId,
    };

    return FormSectionWidget(
      title: 'Information',
      data: mainData,
      isEditable: isEditable,
      onDataChanged: (data) => _onMainDataChanged(data),
      initiallyExpanded: true,
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No medical record found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Error loading medical record',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(
              medicalRecordNotifierProvider(widget.medicalRecordId),
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _onMainDataChanged(Map<String, dynamic> data) {
    setState(() => _isModified = true);
    // Update main record data logic here
    // You can implement the actual update logic based on your needs
    print('Main data changed: $data');
  }

  void _onSectionDataChanged(
    String sectionType,
    int index,
    Map<String, dynamic> data,
  ) {
    setState(() => _isModified = true);
    // Update section data logic here
    // You can implement the actual update logic based on your needs
    print('Section $sectionType[$index] changed: $data');
  }

  void _saveChanges() async {
    if (_currentRecord == null) return;

    try {
      await ref
          .read(medicalRecordNotifierProvider(widget.medicalRecordId).notifier)
          .updateRecord(_currentRecord!);

      setState(() => _isModified = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Changes saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save changes: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _markAsComplete() async {
    if (_currentRecord == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Complete'),
        content: const Text(
          'Are you sure you want to mark this record as complete? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Complete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Create updated record with completed status
      final updatedRecord = MedicalRecord(
        id: _currentRecord!.id,
        uid: _currentRecord!.uid,
        documentNo: _currentRecord!.documentNo,
        dateTrx: _currentRecord!.dateTrx,
        docStatus: const GeneralInfo(
          propertyLabel: 'Document Status',
          id: 'CO',
          identifier: 'Completed',
          modelName: 'ad_ref_list',
        ),
        gestationalAgeWeek: _currentRecord!.gestationalAgeWeek,
        gestationalAgeDay: _currentRecord!.gestationalAgeDay,
        adClientId: _currentRecord!.adClientId,
        adOrgId: _currentRecord!.adOrgId,
        cSalesRegionId: _currentRecord!.cSalesRegionId,
        orderTypeId: _currentRecord!.orderTypeId,
        mSpecialistId: _currentRecord!.mSpecialistId,
        cBPartnerId: _currentRecord!.cBPartnerId,
        processed: true,
        obstetric: _currentRecord!.obstetric,
        gynecology: _currentRecord!.gynecology,
        prescriptions: _currentRecord!.prescriptions,
      );

      try {
        await ref
            .read(
              medicalRecordNotifierProvider(widget.medicalRecordId).notifier,
            )
            .updateRecord(updatedRecord);

        setState(() => _isModified = false);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Medical record marked as complete'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to complete record: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
