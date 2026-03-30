import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/screens/main_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_currentPage == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkipTap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Logo
            Row(
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
            ),
            const SizedBox(height: 48),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPageContent(
                    headlineRow1: 'Master your',
                    headlineRow2: 'WhatsApp ',
                    headlineRow3: 'sales.',
                    subtitle:
                        'The architectural ledger for high-\nperformance sales teams.',
                    visual: _buildPage1Visual(),
                  ),
                  _buildPageContent(
                    headlineRow1: 'Streamline your',
                    headlineRow2: 'Pipeline ',
                    headlineRow3: 'deals.',
                    subtitle:
                        'Track and manage leads effectively\nfrom contact to close.',
                    visual: _buildPage2Visual(),
                  ),
                  _buildPageContent(
                    headlineRow1: 'Automate your',
                    headlineRow2: 'Workflow ',
                    headlineRow3: 'tasks.',
                    subtitle:
                        'Save time with built-in templates\nand automated smart responses.',
                    visual: _buildPage3Visual(),
                  ),
                ],
              ),
            ),

            // Fixed bottom section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Carousel Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      bool isActive = _currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: isActive ? 32 : 6,
                        height: isActive ? 4 : 6,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF13753F)
                              : const Color(0xFFD4DBF3),
                          borderRadius: BorderRadius.circular(isActive ? 2 : 3),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  // Action Buttons
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNextTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF13BA5E,
                        ), // Bright primary green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _currentPage == 2
                                ? Icons.flash_on
                                : Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _currentPage == 2
                                ? 'Connect with WhatsApp'
                                : 'Next',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: _onSkipTap,
                    child: Text(
                      'Skip for now',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3B414E),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "By continuing, you agree to LedgeCRM's ",
                        ),
                        TextSpan(
                          text: "Terms",
                          style: GoogleFonts.inter(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy\nPolicy",
                          style: GoogleFonts.inter(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: const Color(0xFF8C95A6),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({
    required String headlineRow1,
    required String headlineRow2,
    required String headlineRow3,
    required String subtitle,
    required Widget visual,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Headline
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '$headlineRow1\n'),
                  TextSpan(
                    text: headlineRow2,
                    style: const TextStyle(
                      color: Color(0xFF0B8544),
                    ), // Darker green
                  ),
                  TextSpan(text: headlineRow3),
                ],
              ),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF141A25),
                height: 1.1,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 16),

            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3B414E),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 48),

            // Visuals
            visual,
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1Visual() {
    return SizedBox(
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Right card (Growth)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 140,
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDFE6F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF44505C),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.bar_chart,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'GROWTH',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF44505C),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+124%',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF13753F),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Left card (Message Preview)
          Positioned(
            left: 0,
            top: 10,
            child: Container(
              width: 180,
              padding: const EdgeInsets.all(20),
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
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFFDFE6F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chat_bubble_rounded,
                          size: 14,
                          color: Color(0xFF0F9D58),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 48,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4DBF3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBFBFB),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 120,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBFBFB),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 100,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2F0DF), // Light green skeleton
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF13BA5E),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom card (User Lead)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFE6F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.person, color: Color(0xFF5A6678)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alex Thompson',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF141A25),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'HOT LEAD',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6EFA89),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0C7D38),
                      ),
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

  Widget _buildPage2Visual() {
    return SizedBox(
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft container
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFDFE6F5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          Positioned(
            top: 24,
            left: 20,
            right: 20,
            child: Column(
              children: [
                _buildMockPipelineCard(
                  'Qualify Lead',
                  'Sarah Johnson',
                  '\$4,500',
                ),
                const SizedBox(height: 12),
                _buildMockPipelineCard(
                  'Send Proposal',
                  'Tech Innovators',
                  '\$12,000',
                ),
                const SizedBox(height: 12),
                _buildMockPipelineCard('Negotiation', 'Nexus Corp', '\$8,300'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockPipelineCard(String stage, String name, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF13BA5E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF141A25),
                    ),
                  ),
                  Text(
                    stage,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF13753F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage3Visual() {
    return SizedBox(
      height: 260,
      child: Center(
        child: Container(
          width: 260,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F8F0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF13BA5E),
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Auto-Reply Active',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF141A25),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Responding to incoming leads instantly using your templates.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E9F1), width: 2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Color(0xFF13BA5E), size: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Logo custom painter to match the shapes in the LedgeCRM logo (intersecting rectangles/squares)
class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()..color = Colors.white;
    // Left shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * 0.4, size.height * 0.7),
        const Radius.circular(2),
      ),
      paint1,
    );
    // Right shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.5,
          size.height * 0.3,
          size.width * 0.5,
          size.height * 0.7,
        ),
        const Radius.circular(2),
      ),
      paint1,
    );
    // Overlap shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.3,
          size.height * 0.4,
          size.width * 0.4,
          size.height * 0.2,
        ),
        const Radius.circular(2),
      ),
      paint1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
