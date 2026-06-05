import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/data/mock_data.dart';

class UpdateDetailPage extends StatelessWidget {
  final String id;

  const UpdateDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final update = MockData.updates.firstWhere(
      (element) => element["id"] == id,
      orElse: () => {},
    );

    if (update.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Not Found")),
        body: const Center(child: Text("Update not found")),
      );
    }

    final bool isRedTag = update["tagColor"] == "red";
    final Color accentColor = isRedTag ? AppTheme.primaryRed : AppTheme.accentYellow;
    final Color tagBg = isRedTag 
        ? AppTheme.primaryRed.withValues(alpha: 0.08) 
        : AppTheme.accentYellow.withValues(alpha: 0.15);
    final Color tagText = isRedTag 
        ? AppTheme.primaryRed 
        : AppTheme.textDark;

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        title: const Text("Latest Update"),
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
            // Header Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.backgroundWhite,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.borderLight, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.01),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    update["title"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    update["subtitle"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Writeup Description
            const Text(
              "Announcement Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.backgroundWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderLight, width: 1.5),
              ),
              child: Text(
                update["writeup"]!,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.6,
                  color: AppTheme.textDark,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Action Button based on category
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to corresponding section based on update type
                  final type = update["type"]!.toLowerCase();
                  if (type.contains("event")) {
                    context.go('/events');
                  } else if (type.contains("job")) {
                    context.go('/jobs');
                  } else if (type.contains("admission")) {
                    context.go('/institutions');
                  } else {
                    // Just show a notice snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Stay tuned for further updates!"),
                        backgroundColor: AppTheme.primaryRed,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: isRedTag ? Colors.white : AppTheme.textDark,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 4,
                  shadowColor: accentColor.withValues(alpha: 0.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _getActionLabel(update["type"]!),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String _getActionLabel(String type) {
    final t = type.toLowerCase();
    if (t.contains("event")) {
      return "View Event List";
    } else if (t.contains("job")) {
      return "Browse Jobs";
    } else if (t.contains("admission")) {
      return "Explore Institutions";
    } else {
      return "Acknowledge Notice";
    }
  }
}
