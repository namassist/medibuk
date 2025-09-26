import 'package:flutter/material.dart';
import 'package:medibuk/presentation/widgets/core/app_layout.dart';
import 'package:medibuk/presentation/widgets/dashboard/dashboard_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      pageTitle: 'Dashboard',
      onRefresh: () {},
      slivers: [
        SliverPersistentHeader(pinned: true, delegate: _SearchBarDelegate()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              children: [
                const StatCard(
                  icon: Icons.calendar_today_outlined,
                  title: 'Total Registrations',
                  count: '0',
                ),
                const StatCard(
                  icon: Icons.calendar_today_outlined,
                  title: 'Online Booking',
                  count: '0',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return const SearchBarField();
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
