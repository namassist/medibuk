import 'package:flutter/material.dart';

enum ActionButtonType {
  save,
  completed,
  activateAsset,
  printBCStatement,
  printBKK,
  printBKM,
  commissionRun,
  medicalRecord,
  createSalesOrder,
  recreateSO,
  prepare,
  callConsultation,
  order,
  encounter,
  printGynecology,
  printObs1,
  printObs2,
  printDental,
  printChild,
  printGeneral,
  printLactation,
  encounterSchedules,
  attachment,
  invoice,
  meditalVoucher,
  promotionalVoucher,
  printInvoice,
  reimburseKwitansi,
  glJournalLine,
  printMaterialReceipt,
  createInvoice,
  rma,
  reset,
  process,
  printReceipt,
  createPriceList,
  import,
  export,
  copyPrice,
  createPrice,
  createStock,
  printPo,
  addDiscount,
  materialReceipt,
  printRequisition,
  generatePurchasePlan,
  delete,
  returnVendor,
  changePatient,
  changeSchedule,
  countInventory,
  cancelWorkflow,
}

class _ActionButtonMeta {
  final IconData icon;
  const _ActionButtonMeta({required this.icon});
}

const actionButtonMetaMap = <ActionButtonType, _ActionButtonMeta>{
  ActionButtonType.save: _ActionButtonMeta(icon: Icons.save),
  ActionButtonType.completed: _ActionButtonMeta(
    icon: Icons.check_circle_outline,
  ),
  ActionButtonType.activateAsset: _ActionButtonMeta(
    icon: Icons.power_settings_new,
  ),
  ActionButtonType.attachment: _ActionButtonMeta(icon: Icons.attach_file),
  ActionButtonType.invoice: _ActionButtonMeta(icon: Icons.receipt),
  ActionButtonType.createInvoice: _ActionButtonMeta(icon: Icons.add_card),
  ActionButtonType.meditalVoucher: _ActionButtonMeta(
    icon: Icons.medical_services,
  ),
  ActionButtonType.promotionalVoucher: _ActionButtonMeta(icon: Icons.sell),
  ActionButtonType.delete: _ActionButtonMeta(icon: Icons.delete_forever),
  ActionButtonType.process: _ActionButtonMeta(icon: Icons.sync),
  ActionButtonType.reset: _ActionButtonMeta(icon: Icons.restart_alt),
  ActionButtonType.import: _ActionButtonMeta(icon: Icons.file_upload),
  ActionButtonType.export: _ActionButtonMeta(icon: Icons.file_download),
  ActionButtonType.commissionRun: _ActionButtonMeta(
    icon: Icons.account_balance_wallet,
  ),
  ActionButtonType.medicalRecord: _ActionButtonMeta(
    icon: Icons.medical_information,
  ),
  ActionButtonType.createSalesOrder: _ActionButtonMeta(
    icon: Icons.shopping_cart,
  ),
  ActionButtonType.recreateSO: _ActionButtonMeta(icon: Icons.refresh),
  ActionButtonType.prepare: _ActionButtonMeta(icon: Icons.build),
  ActionButtonType.callConsultation: _ActionButtonMeta(icon: Icons.phone),
  ActionButtonType.order: _ActionButtonMeta(icon: Icons.reorder),
  ActionButtonType.encounter: _ActionButtonMeta(icon: Icons.medical_services),
  ActionButtonType.encounterSchedules: _ActionButtonMeta(icon: Icons.schedule),
  ActionButtonType.reimburseKwitansi: _ActionButtonMeta(
    icon: Icons.receipt_long,
  ),
  ActionButtonType.glJournalLine: _ActionButtonMeta(
    icon: Icons.account_balance,
  ),
  ActionButtonType.rma: _ActionButtonMeta(icon: Icons.assignment_return),
  ActionButtonType.createPriceList: _ActionButtonMeta(icon: Icons.price_check),
  ActionButtonType.copyPrice: _ActionButtonMeta(icon: Icons.copy),
  ActionButtonType.createPrice: _ActionButtonMeta(
    icon: Icons.add_shopping_cart,
  ),
  ActionButtonType.createStock: _ActionButtonMeta(icon: Icons.inventory),
  ActionButtonType.addDiscount: _ActionButtonMeta(icon: Icons.discount),
  ActionButtonType.materialReceipt: _ActionButtonMeta(icon: Icons.inventory_2),
  ActionButtonType.generatePurchasePlan: _ActionButtonMeta(
    icon: Icons.assignment,
  ),
  ActionButtonType.returnVendor: _ActionButtonMeta(icon: Icons.keyboard_return),
  ActionButtonType.changePatient: _ActionButtonMeta(icon: Icons.swap_horiz),
  ActionButtonType.changeSchedule: _ActionButtonMeta(icon: Icons.schedule),
  // Grouped "Print" buttons
  ActionButtonType.printInvoice: _ActionButtonMeta(icon: Icons.print),
  ActionButtonType.printBCStatement: _ActionButtonMeta(
    icon: Icons.print_outlined,
  ),
  ActionButtonType.printBKM: _ActionButtonMeta(icon: Icons.print_outlined),
  ActionButtonType.printBKK: _ActionButtonMeta(icon: Icons.print_outlined),
  ActionButtonType.printGynecology: _ActionButtonMeta(icon: Icons.woman),
  ActionButtonType.printDental: _ActionButtonMeta(
    icon: Icons.medical_services_outlined,
  ),
  ActionButtonType.printObs1: _ActionButtonMeta(icon: Icons.pregnant_woman),
  ActionButtonType.printObs2: _ActionButtonMeta(icon: Icons.pregnant_woman),
  ActionButtonType.printChild: _ActionButtonMeta(icon: Icons.child_care),
  ActionButtonType.printGeneral: _ActionButtonMeta(icon: Icons.print),
  ActionButtonType.printLactation: _ActionButtonMeta(icon: Icons.local_drink),
  ActionButtonType.printMaterialReceipt: _ActionButtonMeta(
    icon: Icons.receipt_long,
  ),
  ActionButtonType.printReceipt: _ActionButtonMeta(icon: Icons.receipt),
  ActionButtonType.printPo: _ActionButtonMeta(icon: Icons.local_mall),
  ActionButtonType.printRequisition: _ActionButtonMeta(
    icon: Icons.request_page,
  ),
  ActionButtonType.countInventory: _ActionButtonMeta(icon: Icons.inventory),
  ActionButtonType.cancelWorkflow: _ActionButtonMeta(
    icon: Icons.cancel_schedule_send,
  ),
};

