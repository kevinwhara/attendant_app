import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/app/theme/app_theme.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/core/database/database_provider.dart';
import 'package:updated_attendant_app/features/auth/presentation/auth_providers.dart';
import 'package:updated_attendant_app/features/schedule/presentation/schedule_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('Schedule screen displays weekly shifts and holidays', (tester) async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          authProvider.overrideWith(() => _MockAuthNotifier(employee!)),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const ScheduleScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Work Schedule'), findsOneWidget);
    expect(find.text('Regular Weekly Shifts'), findsOneWidget);
    expect(find.text('Monday'), findsOneWidget);
    expect(find.text('Friday'), findsOneWidget);
    expect(find.text('Upcoming Holidays'), findsOneWidget);
    expect(find.text("New Year's Day"), findsOneWidget);

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
