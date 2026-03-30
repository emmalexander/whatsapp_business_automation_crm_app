import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/widgets/app_drawer.dart';

class PipelineScreen extends StatelessWidget {
  const PipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      drawer: const AppDrawer(currentIndex: 2),
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
              'Deal Flow',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF141A25),
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking 42 active opportunities across 4 stages.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF3B414E),
              ),
            ),
            const SizedBox(height: 24),

            // Top Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL VALUE',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF5A6678),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$142.8k',
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WIN RATE',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF5A6678),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '24.5%',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F9D58),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Pipeline Columns setup (horizontal scroll ideally, but we will stack them conceptually or build two columns next to each other as shown in the design)
            // The design shows columns. We will try a Row with Expanded columns.
            SizedBox(
              height: 450,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  // Column 1: New Lead
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5A6678),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'New Lead',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF141A25),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5ECFB),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '12',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF3B507C),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.add, color: Color(0xFF5A6678), size: 18),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildPipelineCard(
                          tag: 'FRESH',
                          tagColor: const Color(0xFF3B507C),
                          tagBgColor: const Color(0xFFD3DCF6),
                          name: 'Sarah Jenkins',
                          company: 'Enterprise SaaS Inquiry',
                          dueDate: 'Tomorrow, 10:00 AM',
                          dueColor: const Color(0xFF5A6678),
                          dueIcon: Icons.calendar_today,
                          messages: '3',
                          borderColor: const Color(0xFF5A6678),
                        ),
                        _buildPipelineCard(
                          tag: 'REFERRAL',
                          tagColor: const Color(0xFF3B507C),
                          tagBgColor: const Color(0xFFD3DCF6),
                          name: 'Michael Chen',
                          company: 'Workspace Bundle',
                          dueDate: 'OVERDUE',
                          dueColor: const Color(0xFFB54D31),
                          dueIcon: Icons.warning_amber_rounded,
                          messages: '1',
                          borderColor: const Color(0xFF5A6678),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Column 2: Contacted
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0987D),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Contacted',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF141A25),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5ECFB),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '8',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF3B507C),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildPipelineCard(
                          tag: 'FOLLOW-UP',
                          tagColor: const Color(0xFF7A2011),
                          tagBgColor: const Color(0xFFFBDFD9),
                          name: 'Alex Rivera',
                          company: 'Feature Demo Scheduled',
                          dueDate: 'In 2 hours',
                          dueColor: const Color(0xFF141A25),
                          dueIcon: Icons.access_time_filled,
                          messages: '0',
                          borderColor: const Color(0xFFF0987D),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20, right: 20, top: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Deal Opportunity', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Lead Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Company / Project', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(labelText: 'Value (USD)', border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Due Date', border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opportunity Added successfully!')));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF13BA5E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('SAVE DEAL', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: const Color(0xFF13BA5E),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildPipelineCard({
    required String tag,
    required Color tagColor,
    required Color tagBgColor,
    required String name,
    required String company,
    required String dueDate,
    required Color dueColor,
    required IconData dueIcon,
    required String messages,
    required Color borderColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: tagColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (messages != '0')
                Row(
                  children: [
                    const Icon(Icons.chat_bubble, size: 12, color: Color(0xFF5A6678)),
                    const SizedBox(width: 4),
                    Text(
                      messages,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF141A25),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF141A25),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF5A6678),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(dueIcon, size: 14, color: dueColor),
              const SizedBox(width: 6),
              Text(
                dueDate,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: dueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