String getButtonLabel(BuildContext context, ActionButtonType type) {
  switch (type) {
    case ActionButtonType.save:
      return "Save";
    case ActionButtonType.completed:
      return "Complete";
    case ActionButtonType.activateAsset:
      return "Activate Asset";
    case ActionButtonType.attachment:
      return "Attachment";
    case ActionButtonType.invoice:
      return "Invoice";
    case ActionButtonType.createInvoice:
      return "Create Invoice";
    case ActionButtonType.meditalVoucher:
      return "Medital Voucher";
    case ActionButtonType.promotionalVoucher:
      return "Promotional Voucher";
    case ActionButtonType.delete:
      return "Delete";
    case ActionButtonType.process:
      return "Process";
    case ActionButtonType.reset:
      return "Reset";
    case ActionButtonType.import:
      return "Import";
    case ActionButtonType.export:
      return "Export";
    case ActionButtonType.commissionRun:
      return "Commission Run";
    case ActionButtonType.medicalRecord:
      return "Medical Record";
    case ActionButtonType.createSalesOrder:
      return "Create Sales Order";
    case ActionButtonType.recreateSO:
      return "Recreate SO";
    case ActionButtonType.prepare:
      return "Prepare";
    case ActionButtonType.callConsultation:
      return "Call Consultation";
    case ActionButtonType.order:
      return "Order";
    case ActionButtonType.encounter:
      return "Encounter";
    case ActionButtonType.encounterSchedules:
      return "Encounter Schedules";
    case ActionButtonType.reimburseKwitansi:
      return "Reimburse Kwitansi";
    case ActionButtonType.glJournalLine:
      return "GL Journal Line";
    case ActionButtonType.rma:
      return "RMA";
    case ActionButtonType.createPriceList:
      return "Create Price List";
    case ActionButtonType.copyPrice:
      return "Copy Price";
    case ActionButtonType.createPrice:
      return "Create Price";
    case ActionButtonType.createStock:
      return "Create Stock";
    case ActionButtonType.addDiscount:
      return "Add Discount";
    case ActionButtonType.materialReceipt:
      return "Material Receipt";
    case ActionButtonType.generatePurchasePlan:
      return "Generate Purchase Plan";
    case ActionButtonType.returnVendor:
      return "Return Vendor";
    case ActionButtonType.changePatient:
      return "Change Patient";
    case ActionButtonType.changeSchedule:
      return "Change Schedule";
    case ActionButtonType.countInventory:
      return "Count Inventory";
    case ActionButtonType.cancelWorkflow:
      return "Cancel Workflow";

    // --- PRINT GROUP ---
    case ActionButtonType.printInvoice:
      return "Print Invoice";
    case ActionButtonType.printBCStatement:
      return "Print BC Statement";
    case ActionButtonType.printBKM:
      return "Print BKM";
    case ActionButtonType.printBKK:
      return "Print BKK";
    case ActionButtonType.printGynecology:
      return "Print Gynecology";
    case ActionButtonType.printDental:
      return "Print Dental";
    case ActionButtonType.printObs1:
      return "Print Obs 1";
    case ActionButtonType.printObs2:
      return "Print Obs 2";
    case ActionButtonType.printChild:
      return "Print Child";
    case ActionButtonType.printGeneral:
      return "Print General";
    case ActionButtonType.printLactation:
      return "Print Lactation";
    case ActionButtonType.printMaterialReceipt:
      return "Print Material Receipt";
    case ActionButtonType.printReceipt:
      return "Print Receipt";
    case ActionButtonType.printPo:
      return "Print PO";
    case ActionButtonType.printRequisition:
      return "Print Requisition";
    // default:
    //   final enumName = type.toString().split('.').last;
    //   final withSpaces = enumName.replaceAllMapped(
    //     RegExp(r'[A-Z]'),
    //     (match) => ' ${match.group(0)}',
    //   );
    //   return withSpaces[0].toUpperCase() + withSpaces.substring(1).trim();
  }
}

