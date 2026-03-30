import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/widgets/app_drawer.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      drawer: const AppDrawer(currentIndex: 5),
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Scale your '),
                  TextSpan(
                    text: 'WhatsApp ',
                    style: TextStyle(color: const Color(0xFF0F9D58)),
                  ),
                  const TextSpan(text: 'flow.'),
                ],
              ),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF141A25),
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Move beyond the basics. Unlock professional tools designed for high-velocity sales and architectural clarity.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF3B414E),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Free Plan Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3DCF6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'CURRENT PLAN',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF3B507C),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Free',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF141A25),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Essential for solo starters',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF5A6678),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureItem('5 Tags', isActive: true),
                  _buildFeatureItem('3 Templates', isActive: true),
                  _buildFeatureItem('Basic Analytics', isActive: true),
                  _buildFeatureItem('Priority Reminders', isActive: false),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Manage plan...')));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF8C95A6)),
                      ),
                      child: Center(
                        child: Text(
                          'MANAGE CURRENT',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF141A25),
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Professional Plan Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: const Border(left: BorderSide(color: Color(0xFF13BA5E), width: 4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF13BA5E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'RECOMMENDED',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$15',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF13753F),
                            ),
                          ),
                          Text(
                            'PER MONTH',
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF141A25),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Professional',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF141A25),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Built for high-end operations',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF5A6678),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureItem('Unlimited Tags', isActive: true, isPro: true),
                  _buildFeatureItem('Unlimited Templates', isActive: true, isPro: true),
                  _buildFeatureItem('Priority Reminders', isActive: true, isPro: true),
                  _buildFeatureItem('Advanced Analytics', isActive: true, isPro: true),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Upgrade...')));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF13BA5E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'UPGRADE NOW',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Secure checkout. Cancel anytime with one click.',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFF5A6678),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Team Account Add-on
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(16),
                border: const Border(left: BorderSide(color: Color(0xFF7A2011), width: 4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0987D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.people_alt, color: Color(0xFF7A2011)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Team Account Add-on',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF141A25),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Empower your entire agency with shared pipelines.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF5A6678),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              '\$5',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF7A2011),
                              ),
                            ),
                            Text(
                              '/agent',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF141A25),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adding agents...')));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD3DCF6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'ADD AGENTS',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF3B507C),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Footer badging
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFooterBadge(Icons.lock, 'SSL ENCRYPTED'),
                _buildFooterBadge(Icons.calendar_today, 'MONTHLY BILLING'),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFooterBadge(Icons.shield, 'DATA PRIVACY'),
                _buildFooterBadge(Icons.support_agent, '24/7 PRIORITY'),
              ],
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, {required bool isActive, bool isPro = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isActive 
                  ? (isPro ? const Color(0xFF13BA5E) : const Color(0xFF8C95A6))
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive ? Icons.check : Icons.block,
              size: 14,
              color: isActive ? Colors.white : const Color(0xFF8C95A6),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? const Color(0xFF141A25) : const Color(0xFF8C95A6),
              decoration: isActive ? TextDecoration.none : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF5A6678)),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF5A6678),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
