import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_business_automation_crm_app/main.dart';

void main() {
  testWidgets('App launches correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const LedgeCRMApp());
    expect(find.text('LedgeCRM'), findsWidgets);
  });
}