const Map<ActionButtonType, int> _buttonPriority = {
  ActionButtonType.save: 1,
  ActionButtonType.completed: 2,
  ActionButtonType.attachment: 3,
  ActionButtonType.medicalRecord: 4,
  ActionButtonType.order: 5,
  ActionButtonType.encounter: 6,
  ActionButtonType.prepare: 7,
  ActionButtonType.callConsultation: 8,
  ActionButtonType.createInvoice: 9,
  ActionButtonType.materialReceipt: 10,
  ActionButtonType.process: 11,
  ActionButtonType.invoice: 12,
  ActionButtonType.activateAsset: 13,
  ActionButtonType.meditalVoucher: 14,
  ActionButtonType.promotionalVoucher: 15,
  ActionButtonType.createSalesOrder: 16,
  ActionButtonType.commissionRun: 17,
  ActionButtonType.encounterSchedules: 18,
  ActionButtonType.glJournalLine: 19,
  ActionButtonType.rma: 20,
  ActionButtonType.recreateSO: 21,
  ActionButtonType.addDiscount: 22,
  ActionButtonType.createPriceList: 23,
  ActionButtonType.createPrice: 24,
  ActionButtonType.createStock: 25,
  ActionButtonType.generatePurchasePlan: 26,
  ActionButtonType.import: 27,
  ActionButtonType.export: 28,
  ActionButtonType.copyPrice: 29,
  ActionButtonType.reset: 30,
  ActionButtonType.delete: 31,
  ActionButtonType.returnVendor: 32,
  ActionButtonType.changePatient: 33,
  ActionButtonType.changeSchedule: 34,
  ActionButtonType.countInventory: 35,
  ActionButtonType.cancelWorkflow: 36,
  ActionButtonType.printBCStatement: 100,
  ActionButtonType.printBKM: 100,
  ActionButtonType.printBKK: 100,
  ActionButtonType.printGynecology: 100,
  ActionButtonType.printDental: 100,
  ActionButtonType.printObs1: 100,
  ActionButtonType.printObs2: 100,
  ActionButtonType.printChild: 100,
  ActionButtonType.printGeneral: 100,
  ActionButtonType.printLactation: 100,
  ActionButtonType.printInvoice: 100,
  ActionButtonType.printMaterialReceipt: 100,
  ActionButtonType.printReceipt: 100,
  ActionButtonType.printPo: 100,
  ActionButtonType.printRequisition: 100,
  ActionButtonType.reimburseKwitansi: 100,
};

