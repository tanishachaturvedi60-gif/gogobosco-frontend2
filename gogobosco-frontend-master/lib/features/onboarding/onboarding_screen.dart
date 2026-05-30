import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          "Find schools, colleges and vocational centres across your region.",
    ),
    _PageData(
      image: 'assets/updated.png',
      title: "Stay Updated",
      subtitle: "Get the latest news, events and announcements in one place.",
    ),
    _PageData(
      image: 'assets/ggbLogo.png',
      title: "Explore Opportunities",
      subtitle: "Jobs, admissions and community updates made simple for you.",
    ),
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/register');
    }
  }

  void skip() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDFDFD), Color(0xFFF5F5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// 🔝 TOP BAR (SKIP)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: skip,
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.grey),
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
                          /// 🖼 IMAGE CARD
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 25,
                                  color: Colors.black.withValues(alpha: 0.08),
                                ),
                              ],
                            ),
                            child: Image.asset(page.image, height: 120),
                          ),

                          const SizedBox(height: 40),

                          /// 🧠 TITLE
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// 📝 SUBTITLE
                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Color(0xFF666666),
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
                          width: currentPage == index ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? const Color(0xFFD32F2F)
                                : const Color.fromARGB(255, 225, 225, 225),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// 🚀 BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD32F2F),
                          foregroundColor: Colors.white, // 👈 important
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 6,
                        ),
                        child: Text(
                          currentPage == pages.length - 1
                              ? "Get Started"
                              : "Next",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
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
