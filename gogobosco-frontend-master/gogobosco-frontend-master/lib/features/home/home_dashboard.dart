import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  static final List<Map<String, String>> _updates = [
    {
      "title": "Admissions Open for 2026",
      "subtitle": "Applications are now live for Don Bosco Tech courses.",
      "type": "Admissions",
      "time": "2 hours ago",
      "tagColor": "yellow", // yellow tag
    },
    {
      "title": "National Youth Seminar",
      "subtitle": "Join the annual leadership event at Bosco Hall.",
      "type": "Event",
      "time": "1 day ago",
      "tagColor": "red", // red tag
    },
    {
      "title": "Tech Job Fair 2026",
      "subtitle": "15+ companies recruiting on-campus next Tuesday.",
      "type": "Job Fair",
      "time": "2 days ago",
      "tagColor": "yellow",
    },
    {
      "title": "Scholarship Deadline Extended",
      "subtitle": "Submit your applications before the June 15 limit.",
      "type": "Notice",
      "time": "3 days ago",
      "tagColor": "red",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// 🔴 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ANT 👋",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.accentYellow,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentYellow.withValues(alpha: 0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppTheme.primaryRed.withValues(alpha: 0.1),
                      child: const Icon(Icons.person, color: AppTheme.primaryRed, size: 24),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// 🔍 SEARCH BAR
              TextField(
                decoration: InputDecoration(
                  hintText: "Search institutions, jobs, events...",
                  prefixIcon: const Icon(Icons.search, color: AppTheme.textMuted),
                  filled: true,
                  fillColor: AppTheme.backgroundWhite,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: AppTheme.borderLight, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: AppTheme.primaryRed, width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 🟡 QUICK CARDS GRID TITLE
              const Text(
                "Explore Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 14),

              /// GRID OF CATEGORIES
              Row(
                children: [
                  _card(
                    context,
                    "Institutions",
                    Icons.school_outlined,
                    "/institutions",
                    AppTheme.primaryRed.withValues(alpha: 0.08),
                    AppTheme.primaryRed,
                  ),
                  _card(
                    context,
                    "Events",
                    Icons.event_note_outlined,
                    "/events",
                    AppTheme.accentYellow.withValues(alpha: 0.15),
                    AppTheme.textDark,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  _card(
                    context,
                    "Jobs",
                    Icons.work_outline_rounded,
                    "/jobs",
                    AppTheme.accentYellow.withValues(alpha: 0.15),
                    AppTheme.textDark,
                  ),
                  _card(
                    context,
                    "News",
                    Icons.newspaper_outlined,
                    "/news",
                    AppTheme.primaryRed.withValues(alpha: 0.08),
                    AppTheme.primaryRed,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// 📰 FEED TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Latest Updates",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: AppTheme.primaryRed),
                    child: const Text(
                      "View All",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// 📰 FEED LIST
              ListView.builder(
                itemCount: _updates.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  final update = _updates[i];
                  return _feedCard(update);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 DASHBOARD CARD (Polished glassmorphism-style categories)
  Widget _card(
    BuildContext context,
    String title,
    IconData icon,
    String route,
    Color bgIconColor,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderLight, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => context.go(route),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: bgIconColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 FEED CARD (Polished list item with custom tags)
  Widget _feedCard(Map<String, String> update) {
    final bool isRedTag = update["tagColor"] == "red";
    final Color tagBg = isRedTag 
        ? AppTheme.primaryRed.withValues(alpha: 0.08) 
        : AppTheme.accentYellow.withValues(alpha: 0.15);
    final Color tagText = isRedTag 
        ? AppTheme.primaryRed 
        : AppTheme.textDark;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tagBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isRedTag ? Icons.campaign_rounded : Icons.star_rounded,
              color: tagText,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        update["type"]!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: tagText,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Text(
                      update["time"]!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  update["title"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  update["subtitle"]!,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

