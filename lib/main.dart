import 'package:flutter/material.dart';
import 'package:whatsapp_business_automation_crm_app/screens/onboarding_screen.dart';
import 'package:whatsapp_business_automation_crm_app/theme.dart';

void main() {
  runApp(const LedgeCRMApp());
}

class LedgeCRMApp extends StatelessWidget {
  const LedgeCRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LedgeCRM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingScreen(),
    );
  }
}
