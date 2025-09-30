import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/providers/shared_providers.dart';
import 'package:medibuk/presentation/utils/formatter.dart';
import 'package:medibuk/presentation/widgets/core/app_buttons.dart';
import 'package:medibuk/presentation/widgets/core/app_clock.dart';
import 'package:medibuk/presentation/widgets/shared/create_new_dialog.dart';
import 'package:medibuk/presentation/widgets/shared/profile_dropdown.dart';

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
              icon: const Icon(Icons.menu, size: 24),
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
        const ProfileDropdown(),
      ],
    );
  }
}

class _ConnectivityIcon extends ConsumerWidget {
  const _ConnectivityIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(connectivityProvider);

    return connectivityStatus.when(
      data: (result) {
        final bool isConnected =
            !(result.length == 1 && result.first == ConnectivityResult.none);

        final IconData icon = isConnected ? Icons.wifi : Icons.wifi_off;
        final Color color = isConnected
            ? Theme.of(context).colorScheme.primary
            : Colors.grey;
        final Color bgColor = isConnected
            ? Theme.of(context).colorScheme.primaryContainer.withAlpha(77)
            : Colors.grey.shade300;
        final Color borderColor = isConnected
            ? Theme.of(context).colorScheme.primary.withAlpha(51)
            : Colors.grey.shade400;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Icon(icon, color: color, size: 18),
        );
      },
      loading: () => const SizedBox(
        width: 42,
        height: 42,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (err, stack) => const Icon(Icons.error_outline, color: Colors.red),
    );
  }
}

class _ThemeSwitcher extends ConsumerWidget {
  const _ThemeSwitcher();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(appThemeProvider);
    final isDarkMode = currentTheme == ThemeMode.dark;

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
            isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            key: ValueKey(isDarkMode),
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 18,
          ),
        ),
        onPressed: () => ref.read(appThemeProvider.notifier).toggleTheme(),
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
            showDialog(
              context: context,
              builder: (context) => const CreateNewDialog(),
            );
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
      elevation: 1,
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
                AppLiveClock(),
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
