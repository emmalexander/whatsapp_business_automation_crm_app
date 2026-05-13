import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_business_automation_crm_app/providers/chat_upload_provider.dart';
import 'package:whatsapp_business_automation_crm_app/providers/user_provider.dart';
import 'package:whatsapp_business_automation_crm_app/screens/analytics/analytics_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/dashboard/dashboard_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/leads/leads_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/templates/templates_screen.dart';
import 'package:whatsapp_business_automation_crm_app/widgets/chat_upload_overlay.dart';

class MainNavigation extends ConsumerStatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  late int _currentIndex;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const LeadsScreen(),
    //const PipelineScreen(),
    const TemplatesScreen(),
    const AnalyticsScreen(),
  ];

  // Sharing intent subscriptions
  StreamSubscription<List<SharedFile>>? _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).getUser();
      _initSharingIntent();
    });
  }

  // ---------------------------------------------------------------------------
  // Sharing Intent
  // ---------------------------------------------------------------------------

  void _initSharingIntent() {
    // 1. Handle the initial file if the app was opened via a share action.
    FlutterSharingIntent.instance
        .getInitialSharing()
        .then((List<SharedFile> files) {
      _handleSharedFiles(files);
    });

    // 2. Listen for subsequent share events while the app is in the foreground.
    _intentDataStreamSubscription = FlutterSharingIntent.instance
        .getMediaStream()
        .listen(_handleSharedFiles);
  }

  void _handleSharedFiles(List<SharedFile> files) {
    if (files.isEmpty) return;

    // Look for a .zip file (WhatsApp exports chat as a .zip)
    final zipFile = files.firstWhere(
      (f) =>
          f.value != null &&
          (f.value!.toLowerCase().endsWith('.zip') ||
              f.type == SharedMediaType.FILE),
      orElse: () => files.first,
    );

    final path = zipFile.value;
    if (path == null || path.isEmpty) return;

    // Validate the file actually exists
    final file = File(path);
    if (!file.existsSync()) {
      _showToast('Could not read the shared file.', isError: true);
      return;
    }

    // Begin upload
    ref.read(chatUploadProvider.notifier).upload(path);
  }

  // ---------------------------------------------------------------------------
  // Result handling (watches provider changes)
  // ---------------------------------------------------------------------------

  void _onUploadStateChanged(ChatUploadState state) {
    if (state.status == ChatUploadStatus.success) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          ref.read(chatUploadProvider.notifier).reset();
          _showToast('Chat exported successfully! 🎉');
        }
      });
    } else if (state.status == ChatUploadStatus.error) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          ref.read(chatUploadProvider.notifier).reset();
          _showToast(
            state.errorMessage ?? 'Upload failed. Please try again.',
            isError: true,
          );
        }
      });
    }
  }

  void _showToast(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B96B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // React to upload state changes for side-effects (toasts, reset)
    ref.listen<ChatUploadState>(chatUploadProvider, (prev, next) {
      _onUploadStateChanged(next);
    });

    final uploadState = ref.watch(chatUploadProvider);

    return Stack(
      children: [
        Scaffold(
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
                        color: _currentIndex == 0
                            ? const Color(0xFFE8F8F0)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.dashboard_rounded,
                        color: _currentIndex == 0
                            ? const Color(0xFF10B96B)
                            : const Color(0xFF9CA3AF),
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
                        color: _currentIndex == 1
                            ? const Color(0xFFE8F8F0)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.person_pin_rounded,
                        color: _currentIndex == 1
                            ? const Color(0xFF10B96B)
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                  label: 'LEADS',
                ),
                // BottomNavigationBarItem(
                //   icon: Padding(
                //     padding: const EdgeInsets.only(bottom: 4.0),
                //     child: Container(
                //       padding: const EdgeInsets.all(6),
                //       decoration: BoxDecoration(
                //         color: _currentIndex == 2 ? const Color(0xFFE8F8F0) : Colors.transparent,
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Icon(
                //         Icons.account_tree_outlined,
                //         color: _currentIndex == 2 ? const Color(0xFF10B96B) : const Color(0xFF9CA3AF),
                //       ),
                //     ),
                //   ),
                //   label: 'PIPELINE',
                // ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _currentIndex == 3
                            ? const Color(0xFFE8F8F0)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: _currentIndex == 3
                            ? const Color(0xFF10B96B)
                            : const Color(0xFF9CA3AF),
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
                        color: _currentIndex == 4
                            ? const Color(0xFFE8F8F0)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.bar_chart_rounded,
                        color: _currentIndex == 4
                            ? const Color(0xFF10B96B)
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                  label: 'ANALYTICS',
                ),
              ],
            ),
          ),
        ),

        // ── Upload overlay ──────────────────────────────────────────────────
        if (uploadState.isLoading)
          Positioned.fill(
            child: ChatUploadOverlay(
              progress: uploadState.progress,
              fileName: uploadState.filePath?.split('/').last,
            ),
          ),
      ],
    );
  }
}
