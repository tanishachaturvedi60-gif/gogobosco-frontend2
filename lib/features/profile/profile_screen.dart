import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/services/auth_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    // First load from cache for instant display
    final cached = await AuthService.getCachedUser();
    if (mounted) setState(() => _user = cached);

    // Then fetch fresh data from the API
    final live = await AuthService.fetchProfile();
    if (mounted) setState(() {
      _user = live ?? cached;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await AuthService.logout();
    if (mounted) context.go('/login');
  }

  String get _displayName {
    if (_user == null) return '...';
    return _user!['fullName']?.toString().isNotEmpty == true
        ? _user!['fullName']
        : _user!['username'] ?? '...';
  }

  String get _displayRole {
    if (_user == null) return '...';
    final role = _user!['role']?.toString() ?? 'GENERAL';
    // Capitalise first letter only
    return role[0].toUpperCase() + role.substring(1).toLowerCase();
  }

  String get _displayEmail {
    return _user?['email']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: _isLoading && _user == null
            ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryRed))
            : RefreshIndicator(
                color: AppTheme.primaryRed,
                onRefresh: _loadProfile,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      /// 🔴 HEADER
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 36),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.primaryRed, Color(0xFFCC0000)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(36),
                          ),
                        ),
                        child: Column(
                          children: [
                            /// AVATAR
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppTheme.accentYellow,
                                shape: BoxShape.circle,
                              ),
                              child: const CircleAvatar(
                                radius: 44,
                                backgroundColor: AppTheme.backgroundWhite,
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 48,
                                  color: AppTheme.primaryRed,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// NAME
                            Text(
                              _displayName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),

                            const SizedBox(height: 4),

                            /// EMAIL
                            Text(
                              _displayEmail,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 8),

                            /// ROLE BADGE
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _displayRole,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// EDIT BUTTON
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 1.5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// ⚙️ SETTINGS SECTION
                      _section(
                        title: 'ACCOUNT SETTINGS',
                        children: [
                          _tile(Icons.person_outline_rounded, 'My Profile',
                              () {}),
                          _tile(Icons.lock_outline_rounded, 'Change Password',
                              () {}),
                        ],
                      ),

                      _section(
                        title: 'PREFERENCES',
                        children: [
                          _tile(Icons.notifications_none_rounded,
                              'Notifications', () {}),
                          _tile(Icons.dark_mode_outlined, 'Dark Mode', () {}),
                        ],
                      ),

                      _section(
                        title: 'SUPPORT',
                        children: [
                          _tile(Icons.help_outline_rounded, 'Help Center',
                              () {}),
                          _tile(Icons.info_outline_rounded, 'About App', () {}),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// 🚪 LOGOUT
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: _logout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryRed,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 54),
                            elevation: 4,
                            shadowColor:
                                AppTheme.primaryRed.withValues(alpha: 0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _section(
      {required String title, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: AppTheme.textMuted,
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.backgroundWhite,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppTheme.borderLight, width: 1.5),
            ),
            child: Column(
              children: List.generate(children.length, (index) {
                if (index == children.length - 1) return children[index];
                return Column(
                  children: [
                    children[index],
                    const Divider(
                        height: 1,
                        color: AppTheme.borderLight,
                        thickness: 1),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _tile(
      IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryRed.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppTheme.primaryRed, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppTheme.textDark,
          fontSize: 15,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 14, color: AppTheme.textMuted),
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

/// 🔹 STAT ITEM
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
