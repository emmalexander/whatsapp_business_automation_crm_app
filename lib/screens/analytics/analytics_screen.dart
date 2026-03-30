import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/widgets/app_drawer.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      drawer: const AppDrawer(currentIndex: 4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9FB),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF141A25)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Text(
              'LedgeCRM',
              style: GoogleFonts.inter(
                color: const Color(0xFF0F9D58),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFF141A25),
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'PERFORMANCE OVERVIEW',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF5A6678),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Analytics',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF141A25),
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 24),

            // Time filter toggle
            // Container(
            //   height: 44,
            //   padding: const EdgeInsets.all(4),
            //   decoration: BoxDecoration(
            //     color: const Color(0xFFF3F5FA),
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.black.withOpacity(0.04),
            //                 blurRadius: 4,
            //                 offset: const Offset(0, 2),
            //               ),
            //             ],
            //           ),
            //           child: InkWell(
            //             onTap: () {
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 const SnackBar(
            //                   content: Text('Weekly view selected'),
            //                 ),
            //               );
            //             },
            //             child: Center(
            //               child: Text(
            //                 'Weekly',
            //                 style: GoogleFonts.inter(
            //                   fontSize: 13,
            //                   fontWeight: FontWeight.w700,
            //                   color: const Color(0xFF13753F),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                 content: Text('Monthly view selected'),
            //               ),
            //             );
            //           },
            //           child: Center(
            //             child: Text(
            //               'Monthly',
            //               style: GoogleFonts.inter(
            //                 fontSize: 13,
            //                 fontWeight: FontWeight.w600,
            //                 color: const Color(0xFF5A6678),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                 content: Text('Custom range selected'),
            //               ),
            //             );
            //           },
            //           child: Center(
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text(
            //                   'Custom',
            //                   style: GoogleFonts.inter(
            //                     fontSize: 13,
            //                     fontWeight: FontWeight.w600,
            //                     color: const Color(0xFF5A6678),
            //                   ),
            //                 ),
            //                 const SizedBox(width: 4),
            //                 const Icon(
            //                   Icons.calendar_today,
            //                   size: 12,
            //                   color: Color(0xFF5A6678),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 24),

            // Growth Insight Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F8F0),
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                  left: BorderSide(color: Color(0xFF13753F), width: 4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF13BA5E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Growth Insight',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF141A25),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Conversion is up '),
                              TextSpan(
                                text: '12.4%',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF13753F),
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' this month! Your fastest response time is now under 4 minutes on WhatsApp leads.',
                              ),
                            ],
                          ),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF3B414E),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Vertical list of small metrics
            _buildMetricCard('TOTAL LEADS', '1,284', '+14%', isPos: true),
            _buildMetricCard('CONV. RATE', '18.2%', '+2.1%', isPos: true),
            _buildMetricCard('AVG REVENUE', '\$4.2k', '-3%', isPos: false),

            // Met vs Overdue specific card
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MET VS OVERDUE',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF5A6678),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '94%',
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF141A25),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF13BA5E),
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Monthly Revenue Chart
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
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
                        'Monthly Revenue',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF141A25),
                        ),
                      ),
                      Row(
                        children: [
                          _buildLegendDot(
                            const Color(0xFF13753F),
                            'Closed Deals',
                          ),
                          const SizedBox(width: 12),
                          _buildLegendDot(
                            const Color(0xFFC0E8D0),
                            'Projections',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStackedBar(60, 20, 'JAN'),
                        _buildStackedBar(75, 25, 'FEB'),
                        _buildStackedBar(110, 30, 'MAR'),
                        _buildStackedBar(130, 20, 'APR'),
                        _buildStackedBar(90, 40, 'MAY'),
                        _buildStackedBar(140, 25, 'JUN'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Follow-up Performance
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Follow-up Performance',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF141A25),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: CircularProgressIndicator(
                            value: 0.94,
                            strokeWidth: 16,
                            backgroundColor: const Color(0xFFD4DBF3),
                            color: const Color(0xFF13753F),
                            strokeCap: StrokeCap.round,
                          ),
                        ),

                        // Overlay brown indicator manually or assume simple
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '94%',
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF141A25),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'HEALTH',
                              style: GoogleFonts.inter(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF8C95A6),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildListLegendItem(const Color(0xFF13753F), 'Met', '412'),
                  const SizedBox(height: 12),
                  _buildListLegendItem(
                    const Color(0xFF9E3F29),
                    'Overdue',
                    '28',
                  ),
                  const SizedBox(height: 12),
                  _buildListLegendItem(
                    const Color(0xFFD4DBF3),
                    'Pending',
                    '65',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Total Leads Over Time
            Container(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Leads Over Time',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF141A25),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Growth of inbound CRM queries from all\nchannels.',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: const Color(0xFF5A6678),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Row(
                          children: [
                            Text(
                              'Export\nReport',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF13753F),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.file_download_outlined,
                              color: Color(0xFF13753F),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: const Size(double.infinity, 150),
                          painter: LineChartPainter(),
                        ),
                        // Tooltip mock for May 24
                        Positioned(
                          right: 60,
                          top: 40,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF141A25),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'May 24',
                                  style: GoogleFonts.inter(
                                    fontSize: 9,
                                    color: const Color(0xFFD3DCF6),
                                  ),
                                ),
                                Text(
                                  '842 Leads',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // X axis labels
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'JAN',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  color: const Color(0xFF8C95A6),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'FEB',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  color: const Color(0xFF8C95A6),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'MAR',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  color: const Color(0xFF8C95A6),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'APR',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  color: const Color(0xFF8C95A6),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'MAY',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  color: const Color(0xFF8C95A6),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'JUN',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  color: const Color(0xFF8C95A6),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String val,
    String pct, {
    required bool isPos,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF5A6678),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    val,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF141A25),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    pct,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isPos
                          ? const Color(0xFF13753F)
                          : const Color(0xFFB54D31),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF5A6678),
          ),
        ),
      ],
    );
  }

  Widget _buildListLegendItem(Color dotCol, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: dotCol, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF5A6678),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF141A25),
          ),
        ),
      ],
    );
  }

  Widget _buildStackedBar(double h1, double h2, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          decoration: const BoxDecoration(
            color: Color(0xFFC0E8D0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          height: h2,
        ),
        Container(
          width: 32,
          decoration: const BoxDecoration(
            color: Color(0xFF13753F),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          height: h1,
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8C95A6),
          ),
        ),
      ],
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF13753F)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF13753F).withValues(alpha: 51),
          const Color(0xFF13753F).withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.6,
      size.width * 0.3,
      size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.9,
      size.width * 0.6,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      -size.height * 0.2,
      size.width,
      size.height * 0.3,
    );

    // Fill path
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
