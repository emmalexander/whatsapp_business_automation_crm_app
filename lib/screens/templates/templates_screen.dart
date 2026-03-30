import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/widgets/app_drawer.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      drawer: const AppDrawer(currentIndex: 3),
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
              'Templates',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF141A25),
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Streamline your WhatsApp workflow with architectural\nprecision.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF141A25),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Search Bar
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFDFE6F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search, color: Color(0xFF5A6678), size: 18),
                  const SizedBox(width: 12),
                  Text(
                    'Search templates by keyword...',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF5A6678),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Filters
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('All'),
                  _buildFilterChip('Greeting'),
                  _buildFilterChip('Pricing'),
                  _buildFilterChip('Closing'),
                  _buildFilterChip('Follow-up'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Templates List
            if (_selectedFilter == 'All' || _selectedFilter == 'Greeting')
              _buildTemplateCard(
                tag: 'GREETING',
                tagBgCol: const Color(0xFFD3DCF6),
                tagTextCol: const Color(0xFF3B507C),
                title: 'Initial Discovery',
                text: '"Hi {{name}}, thanks for reaching out! I\'d love to learn more about your project needs. Do you have 10 minutes for a quick call today?"',
                borderCol: const Color(0xFF13753F),
              ),

            if (_selectedFilter == 'All' || _selectedFilter == 'Pricing')
              _buildTemplateCard(
                tag: 'PRICING',
                tagBgCol: const Color(0xFFF0987D),
                tagTextCol: const Color(0xFF7A2011),
                title: 'Standard Quote',
                text: '"Based on our discussion, the estimated investment for the {{service_type}} package is \${{amount}}. This includes full support and implementation."',
                borderCol: const Color(0xFFB54D31),
              ),

            if (_selectedFilter == 'All' || _selectedFilter == 'Follow-up')
              _buildTemplateCard(
                tag: 'FOLLOW-UP',
                tagBgCol: const Color(0xFFD3DCF6),
                tagTextCol: const Color(0xFF3B507C),
                title: 'Gentle Re-engagement',
                text: '"Just circling back to see if you had any more thoughts on the proposal I sent last week? Happy to clarify any points!"',
                borderCol: const Color(0xFF5A6678),
              ),

            if (_selectedFilter == 'All' || _selectedFilter == 'Closing')
              _buildTemplateCard(
                tag: 'CLOSING',
                tagBgCol: const Color(0xFF6EFA89),
                tagTextCol: const Color(0xFF0C7D38),
                title: 'Onboarding Next Steps',
                text: '"Great news! Everything is ready. Here is your unique onboarding link: {{onboarding_url}}. Welcome aboard!"',
                borderCol: const Color(0xFF10C05C),
              ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Open Template Builder')),
          );
        },
        backgroundColor: const Color(0xFF13BA5E),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isActive = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF13753F) : const Color(0xFFF3F5FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : const Color(0xFF141A25),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateCard({
    required String tag,
    required Color tagBgCol,
    required Color tagTextCol,
    required String title,
    required String text,
    required Color borderCol,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: borderCol, width: 4)),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: tagBgCol,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              tag,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: tagTextCol,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF141A25),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF3B414E),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Template copied to clipboard')),
                    );
                  },
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5ECFB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.copy, size: 14, color: Color(0xFF141A25)),
                        const SizedBox(width: 8),
                        Text(
                          'COPY',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF141A25),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sending Template...')),
                    );
                  },
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF13BA5E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.send, size: 14, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'SEND',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
