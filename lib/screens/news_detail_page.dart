import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/data/mock_data.dart';

class NewsDetailPage extends StatelessWidget {
  final String id;

  const NewsDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final article = MockData.news.firstWhere(
      (element) => element["id"] == id,
      orElse: () => {},
    );

    if (article.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Not Found")),
        body: const Center(child: Text("Article not found")),
      );
    }

    final isEven = int.tryParse(id) != null && int.parse(id) % 2 == 0;
    final Color accentColor = isEven ? AppTheme.primaryRed : AppTheme.accentYellow;
    final Color chipText = isEven ? AppTheme.primaryRed : AppTheme.textDark;
    final Color chipBg = isEven 
        ? AppTheme.primaryRed.withValues(alpha: 0.08) 
        : AppTheme.accentYellow.withValues(alpha: 0.15);

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        title: const Text("Full Story"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.textDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textDark, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category tag and Date
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

            const SizedBox(height: 16),

            // Main Title
            Text(
              article["title"]!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppTheme.textDark,
                height: 1.25,
              ),
            ),

            const SizedBox(height: 16),

            // Highlight/Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.bgLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderLight, width: 1.2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.format_quote_rounded, color: accentColor, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      article["summary"]!,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontStyle: FontStyle.italic,
                        height: 1.45,
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Article body
            Text(
              article["body"]!,
              style: const TextStyle(
                fontSize: 15.5,
                height: 1.65,
                color: AppTheme.textDark,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
