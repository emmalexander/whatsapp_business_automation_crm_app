import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_business_automation_crm_app/providers/user_provider.dart';
import 'package:whatsapp_business_automation_crm_app/screens/auth/login_screen.dart';
import 'package:whatsapp_business_automation_crm_app/theme.dart';
import 'package:whatsapp_business_automation_crm_app/utils/toast_util.dart';
import 'package:whatsapp_business_automation_crm_app/widgets/loading_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkThemeEnabled = false;

  @override
  void initState() {
    super.initState();
    // Fetch user data on load.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).getUser();
    });
  }

  // ── Sign Out bottom sheet ─────────────────────────────────────────────────

  Future<void> _showSignOutSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _SignOutBottomSheet(
        onConfirm: () async {
          Navigator.of(ctx).pop(); // Close sheet first
          await _performSignOut();
        },
      ),
    );
  }

  Future<void> _performSignOut() async {
    try {
      // Use UserProvider's signOut (also calls ApiService.signOut)
      await ref.read(userProvider.notifier).signOut();
      ref.read(userProvider.notifier).clearUser();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ToastUtil.showError(context, e.toString());
      }
    }
  }

  // ── Edit profile bottom sheet ─────────────────────────────────────────────

  void _showEditSheet() {
    final user = ref.read(userProvider).user;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _EditProfileBottomSheet(
        initialFirstName: user?.data.user.firstName ?? '',
        initialMiddleName: user?.data.user.middleName ?? '',
        initialLastName: user?.data.user.lastName ?? '',
        initialPhone: user?.data.user.phoneNumber ?? '',
        onSave: (data) async {
          try {
            await ref.read(userProvider.notifier).updateUser(data);
            if (mounted) {
              ToastUtil.showSuccess(context, 'Profile updated successfully!');
            }
          } catch (e) {
            if (mounted) {
              ToastUtil.showError(context, e.toString());
            }
          }
        },
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final user = userState.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        title: Text(
          'Profile & Settings',
          style: GoogleFonts.inter(
            color: const Color(0xFF141A25),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF141A25)),
        centerTitle: true,
      ),
      body: userState.isLoading && user == null
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppTheme.primaryGreen),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // ── User Header ───────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFE6F5),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 36,
                              color: Color(0xFF5A6678),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user != null &&
                                        user.data.user.fullName.isNotEmpty
                                    ? user.data.user.fullName
                                    : '—',
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF141A25),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user?.data.user.email ?? '—',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                              if (user?.data.user != null) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF13BA5E,
                                    ).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    ('Premium').toUpperCase(),
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF13BA5E),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: _showEditSheet,
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF5A6678),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Account ───────────────────────────────────────────────
                  _buildSectionHeader('ACCOUNT'),
                  _buildSettingsItem(
                    icon: Icons.phone_android,
                    title: 'Phone Number',
                    subtitle: user?.data.user.phoneNumber.isNotEmpty == true
                        ? user!.data.user.phoneNumber
                        : null,
                    onTap: _showEditSheet,
                  ),

                  const SizedBox(height: 24),

                  // ── Preferences ───────────────────────────────────────────
                  _buildSectionHeader('PREFERENCES'),
                  _buildSettingsToggle(
                    icon: Icons.notifications_none,
                    title: 'Push Notifications',
                    value: _notificationsEnabled,
                    onChanged: (val) =>
                        setState(() => _notificationsEnabled = val),
                  ),
                  _buildSettingsToggle(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Theme',
                    value: _darkThemeEnabled,
                    onChanged: (val) => setState(() => _darkThemeEnabled = val),
                  ),

                  const SizedBox(height: 24),

                  // ── Support ───────────────────────────────────────────────
                  _buildSectionHeader('SUPPORT'),
                  _buildSettingsItem(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.shield_outlined,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),

                  const SizedBox(height: 32),

                  // ── Sign Out ──────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _showSignOutSheet,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFFFDAD6)),
                          backgroundColor: const Color(0xFFFFF5F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Sign Out',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFD92D20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: const Color(0xFF8C95A6),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF1F3F7))),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E9F1).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF5A6678)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF141A25),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFBBC3D4)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsToggle({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F3F7))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E9F1).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF5A6678)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF141A25),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF13BA5E),
          ),
        ],
      ),
    );
  }
}

// ── Sign-Out confirmation bottom sheet ────────────────────────────────────────

class _SignOutBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;

  const _SignOutBottomSheet({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F4),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFFDAD6), width: 1.5),
            ),
            child: const Center(
              child: Icon(
                Icons.logout_rounded,
                color: Color(0xFFD92D20),
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'Sign Out?',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF141A25),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You will be signed out of your account.\nYou can sign back in at any time.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFFE5E9F1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF5A6678),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFFD92D20),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
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

// ── Edit Profile bottom sheet ─────────────────────────────────────────────────

class _EditProfileBottomSheet extends StatefulWidget {
  final String initialFirstName;
  final String initialMiddleName;
  final String initialLastName;
  final String initialPhone;
  final Future<void> Function(Map<String, dynamic> data) onSave;

  const _EditProfileBottomSheet({
    required this.initialFirstName,
    required this.initialMiddleName,
    required this.initialLastName,
    required this.initialPhone,
    required this.onSave,
  });

  @override
  State<_EditProfileBottomSheet> createState() =>
      _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<_EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _middleNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _phoneCtrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController(text: widget.initialFirstName);
    _middleNameCtrl = TextEditingController(text: widget.initialMiddleName);
    _lastNameCtrl = TextEditingController(text: widget.initialLastName);
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _middleNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final data = <String, dynamic>{
      'firstName': _firstNameCtrl.text.trim(),
      'lastName': _lastNameCtrl.text.trim(),
    };
    if (_middleNameCtrl.text.trim().isNotEmpty) {
      data['middleName'] = _middleNameCtrl.text.trim();
    }
    if (_phoneCtrl.text.trim().isNotEmpty) {
      data['phoneNumber'] = _phoneCtrl.text.trim();
    }

    setState(() => _isSaving = true);
    try {
      await widget.onSave(data);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      // Errors already shown via ToastUtil in ProfileScreen.
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
    labelText: label,
    labelStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF6B7280)),
    filled: true,
    fillColor: const Color(0xFFF9F9FB),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE5E9F1)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE5E9F1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppTheme.primaryGreen, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Profile',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF141A25),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Update your personal information',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 24),

                // First & Last name row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameCtrl,
                        decoration: _inputDecoration('First Name'),
                        style: GoogleFonts.inter(fontSize: 14),
                        textCapitalization: TextCapitalization.words,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameCtrl,
                        decoration: _inputDecoration('Last Name'),
                        style: GoogleFonts.inter(fontSize: 14),
                        textCapitalization: TextCapitalization.words,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _middleNameCtrl,
                  decoration: _inputDecoration('Middle Name (optional)'),
                  style: GoogleFonts.inter(fontSize: 14),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _phoneCtrl,
                  decoration: _inputDecoration('Phone Number'),
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.inter(fontSize: 14),
                ),
                const SizedBox(height: 28),

                LoadingButton(
                  text: 'Save Changes',
                  isLoading: _isSaving,
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
