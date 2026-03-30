import 'package:flutter/material.dart';
import 'package:whatsapp_business_automation_crm_app/screens/dashboard_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/leads_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/pipeline_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/templates_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/analytics_screen.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const LeadsScreen(),
    const PipelineScreen(),
    const TemplatesScreen(),
    const AnalyticsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF10B96B),
          unselectedItemColor: const Color(0xFF9CA3AF),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _currentIndex == 0 ? const Color(0xFFE8F8F0) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.dashboard_rounded,
                    color: _currentIndex == 0 ? const Color(0xFF10B96B) : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              label: 'DASHBOARD',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _currentIndex == 1 ? const Color(0xFFE8F8F0) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.person_pin_rounded,
                    color: _currentIndex == 1 ? const Color(0xFF10B96B) : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              label: 'LEADS',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _currentIndex == 2 ? const Color(0xFFE8F8F0) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.account_tree_outlined,
                    color: _currentIndex == 2 ? const Color(0xFF10B96B) : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              label: 'PIPELINE',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _currentIndex == 3 ? const Color(0xFFE8F8F0) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    color: _currentIndex == 3 ? const Color(0xFF10B96B) : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              label: 'TEMPLATES',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _currentIndex == 4 ? const Color(0xFFE8F8F0) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color: _currentIndex == 4 ? const Color(0xFF10B96B) : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              label: 'ANALYTICS',
            ),
          ],
        ),
      ),
    );
  }
}
