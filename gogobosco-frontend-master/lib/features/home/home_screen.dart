import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/screens/institutions_page.dart';
import 'package:gogobosco/screens/events_page.dart';
import 'package:gogobosco/screens/jobs_page.dart';
import 'package:gogobosco/screens/news_page.dart';

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
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) {
            if (i == 0) context.go('/home');
            if (i == 1) context.go('/map');
            if (i == 2) context.go('/profile');
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFD32F2F),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "BoscoMap"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