int getPriority(ActionButtonType type) {
  return _buttonPriority[type] ?? 999;
}

bool isPrimaryButton(ActionButtonType type) {
  return type == ActionButtonType.save || type == ActionButtonType.completed;
}

class ActionDefinition {
  final ActionButtonType type;
  final VoidCallback onPressed;
  final bool isEnabled;

  const ActionDefinition({
    required this.type,
    required this.onPressed,
    this.isEnabled = true,
  });
}

class ActionButton extends StatelessWidget {
  final ActionDefinition definition;
  const ActionButton({super.key, required this.definition});

  @override
  Widget build(BuildContext context) {
    final meta = actionButtonMetaMap[definition.type];
    final label = getButtonLabel(context, definition.type);
    final isDisabled = !definition.isEnabled;

    // Tampilkan tombol error jika metadata tidak ada
    if (meta == null) {
      return OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.error),
        label: Text('Invalid: ${definition.type}'),
      );
    }

    // 1. Tombol Primary (Save & Complete)
    if (isPrimaryButton(definition.type)) {
      return SizedBox(
        height: 40,
        child: FilledButton.icon(
          icon: Icon(meta.icon, size: 18),
          label: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: isDisabled
                ? Colors.grey.shade300
                : (definition.type == ActionButtonType.completed
                      ? Colors.green.shade600
                      : Theme.of(context).colorScheme.primary),
            foregroundColor: isDisabled ? Colors.grey.shade600 : Colors.white,
            elevation: isDisabled ? 0 : 2,
          ),
          onPressed: isDisabled ? null : definition.onPressed,
        ),
      );
    }

    // 2. Tombol Outline (Selain Primary & Print)
    // Tombol print juga menggunakan style ini di dalam dropdown, jadi tidak perlu dicek di sini.
    return SizedBox(
      height: 40,
      child: OutlinedButton.icon(
        icon: Icon(meta.icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(
            color: isDisabled
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
          foregroundColor: isDisabled
              ? Colors.grey.shade500
              : Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: isDisabled ? null : definition.onPressed,
      ),
    );
  }
}

class MoreActionsDropdown extends StatelessWidget {
  final List<ActionDefinition> actions;

  const MoreActionsDropdown({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ActionDefinition>(
      offset: const Offset(0, 45),
      onSelected: (definition) {
        if (definition.isEnabled) {
          definition.onPressed();
        }
      },
      itemBuilder: (BuildContext context) {
        return actions.map((definition) {
          final meta = actionButtonMetaMap[definition.type];
          final label = getButtonLabel(context, definition.type);

          return PopupMenuItem<ActionDefinition>(
            value: definition,
            enabled: definition.isEnabled,
            child: Row(
              children: [
                Icon(
                  meta?.icon ?? Icons.error,
                  size: 20,
                  color: definition.isEnabled
                      ? Theme.of(context).colorScheme.onSurface
                      : Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(label),
              ],
            ),
          );
        }).toList();
      },
      // Tombol yang terlihat di toolbar
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          height: 40,
          child: OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.more_vert, size: 18),
            label: const Text('Lainnya'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1.5,
              ),
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              disabledForegroundColor: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
