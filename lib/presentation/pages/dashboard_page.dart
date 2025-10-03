import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';
import 'package:medibuk/presentation/providers/dashboard_bidan_provider.dart';
import 'package:medibuk/presentation/providers/dashboard_provider.dart';
import 'package:medibuk/presentation/utils/roles.dart';
import 'package:medibuk/presentation/widgets/auth_interceptor.dart';
import 'package:medibuk/presentation/widgets/core/app_layout.dart';
import 'package:medibuk/presentation/widgets/dashboard/dashboard_admin.dart';
import 'package:medibuk/presentation/widgets/dashboard/dashboard_bidan.dart';
import 'package:medibuk/presentation/widgets/dashboard/dashboard_header.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  void _fetchInitialData() {
    final userRole = ref.read(currentUserRoleProvider);
    if (userRole == Role.admin || userRole == Role.key) {
      ref.read(dashboardProvider.notifier).fetchEncounters();
    } else if (userRole == Role.bidan) {
      ref.read(bidanDashboardProvider.notifier).fetchBidanEncounters();
    }
  }

  Future<void> _refreshData() async {
    final userRole = ref.read(currentUserRoleProvider);
    if (userRole == Role.admin || userRole == Role.key) {
      await ref.read(dashboardProvider.notifier).fetchEncounters();
    } else if (userRole == Role.bidan) {
      await ref.read(bidanDashboardProvider.notifier).fetchBidanEncounters();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRole = ref.watch(currentUserRoleProvider);

    return AuthInterceptor(
      child: AppLayout(
        pageTitle: 'Dashboard',
        onRefresh: _refreshData,
        slivers: [
          if (userRole == Role.admin || userRole == Role.key)
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchBarDelegate(),
            ),
          _buildDashboardByRole(userRole),
        ],
      ),
    );
  }

  Widget _buildDashboardByRole(Role role) {
    switch (role) {
      case Role.key:
      case Role.admin:
        return const SliverToBoxAdapter(child: DashboardAdmin());
      case Role.bidan:
        return const SliverToBoxAdapter(child: DashboardBidan());
      default:
        return const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        );
    }
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class EmptyDashboard extends StatelessWidget {
  const EmptyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            "New Day, New Service",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 400,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              image: const DecorationImage(
                image: AssetImage("assets/ornamentbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/pictlogo.png",
                width: MediaQuery.of(context).size.width * .3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
