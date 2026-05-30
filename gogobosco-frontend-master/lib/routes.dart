import 'package:go_router/go_router.dart';

import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
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

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      /// 🔹 SPLASH
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

      /// 🔹 ONBOARDING
      GoRoute(
        path: '/onboard',
        builder: (context, state) => const OnboardingScreen(),
      ),

      /// 🔹 AUTH
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      /// 🔥 MAIN APP (WITH BOTTOM NAV)
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child); // 👈 IMPORTANT CHANGE
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeDashboard(),
          ),
          GoRoute(path: '/map', builder: (context, state) => const MapScreen()),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/institutions',
            builder: (context, state) => const InstitutionsPage(),
          ),

          GoRoute(
            path: '/events',
            builder: (context, state) => const EventsPage(),
          ),

          GoRoute(
            path: '/jobs',
            builder: (context, state) => const JobsPage(),
          ),

          GoRoute(
            path: '/news',
            builder: (context, state) => const NewsPage(),
          ),
        ],
      ),
    ],
  );
}
