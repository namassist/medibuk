import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medibuk/presentation/pages/encounter_page.dart';

class CreateNewDialog extends StatefulWidget {
  const CreateNewDialog({super.key});

  @override
  State<CreateNewDialog> createState() => _CreateNewDialogState();
}

class _CreateNewDialogState extends State<CreateNewDialog> {
  final FocusNode _dialogFocusNode = FocusNode();

  final Map<String, Widget> _creatableItems = {
    'Encounter': const EncounterScreen(encounterId: 'NEW'),
    'Business Partner': const EncounterScreen(encounterId: 'NEW'),
    'Update/New Register Patient': const EncounterScreen(encounterId: 'NEW'),
    'Purchase Order': const EncounterScreen(encounterId: 'NEW'),
    'Sales Order': const EncounterScreen(encounterId: 'NEW'),
    'Product': const EncounterScreen(encounterId: 'NEW'),
    'Invoice Vendor': const EncounterScreen(encounterId: 'NEW'),
    'Payment Receipt': const EncounterScreen(encounterId: 'NEW'),
    // 'Medical Record': const MedicalRecordScreen(medicalRecordId: 'NEW'),
  };

  late Map<String, Widget> _filteredList;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _filteredList = _creatableItems;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_dialogFocusNode);
    });
  }

  @override
  void dispose() {
    _dialogFocusNode.dispose();
    super.dispose();
  }

  void _filterList(String query) {
    if (query.isEmpty) {
      _filteredList = _creatableItems;
    } else {
      _filteredList = {};
      _creatableItems.forEach((key, value) {
        if (key.toLowerCase().contains(query.toLowerCase())) {
          _filteredList[key] = value;
        }
      });
    }
    _selectedIndex = 0;
    setState(() {});
  }

  void _navigateTo(Widget page) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          _selectedIndex = (_selectedIndex + 1).clamp(
            0,
            _filteredList.length - 1,
          );
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          _selectedIndex = (_selectedIndex - 1).clamp(
            0,
            _filteredList.length - 1,
          );
        });
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        if (_filteredList.isNotEmpty) {
          _navigateTo(_filteredList.values.toList()[_selectedIndex]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _dialogFocusNode,
      onKeyEvent: _handleKeyEvent,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withAlpha(51),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildSearchField(),
              _buildResultsList(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withAlpha(178),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.add_circle_outline,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Create New',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withAlpha(128),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withAlpha(51),
          ),
        ),
        child: TextField(
          autofocus: true,
          onChanged: _filterList,
          onSubmitted: (text) {
            if (_filteredList.isNotEmpty) {
              _navigateTo(_filteredList.values.first);
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
            hintText: 'Search...',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withAlpha(77),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _filteredList.length,
          itemBuilder: (context, index) {
            final text = _filteredList.keys.toList()[index];
            final page = _filteredList.values.toList()[index];

            final bool isSelected = index == _selectedIndex;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withAlpha(25)
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(77),
                        width: 1,
                      )
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _navigateTo(page),
                  onHover: (isHovering) {
                    if (isHovering) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        if (isSelected)
                          Container(
                            width: 4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        if (isSelected) const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
