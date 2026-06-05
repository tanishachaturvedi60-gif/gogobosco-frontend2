import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/auth_landing_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/home/home_dashboard.dart';
import 'features/map/map_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/home/home_screen.dart'; // your bottom nav wrapper
import 'screens/institutions_page.dart';
import 'screens/events_page.dart';
import 'screens/jobs_page.dart';
import 'screens/news_page.dart';
import 'screens/institution_detail_page.dart';
import 'screens/event_detail_page.dart';
import 'screens/job_detail_page.dart';
import 'screens/news_detail_page.dart';
import 'screens/update_detail_page.dart';

Page<dynamic> buildPageWithTransition({
  required Widget child,
  required LocalKey key,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 320),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );
      final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.03), // subtle slide up
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        ),
      );
    },
  );
}

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      /// 🔹 SPLASH
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),

      /// 🔹 ONBOARDING
      GoRoute(
        path: '/onboard',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),

      /// 🔹 AUTH LANDING
      GoRoute(
        path: '/auth_landing',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const AuthLandingScreen(),
        ),
      ),

      /// 🔹 AUTH
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/institution/:id',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: InstitutionDetailPage(id: state.pathParameters['id'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/event/:id',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: EventDetailPage(id: state.pathParameters['id'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/job/:id',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: JobDetailPage(id: state.pathParameters['id'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/news/:id',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: NewsDetailPage(id: state.pathParameters['id'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/update/:id',
        pageBuilder: (context, state) => buildPageWithTransition(
          key: state.pageKey,
          child: UpdateDetailPage(id: state.pathParameters['id'] ?? ''),
        ),
      ),

      /// 🔥 MAIN APP (WITH BOTTOM NAV)
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const HomeDashboard(),
            ),
          ),
          GoRoute(
            path: '/map',
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const MapScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
          GoRoute(
            path: '/institutions',
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const InstitutionsPage(),
            ),
          ),
          GoRoute(
            path: '/events',
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const EventsPage(),
            ),
          ),
          GoRoute(
            path: '/jobs',
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const JobsPage(),
            ),
          ),
          GoRoute(
            path: '/news',
            pageBuilder: (context, state) => buildPageWithTransition(
              key: state.pageKey,
              child: const NewsPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
