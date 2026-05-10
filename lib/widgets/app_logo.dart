import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_business_automation_crm_app/utils/logo_painter.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF13BA5E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CustomPaint(painter: LogoPainter()),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'LedgeCRM',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF141A25),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
