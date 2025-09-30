import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/pages/dashboard_page.dart';
import 'package:medibuk/presentation/pages/login_page.dart';
import 'package:medibuk/presentation/pages/login_roles_page.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    switch (authState.status) {
      case AuthStatus.authenticated:
        return const DashboardScreen();
      case AuthStatus.requiresRoleSelection:
        return LoginRoleScreen(loginData: authState.roleSelectionData!);
      case AuthStatus.unauthenticated:
        return const LoginScreen();
      case AuthStatus.loading:
      case AuthStatus.initial:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
