import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import 'auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _idController = TextEditingController(text: 'EMP001');
  final _passwordController = TextEditingController(text: 'Attendant123!');
  bool _obscure = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final messenger = ScaffoldMessenger.of(context);
    final success = await ref.read(authProvider.notifier).login(
      _idController.text,
      _passwordController.text,
    );
    if (success && mounted) {
      context.go('/home');
    } else if (!success && mounted) {
      final error = ref.read(authProvider).errorMessage ?? 'Login failed';
      messenger.showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.primaryDark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Brand Header
                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: AppRadius.borderRadiusLg,
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.fact_check_outlined,
                          color: AppColors.primary,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Welcome to Attendant',
                    textAlign: TextAlign.center,
                    style: AppTypography.pageTitle,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Sign in to manage your attendance.',
                    textAlign: TextAlign.center,
                    style: AppTypography.supporting,
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Login Form Card
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.xxl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _idController,
                          decoration: const InputDecoration(
                            labelText: 'Employee ID or email',
                            prefixIcon: Icon(Icons.person_outline, size: 20, color: AppColors.textSecondary),
                          ),
                          enabled: !isLoading,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          onSubmitted: (_) => _handleLogin(),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        FilledButton(
                          onPressed: isLoading ? null : _handleLogin,
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Sign in'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Demo Credentials Info Box
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSecondary,
                      borderRadius: AppRadius.borderRadiusMd,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Text(
                      'Demo account: EMP001 / Attendant123!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
