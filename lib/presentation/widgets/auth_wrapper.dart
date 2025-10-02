import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/pages/dashboard_page.dart';
import 'package:medibuk/presentation/pages/login_page.dart';
import 'package:medibuk/presentation/pages/login_roles_page.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  Widget? _currentPage;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    switch (authState.status) {
      case AuthStatus.authenticated:
        _currentPage = const DashboardScreen();
        break;
      case AuthStatus.requiresRoleSelection:
        _currentPage = LoginRolesScreen();
        break;
      case AuthStatus.unauthenticated:
      case AuthStatus.initial:
        _currentPage = const LoginScreen();
        break;
      case AuthStatus.loading:
        _currentPage ??= const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: _currentPage,
    );
  }
}
