import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<_PageData> pages = [
    _PageData(
      image: 'assets/donBosco.png',
      title: "Discover Bosco Institutions",
      subtitle:
          "Find schools, colleges, and vocational centers across your region easily.",
    ),
    _PageData(
      image: 'assets/updated.png',
      title: "Stay Updated",
      subtitle: "Get the latest news, events, and announcements in one place.",
    ),
    _PageData(
      image: 'assets/ggbLogo.png',
      title: "Explore Opportunities",
      subtitle: "Jobs, admissions, and community updates made simple for you.",
    ),
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.go('/auth_landing');
    }
  }

  void skip() {
    context.go('/auth_landing');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// 🔝 TOP BAR (SKIP)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: skip,
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.textMuted,
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 📱 PAGES
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() => currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// 🖼 IMAGE CARD WITH GRADIENT AND FLOATING SHADOW
                          Container(
                            padding: const EdgeInsets.all(28),
                            height: 240,
                            width: 240,
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundWhite,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 30,
                                  color: AppTheme.primaryRed.withValues(alpha: 0.08),
                                  offset: const Offset(0, 15),
                                ),
                                BoxShadow(
                                  blurRadius: 15,
                                  color: AppTheme.accentYellow.withValues(alpha: 0.05),
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: AppTheme.borderLight,
                                width: 1.5,
                              ),
                            ),
                            child: Image.asset(page.image, fit: BoxFit.contain),
                          ),

                          const SizedBox(height: 50),

                          /// 🧠 TITLE
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                              height: 1.25,
                            ),
                          ),

                          const SizedBox(height: 16),

                          /// 📝 SUBTITLE
                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// 🔽 BOTTOM CONTROLS
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    /// 🔘 DOT INDICATOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? AppTheme.primaryRed
                                : AppTheme.accentYellow.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// 🚀 BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 8,
                          shadowColor: AppTheme.primaryRed.withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          currentPage == pages.length - 1
                              ? "Get Started"
                              : "Next",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 📦 MODEL
class _PageData {
  final String image;
  final String title;
  final String subtitle;

  _PageData({required this.image, required this.title, required this.subtitle});
}

