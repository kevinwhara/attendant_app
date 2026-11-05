import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../data/auth_repository_impl.dart';
import '../domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AuthRepositoryImpl(db);
});

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final Employee? employee;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.employee,
    this.errorMessage,
  });

  const AuthState.initial() : this(status: AuthStatus.initial);
  const AuthState.loading() : this(status: AuthStatus.loading);
  const AuthState.authenticated(Employee employee)
      : this(status: AuthStatus.authenticated, employee: employee);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);
  const AuthState.error(String message)
      : this(status: AuthStatus.error, errorMessage: message);
}

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _restoreSession();
    return const AuthState.initial();
  }

  Future<void> _restoreSession() async {
    try {
      final employee = await _authRepository.getCurrentEmployee();
      if (employee != null) {
        state = AuthState.authenticated(employee);
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<bool> login(String identifier, String password) async {
    if (identifier.trim().isEmpty || password.isEmpty) {
      state = const AuthState.error('Please enter both employee ID/email and password.');
      return false;
    }

    state = const AuthState.loading();
    try {
      final employee = await _authRepository.login(identifier, password);
      if (employee != null) {
        state = AuthState.authenticated(employee);
        return true;
      } else {
        state = const AuthState.error('Invalid credentials. Please check your ID and password.');
        return false;
      }
    } catch (e) {
      state = AuthState.error('Login failed: ${e.toString()}');
      return false;
    }
  }

  void updateEmployee(Employee updated) {
    state = AuthState.authenticated(updated);
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    await _authRepository.logout();
    state = const AuthState.unauthenticated();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    final current = state.employee;
    if (current == null) return false;
    final success = await _authRepository.changePassword(current.id, oldPassword, newPassword);
    if (success) {
      // Re-fetch current employee
      final updated = await _authRepository.getCurrentEmployee();
      if (updated != null) {
        state = AuthState.authenticated(updated);
      }
    }
    return success;
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

final currentEmployeeProvider = Provider<Employee?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.employee;
});
