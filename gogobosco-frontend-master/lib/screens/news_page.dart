import 'package:flutter/material.dart';
import 'package:gogobosco/core/theme.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  static final List<Map<String, String>> _news = [
    {
      "title": "DBIT Guwahati Ranks Top 10 in College Survey",
      "summary": "Don Bosco Institute of Technology has been recognized among the top engineering institutes in the northeast region for academic excellence and placement success.",
      "date": "June 01, 2026",
      "category": "Press Release",
    },
    {
      "title": "New Solar Grid Installed at Bosco Technical Campus",
      "summary": "In line with environmental sustainability goals, a new 50kW solar panel grid system was inaugurated today to power classroom labs and administrative centers.",
      "date": "May 28, 2026",
      "category": "Campus News",
    },
    {
      "title": "Scholarship Scheme Launched for Technical Students",
      "summary": "The Don Bosco alumni association has announced a new endowment fund supporting underprivileged students in vocational and diploma courses.",
      "date": "May 25, 2026",
      "category": "Scholarships",
    },
    {
      "title": "Checklist Released for 2026 Course Admissions",
      "summary": "Prospective applicants can now access the full list of required documents, entrance dates, and interview guides for the upcoming academic cycle.",
      "date": "May 20, 2026",
      "category": "Admissions",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _news.length,
        itemBuilder: (context, index) {
          final article = _news[index];
          final isEven = index % 2 == 0;
          final Color chipBg = isEven 
              ? AppTheme.primaryRed.withValues(alpha: 0.08) 
              : AppTheme.accentYellow.withValues(alpha: 0.15);
          final Color chipText = isEven 
              ? AppTheme.primaryRed 
              : AppTheme.textDark;

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppTheme.backgroundWhite,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderLight, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: chipBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          article["category"]!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: chipText,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Text(
                        article["date"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article["title"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article["summary"]!,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppTheme.borderLight, thickness: 1),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Read Full Story",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            color: AppTheme.primaryRed,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: AppTheme.primaryRed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}