import 'package:flutter/material.dart';
import 'package:whatsapp_business_automation_crm_app/screens/onboarding/onboarding_screen.dart';
import 'package:whatsapp_business_automation_crm_app/theme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: LedgeCRMApp(),
    ),
  );
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
