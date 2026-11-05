import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/attendance/presentation/confirmation_screen.dart';
import '../features/attendance/presentation/scanner_screen.dart';
import '../features/auth/presentation/auth_providers.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/home/presentation/home_shell.dart';
import 'theme/app_theme.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final status = authState.status;
      final isLoggingIn = state.matchedLocation == '/login';
      final isSplashing = state.matchedLocation == '/splash';

      if (status == AuthStatus.initial || status == AuthStatus.loading) {
        return isSplashing ? null : '/splash';
      }

      final isAuthenticated = status == AuthStatus.authenticated;

      if (!isAuthenticated) {
        return isLoggingIn ? null : '/login';
      }

      if (isLoggingIn || isSplashing) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeShell(initialIndex: 0),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HomeShell(initialIndex: 1),
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const HomeShell(initialIndex: 2),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const HomeShell(initialIndex: 3),
      ),
      GoRoute(
        path: '/attendance',
        redirect: (context, state) => '/home',
      ),
      GoRoute(
        path: '/attendance/scanner',
        builder: (context, state) {
          final type = state.uri.queryParameters['type'] ?? 'checkin';
          return ScannerScreen(actionType: type);
        },
      ),
      GoRoute(
        path: '/attendance/confirmation',
        builder: (context, state) {
          final type = state.uri.queryParameters['type'] ?? 'checkin';
          return ConfirmationScreen(actionType: type);
        },
      ),
    ],
  );
});

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fact_check_outlined, color: AppColors.primary, size: 54),
            SizedBox(height: 16),
            Text(
              'Attendant',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
