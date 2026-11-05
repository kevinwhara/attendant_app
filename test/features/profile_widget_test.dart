import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/app/theme/app_theme.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/core/database/database_provider.dart';
import 'package:updated_attendant_app/features/auth/presentation/auth_providers.dart';
import 'package:updated_attendant_app/features/profile/presentation/profile_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('Profile screen displays employee details and edit dialog', (tester) async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          authProvider.overrideWith(() => _MockAuthNotifier(employee!)),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const ProfileScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Demo Employee'), findsOneWidget);
    expect(find.text('Engineering'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);

    // Scroll down and tap on Edit Information
    await tester.scrollUntilVisible(find.text('Edit Information'), 100);
    await tester.tap(find.text('Edit Information'));
    await tester.pumpAndSettle();

    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

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
