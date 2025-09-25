import 'package:flutter/material.dart';
import 'package:medibuk/presentation/widgets/core/app_drawer.dart';
import 'package:medibuk/presentation/widgets/core/app_toolbar.dart';
import 'package:medibuk/presentation/utils/formatter.dart';

class AppLayout extends StatelessWidget {
  final Widget body;
  final String? pageTitle;
  final DocumentStatus? pageStatus;
  final Function? onRefresh;
  final List<Widget>? pageActions;

  const AppLayout({
    super.key,
    required this.body,
    this.pageTitle,
    this.pageStatus,
    this.onRefresh,
    this.pageActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedHeaderDelegate(
              minExtentHeight: 240,
              maxExtentHeight: 240,
              child: AppToolbar(
                title: pageTitle,
                status: pageStatus,
                onRefresh: onRefresh,
                actions: pageActions,
              ),
            ),
          ),
          SliverFillRemaining(hasScrollBody: true, child: body),
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
