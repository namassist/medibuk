import 'package:flutter/material.dart';
import 'package:medibuk/presentation/utils/formatter.dart';
import 'package:medibuk/presentation/widgets/core/app_buttons.dart';

class AppToolbar extends StatelessWidget {
  final String? title;
  final DocumentStatus? status;
  final Function? onRefresh;
  final List<Widget>? actions;

  const AppToolbar({
    super.key,
    this.title,
    this.status,
    this.onRefresh,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(16.0), child: _TopBarSection()),
          if (title != null)
            _ToolbarTitleSection(
              title: title!,
              status: status,
              onRefresh: onRefresh,
            ),
          if (actions != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(children: actions!),
            ),
        ],
      ),
    );
  }
}

class _TopBarSection extends StatelessWidget {
  const _TopBarSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(width: 12),
            Text(
              'Medibook',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const _ToolbarActions(),
      ],
    );
  }
}

class _ToolbarActions extends StatelessWidget {
  const _ToolbarActions();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _ConnectivityIcon(),
        const SizedBox(width: 12),
        const _ThemeSwitcher(),
        const SizedBox(width: 12),
        if (screenWidth >= 1024) const _DesktopLanguageSwitcher(),
        if (screenWidth < 1024) const _MobileLanguageSwitcher(),
        const SizedBox(width: 16),
        const _CreateNewButton(),
        const SizedBox(width: 16),
        const _ProfileChip(name: 'SuperAnaam'),
      ],
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final String name;
  const _ProfileChip({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 14, child: Icon(Icons.person, size: 16)),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class _ConnectivityIcon extends StatelessWidget {
  const _ConnectivityIcon();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(77),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(51),
          width: 1,
        ),
      ),
      child: Icon(
        Icons.wifi,
        color: Theme.of(context).colorScheme.primary,
        size: 18,
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withAlpha(178),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withAlpha(51),
          width: 1,
        ),
      ),
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              RotationTransition(turns: animation, child: child),
          child: Icon(
            Icons.light_mode_outlined,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 18,
          ),
        ),
        onPressed: () async {},
        tooltip: "Switch Theme",
      ),
    );
  }
}

class _DesktopLanguageSwitcher extends StatelessWidget {
  const _DesktopLanguageSwitcher();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withAlpha(204),
            Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withAlpha(153),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withAlpha(77),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.outline.withAlpha(77),
                  Theme.of(context).colorScheme.outline.withAlpha(25),
                  Theme.of(context).colorScheme.outline.withAlpha(77),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileLanguageSwitcher extends StatelessWidget {
  const _MobileLanguageSwitcher();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withAlpha(178),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withAlpha(51),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.language, size: 20),
                SizedBox(width: 6),
                Text(
                  "ID",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateNewButton extends StatelessWidget {
  const _CreateNewButton();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withAlpha(204),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Logika untuk menampilkan dialog
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? 16 : 12,
              vertical: 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (screenWidth >= 1024) ...[
                  Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Create New",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ] else ...[
                  Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolbarTitleSection extends StatelessWidget {
  final String title;
  final DocumentStatus? status;
  final Function? onRefresh;

  const _ToolbarTitleSection({
    required this.title,
    this.status,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (onRefresh != null)
                            AppButton(
                              icon: Icons.refresh,
                              width: 100,
                              text: '',
                              onPressed: () {
                                onRefresh!();
                              },
                            ),
                          const SizedBox(width: 8),
                          if (status != null) ...[
                            const SizedBox(width: 4),
                            _DocumentStatusChip(status: status!),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width > 600) ? 32 : 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentStatusChip extends StatelessWidget {
  final DocumentStatus status;

  const _DocumentStatusChip({required this.status});

  String _getStatusText(DocumentStatus status) {
    final statusID = getDocumentStatusID(status);

    switch (statusID) {
      case "DR":
        return "Drafted";
      case "IP":
        return "In Progress";
      case "CO":
        return "Completed";
      case "IN":
        return "Invalid";
      case "VO":
        return "Voided";
      default:
        return "";
    }
  }

  Color _getStatusColor(DocumentStatus status, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case DocumentStatus.drafted:
        return colorScheme.primary;
      case DocumentStatus.inprogress:
        return colorScheme.secondary;
      case DocumentStatus.complete:
        return colorScheme.tertiary;
      case DocumentStatus.invalid:
        return colorScheme.error;
      case DocumentStatus.voided:
        return colorScheme.onSurface.withAlpha(128);
    }
  }

  IconData _getStatusIcon(DocumentStatus status) {
    // ... (logika getStatusIcon)
    switch (status) {
      case DocumentStatus.drafted:
        return Icons.drafts;
      case DocumentStatus.inprogress:
        return Icons.hourglass_empty;
      case DocumentStatus.complete:
        return Icons.check_circle;
      case DocumentStatus.invalid:
        return Icons.error;
      case DocumentStatus.voided:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getStatusColor(status, context).withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(status),
            color: _getStatusColor(status, context),
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            _getStatusText(status),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getStatusColor(status, context),
            ),
          ),
        ],
      ),
    );
  }
}
