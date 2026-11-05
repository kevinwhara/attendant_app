import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/app/app.dart';

void main() {
  testWidgets('shows the attendance dashboard', (tester) async {
    await tester.pumpWidget(const AttendantApp());

    expect(find.text('Welcome to Attendant'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });
}
