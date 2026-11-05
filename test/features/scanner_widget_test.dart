import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/app/theme/app_theme.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/core/database/database_provider.dart';
import 'package:updated_attendant_app/core/services/face_detection/face_detection_provider.dart';
import 'package:updated_attendant_app/core/services/face_detection/fake_face_detection_service.dart';
import 'package:updated_attendant_app/features/attendance/presentation/scanner_screen.dart';
import 'package:updated_attendant_app/features/auth/presentation/auth_providers.dart';

void main() {
  late AppDatabase db;
  late FakeFaceDetectionService fakeFaceService;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    fakeFaceService = FakeFaceDetectionService();
  });

  tearDown(() async {
    await db.close();
    await fakeFaceService.dispose();
  });

  testWidgets('Scanner screen displays camera scanner and confirm button', (tester) async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          authProvider.overrideWith(() => _MockAuthNotifier(employee!)),
          faceDetectionServiceProvider.overrideWithValue(fakeFaceService),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const ScannerScreen(actionType: 'checkin'),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Check In Face Scanner'), findsOneWidget);
    // When fakeFaceService is started in postFrameCallback, it detects face
    expect(find.text('Confirm Check In'), findsOneWidget);
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
