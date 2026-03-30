import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/screens/templates/templates_screen.dart' as whatsapp_business_automation_crm_app;

class LeadProfileScreen extends StatelessWidget {
  const LeadProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F9D58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Lead Profile',
          style: GoogleFonts.inter(
            color: const Color(0xFF0F9D58),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
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
          children: [
            const SizedBox(height: 24),
            // Profile Image
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      color: const Color(0xFFD3DCF6),
                    ),
                    child: const ClipOval(
                      child: Icon(Icons.person, size: 64, color: Colors.white),
                      // Ideally network image here: NetworkImage('https://i.pravatar.cc/150?img=11')
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF13BA5E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Alexander Mitchell',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF141A25),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, color: Color(0xFF5A6678), size: 14),
                const SizedBox(width: 8),
                Text(
                  '+1 (555) 928-0431',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF5A6678),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFBDFD9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.sync_alt, color: Color(0xFF7A2011), size: 12),
                  const SizedBox(width: 6),
                  Text(
                    'NEGOTIATING',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF7A2011),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.keyboard_arrow_down, color: Color(0xFF7A2011), size: 14),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons Row
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(context, Icons.chat_bubble_rounded, 'WHATSAPP', true),
                  _buildActionButton(context, Icons.phone, 'CALL', false),
                  _buildActionButton(context, Icons.label, 'EDIT TAG', false),
                  _buildActionButton(context, Icons.calendar_today, 'SCHEDULE', false),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Use Templates Card
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const whatsapp_business_automation_crm_app.TemplatesScreen()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3DCF6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.auto_awesome, color: Color(0xFF3B507C), size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Use Templates',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF141A25),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quick reply with saved scripts',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF5A6678),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF141A25)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Upcoming Follow-up
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                  left: BorderSide(color: Color(0xFFB54D31), width: 4),
                ),
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
                        'UPCOMING FOLLOW-UP',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF8C95A6),
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        'In 2 hours',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF5A6678),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Contract Review Call',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF141A25),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discuss the pricing tier adjustments for the Q3 enterprise package.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF5A6678),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Active Notes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Notes',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF141A25),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit Note')));
                  },
                  child: Text(
                    'EDIT',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF13BA5E),
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"Interested in the full suite but concerned about the migration timeline. Mentioned they have 40+ agents currently on legacy software. High priority for conversion."',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF3B414E),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildNoteChip('Migration Concern'),
                      _buildNoteChip('Enterprise'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Timeline
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Timeline',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF141A25),
                  ),
                ),
                const Icon(Icons.filter_list, color: Color(0xFF5A6678)),
              ],
            ),
            const SizedBox(height: 20),
            
            _buildTimelineItem(
              type: 'WHATSAPP MESSAGE',
              time: 'Yesterday, 4:20 PM',
              content: '"Thanks for the breakdown, Alexander. I\'ll review the PDF with my team tonight."',
              iconColor: const Color(0xFF13BA5E),
              isLast: false,
            ),
            _buildTimelineItem(
              type: 'OUTBOUND CALL',
              time: 'Aug 14, 11:05 AM',
              content: 'Duration: 12m 45s. Discussed the API documentation and third-party integrations.',
              iconColor: const Color(0xFF3B507C),
              isLast: false,
            ),
            _buildTimelineItem(
              type: 'LEAD CREATED',
              time: 'Aug 10, 9:00 AM',
              content: 'Inbound inquiry from landing page: Enterprise CRM Campaign.',
              iconColor: const Color(0xFF8C95A6),
              isLast: true,
              isFadedContent: true,
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, bool isPrimary) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Action: $label')));
      },
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isPrimary ? const Color(0xFF13BA5E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!isPrimary) 
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : const Color(0xFF141A25),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF5A6678),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF141A25),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String type,
    required String time,
    required String content,
    required Color iconColor,
    required bool isLast,
    bool isFadedContent = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: const Color(0xFFD3DCF6),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                        type,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF8C95A6),
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8C95A6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isFadedContent ? const Color(0xFF8C95A6) : const Color(0xFF141A25),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
