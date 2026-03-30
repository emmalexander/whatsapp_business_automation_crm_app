import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/widgets/app_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      drawer: const AppDrawer(currentIndex: 0),
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
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF13BA5E),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.dashboard, color: Colors.white, size: 14), // placeholder for logo
            ),
            Text(
              'LedgeCRM',
              style: GoogleFonts.inter(
                color: const Color(0xFF141A25),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF141A25)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OVERVIEW DASHBOARD',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8C95A6),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Good morning, Alex.',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF141A25),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'You have 4 follow-ups remaining today.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF5A6678),
              ),
            ),
            const SizedBox(height: 32),

            // Revenue Card
            Container(
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
                          const Icon(Icons.trending_up, color: Color(0xFF13753F), size: 14),
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
            ),
            const SizedBox(height: 20),

            // Metrics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LEADS',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF5A6678),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '1,204',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF141A25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONVERSION',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF5A6678),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '24.8%',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF141A25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Follow-ups section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Follow-ups',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF141A25),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('View all follow-ups')));
                  },
                  child: Text(
                    'VIEW ALL',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF13753F),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open Task: Follow up on Enterprise Proposal')));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: const Border(
                    left: BorderSide(color: Color(0xFF9E3F29), width: 4), // Brown/red border
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD3DCF6),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'JD',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF141A25),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'John Doe',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF141A25),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0987D),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'OVERDUE',
                                  style: GoogleFonts.inter(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF7A2011),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Follow up on Enterprise Proposal',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF5A6678),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message John Doe')));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F8F0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF13BA5E), size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Second Task
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                  left: BorderSide(color: Color(0xFF13BA5E), width: 4), // Green border
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD3DCF6),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'SM',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF141A25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sarah Miller',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF141A25),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC7D3F4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '14:30 PM',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF3B414E),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Schedule demo for team leads',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF5A6678),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F8F0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF13BA5E), size: 18),
                  ),
                ],
              ),
            ),

            // Recent Activities
            Text(
              'Recent Activities',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF141A25),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildActivityRow(Icons.payments, 'Mark as Paid', 'John Doe', '2 MINUTES AGO', const Color(0xFFADDFBF), const Color(0xFF13753F)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Color(0xFFE5E9F1), height: 1),
                  ),
                  _buildActivityRow(Icons.person_add, 'Added New Lead', 'Sarah Miller', '45 MINUTES AGO', const Color(0xFFD3DCF6), const Color(0xFF5A6678)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Color(0xFFE5E9F1), height: 1),
                  ),
                  _buildActivityRow(Icons.edit_note, 'Updated Deal Status', 'TechCorp', '3 HOURS AGO', const Color(0xFFF4D1CE), const Color(0xFF9E3F29)),
                ],
              ),
            ),
            
            const SizedBox(height: 80), // Padding for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text('Add Item'),
              content: const Text('Dashboard quick add action here.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            )
          );
        },
        backgroundColor: const Color(0xFF13BA5E),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
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

  Widget _buildActivityRow(IconData icon, String action, String target, String time, Color iconBgColor, Color iconColor) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$action — ',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF141A25), fontSize: 13),
                    ),
                    TextSpan(
                      text: target,
                      style: GoogleFonts.inter(color: const Color(0xFF141A25), fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5A6678),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
