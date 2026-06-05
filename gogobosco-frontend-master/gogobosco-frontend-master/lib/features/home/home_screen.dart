import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';

class HomeScreen extends StatelessWidget {
  final Widget child; // ✅ REQUIRED

  const HomeScreen({
    super.key,
    required this.child, // ✅ REQUIRED
  });

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/map')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _getIndex(context);

    return Scaffold(
      body: child, // ✅ THIS SHOWS CURRENT TAB

      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        decoration: BoxDecoration(
          color: AppTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withValues(alpha: 0.06),
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              blurRadius: 10,
              color: AppTheme.primaryRed.withValues(alpha: 0.02),
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: AppTheme.borderLight,
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (i) {
              if (i == 0) context.go('/home');
              if (i == 1) context.go('/map');
              if (i == 2) context.go('/profile');
            },
            backgroundColor: AppTheme.backgroundWhite,
            elevation: 0,
            selectedItemColor: AppTheme.primaryRed,
            unselectedItemColor: AppTheme.textMuted.withValues(alpha: 0.6),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.grid_view_rounded),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.grid_view_rounded),
                ),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.map_outlined),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.map_rounded),
                ),
                label: "BoscoMap",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.person_outline_rounded),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.person_rounded),
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

