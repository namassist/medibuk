import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';
import 'package:medibuk/presentation/providers/profile_provider.dart';
import 'package:medibuk/presentation/widgets/shared/custom_dialogs.dart';

class AuthInterceptor extends ConsumerStatefulWidget {
  final Widget child;
  const AuthInterceptor({super.key, required this.child});

  @override
  ConsumerState<AuthInterceptor> createState() => _AuthInterceptorState();
}

class _AuthInterceptorState extends ConsumerState<AuthInterceptor> {
  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(warehouseAccessValidatorProvider, (previous, next) {
      final bool hasError =
          next.hasError || (next.hasValue && !next.requireValue);

      if (hasError && !_isDialogShowing) {
        setState(() {
          _isDialogShowing = true;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showStatusDialog(
            context: context,
            type: DialogType.error,
            title: 'Akses Ditolak',
            message: 'Anda tidak memiliki akses ke warehouse ini.',
            buttonText: 'Oke',
            onButtonPressed: () {
              ref.read(authProvider.notifier).logout(withUserProfile: true);
              setState(() {
                _isDialogShowing = false;
              });
            },
          );
        });
      }
    });
    final authState = ref.watch(warehouseAccessValidatorProvider);
    return authState.when(
      data: (hasAccess) => hasAccess ? widget.child : const _LoadingScreen(),
      loading: () => const _LoadingScreen(),
      error: (error, stack) => const _LoadingScreen(),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
