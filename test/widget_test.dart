import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updated_attendant_app/app/app.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('shows the login screen on startup', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AttendantApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Welcome to Attendant'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Sign in to manage your attendance.'), findsOneWidget);
  });
}
