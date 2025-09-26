import 'package:flutter/material.dart';
import 'package:medibuk/presentation/widgets/core/app_drawer.dart';
import 'package:medibuk/presentation/widgets/core/app_toolbar.dart';
import 'package:medibuk/presentation/utils/formatter.dart';

class AppLayout extends StatelessWidget {
  final List<Widget> slivers;
  final String? pageTitle;
  final DocumentStatus? pageStatus;
  final Function? onRefresh;
  final List<Widget>? pageActions;

  const AppLayout({
    super.key,
    this.slivers = const [],
    this.pageTitle,
    this.pageStatus,
    this.onRefresh,
    this.pageActions,
  });

  @override
  Widget build(BuildContext context) {
    final double toolbarHeight = (pageActions != null) ? 245 : 180;

    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedHeaderDelegate(
              minExtentHeight: toolbarHeight,
              maxExtentHeight: toolbarHeight,
              child: AppToolbar(
                title: pageTitle,
                status: pageStatus,
                onRefresh: onRefresh,
                actions: pageActions,
              ),
            ),
          ),
          ...slivers,
        ],
      ),
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtentHeight;
  final double maxExtentHeight;
  final Widget child;

  _PinnedHeaderDelegate({
    required this.minExtentHeight,
    required this.maxExtentHeight,
    required this.child,
  });

  @override
  double get minExtent => minExtentHeight;

  @override
  double get maxExtent => maxExtentHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: maxExtent,
      child: Container(color: Colors.white, child: child),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) {
    return true;
  }
}
