import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/attendance/presentation/confirmation_screen.dart';
import '../features/attendance/presentation/scanner_screen.dart';
import '../features/auth/presentation/auth_providers.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/home/presentation/home_shell.dart';
import 'theme/app_theme.dart';

class AuthRefreshListenable extends ChangeNotifier {
  AuthRefreshListenable(Ref ref) {
    ref.listen(authProvider, (_, _) {
      notifyListeners();
    });
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = AuthRefreshListenable(ref);
  ref.onDispose(authNotifier.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final status = authState.status;
      final isLoggingIn = state.matchedLocation == '/login';
      final isSplashing = state.matchedLocation == '/splash';

      // While loading/initializing: never interrupt navigation in progress
      if (status == AuthStatus.initial || status == AuthStatus.loading) {
        if (isSplashing) return null;
        if (isLoggingIn) return null;
        // User may have already navigated to /home – let it be
        return null;
      }

      final isAuthenticated = status == AuthStatus.authenticated;

      if (!isAuthenticated) {
        return isLoggingIn ? null : '/login';
      }

      // Authenticated: bounce away from login/splash
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
              ),
              child: const Center(
                child: Icon(Icons.fact_check_outlined, color: AppColors.primary, size: 28),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Attendant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

