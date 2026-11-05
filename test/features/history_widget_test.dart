import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/app/theme/app_theme.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/core/database/database_provider.dart';
import 'package:updated_attendant_app/features/auth/presentation/auth_providers.dart';
import 'package:updated_attendant_app/features/history/presentation/history_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('History screen shows records and detail sheet', (tester) async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    await db.attendanceDao.insertAttendance(
      AttendanceCompanion.insert(
        employeeId: employee!.id,
        attendanceDate: '2026-11-04',
        checkIn: Value(now - 3600 * 8 * 1000),
        checkOut: Value(now),
        checkInFaceDetected: const Value(1),
        checkOutFaceDetected: const Value(1),
        status: 'completed',
        createdAt: now,
        updatedAt: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          authProvider.overrideWith(() => _MockAuthNotifier(employee)),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const HistoryScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Attendance History'), findsOneWidget);
    expect(find.text('2026-11-04'), findsOneWidget);
    expect(find.text('COMPLETED'), findsOneWidget);

    // Tap on card to open bottom sheet detail
    await tester.tap(find.text('2026-11-04'));
    await tester.pumpAndSettle();

    expect(find.text('Attendance Detail — 2026-11-04'), findsOneWidget);
    expect(find.text('Face Detection Check'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });
}

class _MockAuthNotifier extends AuthNotifier {
  final Employee _employee;
  _MockAuthNotifier(this._employee);

  @override
  AuthState build() {
    return AuthState.authenticated(_employee);
  }
}
