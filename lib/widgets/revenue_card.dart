import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL REVENUE',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF5A6678),
                  letterSpacing: 1,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up,
                    color: Color(0xFF13753F),
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+12%',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF13753F),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$124,500',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF141A25),
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'USD',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF5A6678),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Bar Chart mock
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBar(40, const Color(0xFFD2F0DF)),
              _buildBar(55, const Color(0xFFADDFBF)),
              _buildBar(48, const Color(0xFFC0E8D0)),
              _buildBar(65, const Color(0xFF75D19A)),
              _buildBar(85, const Color(0xFF13753F)),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildBar(double height, Color color) {
  return Container(
    width: 56,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}
