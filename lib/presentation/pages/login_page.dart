import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/config/environment.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';
import 'package:medibuk/presentation/widgets/shared/custom_dialogs.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      if (!mounted) return;
      showStatusDialog(
        context: context,
        type: DialogType.error,
        title: 'Input Tidak Lengkap',
        message: 'Username dan password tidak boleh kosong.',
        buttonText: 'Oke',
      );
      return;
    }

    await ref
        .read(authProvider.notifier)
        .login(
          _usernameController.text.trim(),
          _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      if (previous == null) return;

      final wasLoading = previous.status == AuthStatus.loading;

      if (wasLoading &&
          next.status == AuthStatus.unauthenticated &&
          next.errorMessage != null) {
        if (!mounted) return;
        showStatusDialog(
          context: context,
          type: DialogType.error,
          title: 'Login Gagal',
          message: next.errorMessage!,
          buttonText: 'Coba Lagi',
        );
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 768;
          return isDesktop
              ? Row(
                  children: [
                    const Expanded(flex: 2, child: _LoginImagePanel()),
                    Expanded(
                      flex: 3,
                      child: _LoginForm(
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        onLogin: _login,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: _LoginForm(
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                    onLogin: _login,
                  ),
                );
        },
      ),
    );
  }
}

class _LoginImagePanel extends StatelessWidget {
  const _LoginImagePanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        image: const DecorationImage(
          image: AssetImage("assets/ornamentbg.png"),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Image.asset("assets/pictlogo.png"),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const _LoginForm({
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final logoPath = EnvManager.instance.config.logoPath;
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80, child: Image.asset(logoPath)),
                const SizedBox(height: 24),
                Text(
                  "Selamat Datang di Medibook",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Masuk dengan data yang Anda masukkan saat pendaftaran.",
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: usernameController,
                  autofillHints: const [AutofillHints.username],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => onLogin(),
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: onLogin,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
