import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/data/mock_data.dart';

class JobDetailPage extends StatefulWidget {
  final String id;

  const JobDetailPage({super.key, required this.id});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  bool _hasApplied = false;

  void _showApplicationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text(
                "Apply for Job",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          content: const Text(
            "Would you like to submit your GoGoBosco profile resume to this position?",
            style: TextStyle(color: AppTheme.textMuted, height: 1.4),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _hasApplied = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("🚀 Application sent successfully! The company will review your profile."),
                    backgroundColor: AppTheme.primaryRed,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentYellow,
                foregroundColor: AppTheme.textDark,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text("Submit", style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final job = MockData.jobs.firstWhere(
      (element) => element["id"] == widget.id,
      orElse: () => {},
    );

    if (job.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Not Found")),
        body: const Center(child: Text("Job not found")),
      );
    }

    final isEven = int.tryParse(widget.id) != null && int.parse(widget.id) % 2 == 0;
    final Color tagColor = isEven ? AppTheme.primaryRed : AppTheme.textDark;
    final Color tagBg = isEven 
        ? AppTheme.primaryRed.withValues(alpha: 0.08) 
        : AppTheme.accentYellow.withValues(alpha: 0.15);

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        title: const Text("Job Opportunity"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.textDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textDark, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Header Card
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
                                job["type"]!.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: tagColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Text(
                              job["salary"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.primaryRed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          job["title"]!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textDark,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          job["company"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Divider(color: AppTheme.borderLight),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppTheme.textMuted,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              job["location"]!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Job Description
                  const Text(
                    "Job Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    job["description"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppTheme.textMuted,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Requirements
                  const Text(
                    "Requirements",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    job["requirements"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Benefits
                  const Text(
                    "Benefits & Perks",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    job["benefits"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, -5),
                ),
              ],
              border: const Border(
                top: BorderSide(color: AppTheme.borderLight, width: 1.5),
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _hasApplied ? null : _showApplicationDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryRed,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.grey[600],
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: _hasApplied ? 0 : 4,
                    shadowColor: AppTheme.primaryRed.withValues(alpha: 0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _hasApplied ? "Applied" : "Apply Now",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
