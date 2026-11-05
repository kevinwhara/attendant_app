import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/app/theme/app_theme.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/core/database/database_provider.dart';
import 'package:updated_attendant_app/features/auth/presentation/auth_providers.dart';
import 'package:updated_attendant_app/features/dashboard/presentation/dashboard_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('Dashboard renders employee name and attendance cards', (tester) async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          authProvider.overrideWith(() => _MockAuthNotifier(employee!)),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const DashboardScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Hello, Demo Employee'), findsOneWidget);
    expect(find.text("Today's Attendance"), findsOneWidget);
    expect(find.text('Check In via Face Scanner'), findsOneWidget);

    // Unmount and flush drift stream cleanup timers
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 2));
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
