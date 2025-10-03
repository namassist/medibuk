import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/business_partner_repository.dart';
import 'package:medibuk/domain/entities/bpartner_info_record.dart';
import 'package:medibuk/presentation/providers/dashboard_provider.dart';
import 'package:medibuk/presentation/widgets/core/app_table.dart';
import 'package:medibuk/presentation/utils/date_formatted.dart';

@immutable
class BPartnerSearchState {
  final String query;
  final bool isCustomer;
  final AsyncValue<List<BusinessPartnerInfoRecord>> results;

  const BPartnerSearchState({
    this.query = '',
    this.isCustomer = true,
    this.results = const AsyncValue.data([]),
  });

  BPartnerSearchState copyWith({
    String? query,
    bool? isCustomer,
    AsyncValue<List<BusinessPartnerInfoRecord>>? results,
  }) {
    return BPartnerSearchState(
      query: query ?? this.query,
      isCustomer: isCustomer ?? this.isCustomer,
      results: results ?? this.results,
    );
  }
}

class BpSearchNotifier extends StateNotifier<BPartnerSearchState> {
  final BusinessPartnerRepository _repo;

  BpSearchNotifier(this._repo, {required String initialQuery})
    : super(BPartnerSearchState(query: initialQuery)) {
    search();
  }

  void setSearchQuery(String query) {
    state = state.copyWith(query: query);
  }

  void setIsCustomer(bool isCustomer) {
    state = state.copyWith(isCustomer: isCustomer);
    search();
  }

  Future<void> search() async {
    state = state.copyWith(results: const AsyncValue.loading());
    try {
      final results = await _repo.searchBusinessPartner(
        query: state.query,
        isCustomer: state.isCustomer,
      );
      state = state.copyWith(results: AsyncValue.data(results));
    } catch (e, st) {
      state = state.copyWith(results: AsyncValue.error(e, st));
    }
  }
}

final bpSearchProvider = StateNotifierProvider.autoDispose
    .family<BpSearchNotifier, BPartnerSearchState, String>((ref, initialQuery) {
      final repo = ref.watch(businessPartnerRepositoryProvider);
      return BpSearchNotifier(repo, initialQuery: initialQuery);
    });

class BPartnerSearchDialog extends ConsumerWidget {
  final String initialQuery;
  const BPartnerSearchDialog({super.key, required this.initialQuery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = bpSearchProvider(initialQuery);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    final searchController = TextEditingController(text: state.query);
    searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: searchController.text.length),
    );

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 500),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Cari berdasarkan Nama atau Nomor HP...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: notifier.setSearchQuery,
                onSubmitted: (_) => notifier.search(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Customer'),
                  Switch(
                    value: state.isCustomer,
                    onChanged: notifier.setIsCustomer,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.results.when(
                  data: (partners) {
                    if (partners.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada data ditemukan.'),
                      );
                    }
                    return AppTable(
                      initialData: partners.map((p) => p.toJson()).toList(),
                      columns: [
                        TableColumn(
                          label: 'NIK',
                          size: ColumnSize.S,
                          cellBuilder: (item) {
                            final partner = item as BusinessPartnerInfoRecord;
                            return Center(
                              child: partner.hasNik == true
                                  ? Icon(
                                      Icons.check_box,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                            );
                          },
                        ),
                        TableColumn(
                          label: 'Search Key',
                          key: 'Value',
                          size: ColumnSize.L,
                        ),
                        TableColumn(
                          label: 'Name',
                          key: 'Name',
                          size: ColumnSize.L,
                        ),
                        TableColumn(label: 'Birthday', key: 'Birthday'),
                        TableColumn(
                          label: 'Phone',
                          key: 'Phone',
                          size: ColumnSize.M,
                        ),
                        TableColumn(
                          label: 'Address',
                          key: 'Address1',
                          size: ColumnSize.L,
                        ),
                        TableColumn(label: 'Gender', key: 'Gender'),
                      ],
                      showAddButton: false,
                      showActionColumn: false,
                      enableMultiSelect: false,
                      initialDataParser: (item) =>
                          BusinessPartnerInfoRecord.fromJson(item),
                      cellValueBuilder: (item, columnKey) {
                        final partner = item as BusinessPartnerInfoRecord;
                        switch (columnKey) {
                          case 'Value':
                            return partner.value;
                          case 'Name':
                            return partner.name;
                          case 'Birthday':
                            return formatDate(
                              DateTime.tryParse(partner.birthday ?? ''),
                            );
                          case 'Phone':
                            return partner.phone;
                          case 'Address1':
                            return partner.address;
                          case 'Gender':
                            return partner.gender?.identifier;
                          default:
                            return '';
                        }
                      },
                      onRowTap: (item) {
                        final partner = item as BusinessPartnerInfoRecord;
                        ref
                            .read(dashboardProvider.notifier)
                            .filterByBPartner(partner.id, partner.name!);
                        // Tutup dialog
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error: $e')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
