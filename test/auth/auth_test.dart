import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/features/auth/data/auth_repository_impl.dart';

void main() {
  late AppDatabase db;
  late AuthRepositoryImpl authRepository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory());
    authRepository = AuthRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Login succeeds with valid credentials (EMP001 / Attendant123!)', () async {
    final employee = await authRepository.login('EMP001', 'Attendant123!');
    expect(employee, isNotNull);
    expect(employee!.employeeCode, equals('EMP001'));
    expect(employee.email, equals('employee@attendant.local'));

    // Session persisted
    final current = await authRepository.getCurrentEmployee();
    expect(current, isNotNull);
    expect(current!.id, equals(employee.id));
  });

  test('Login succeeds with case-insensitive / hyphenated code (emp-001)', () async {
    final employee = await authRepository.login('emp-001', 'Attendant123!');
    expect(employee, isNotNull);
    expect(employee!.employeeCode, equals('EMP001'));
  });

  test('Login fails with invalid password', () async {
    final employee = await authRepository.login('EMP001', 'WrongPassword!');
    expect(employee, isNull);

    final current = await authRepository.getCurrentEmployee();
    expect(current, isNull);
  });

  test('Login fails with nonexistent employee', () async {
    final employee = await authRepository.login('UNKNOWN_USER', 'Attendant123!');
    expect(employee, isNull);
  });

  test('Logout clears the saved session', () async {
    await authRepository.login('EMP001', 'Attendant123!');
    expect(await authRepository.getCurrentEmployee(), isNotNull);

    await authRepository.logout();
    expect(await authRepository.getCurrentEmployee(), isNull);
  });
}

