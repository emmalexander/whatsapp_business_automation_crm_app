import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/screens/main_navigation.dart';
import 'package:whatsapp_business_automation_crm_app/screens/subscription/upgrade_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/profile/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  
  const AppDrawer({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF9F9FB),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF13BA5E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.flash_on, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'LedgeCRM',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF141A25),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFE5E9F1), height: 1),
                const SizedBox(height: 16),
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                  index: 0,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_pin_rounded,
                  title: 'Leads',
                  index: 1,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.account_tree_outlined,
                  title: 'Pipeline',
                  index: 2,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.description_outlined,
                  title: 'Templates',
                  index: 3,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.bar_chart_rounded,
                  title: 'Analytics',
                  index: 4,
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE5E9F1), height: 1),
                const SizedBox(height: 16),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profile Settings',
                  index: 6,
                  onTapOverride: () {
                    Navigator.pop(context); // Close drawer
                    if (currentIndex != 6) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                    }
                  }
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.rocket_launch,
                  title: 'Upgrade Plan',
                  index: 5,
                  onTapOverride: () {
                    Navigator.pop(context); // Close drawer
                    if (currentIndex != 5) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const UpgradeScreen()));
                    }
                  }
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, left: 16, right: 16),
              child: GestureDetector(
                onTap: () {
                  // Mock sign out
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Color(0xFF9E3F29), size: 20),
                    const SizedBox(width: 16),
                    Text(
                      'Sign Out',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF9E3F29),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon, 
    required String title, 
    required int index, 
    VoidCallback? onTapOverride,
  }) {
    final bool isActive = currentIndex == index;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: onTapOverride ?? () {
          Navigator.pop(context); // Close drawer
          if (!isActive) {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: index))
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFE8F8F0) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? const Color(0xFF10B96B) : const Color(0xFF5A6678),
                size: 20,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? const Color(0xFF10B96B) : const Color(0xFF5A6678),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
