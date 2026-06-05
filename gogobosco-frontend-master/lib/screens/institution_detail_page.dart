import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/data/mock_data.dart';

class InstitutionDetailPage extends StatelessWidget {
  final String id;

  const InstitutionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final inst = MockData.institutions.firstWhere(
      (element) => element["id"] == id,
      orElse: () => {},
    );

    if (inst.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Not Found")),
        body: const Center(child: Text("Institution not found")),
      );
    }

    final isRed = int.tryParse(id) != null && int.parse(id) % 2 != 0;
    final Color primaryColor = isRed ? AppTheme.primaryRed : AppTheme.accentYellow;
    final Color fgColor = isRed ? Colors.white : AppTheme.textDark;

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium sliver app bar with curved background
          SliverAppBar(
            expandedHeight: 180.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: primaryColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textDark, size: 18),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      primaryColor.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            inst["type"]!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: fgColor,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          inst["name"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: fgColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview stats card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.borderLight, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.01),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoColumn(Icons.people_alt_rounded, "Students", inst["students"]!),
                        Container(width: 1, height: 40, color: AppTheme.borderLight),
                        _infoColumn(Icons.location_on_rounded, "Location", inst["location"]!.split(',')[0]),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // About section
                  const Text(
                    "About the Institution",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    inst["description"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppTheme.textMuted,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Courses section
                  const Text(
                    "Featured Courses",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...inst["courses"]!.split(',').map((course) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppTheme.primaryRed,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              course.trim(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  // Contact section
                  const Text(
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _contactTile(Icons.email_outlined, inst["email"]!, "Send Email"),
                  _contactTile(Icons.phone_outlined, inst["phone"]!, "Call Office"),
                  _contactTile(Icons.language_outlined, inst["website"]!, "Visit Website"),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryRed, size: 24),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppTheme.textDark),
        )
      ],
    );
  }

  Widget _contactTile(IconData icon, String value, String actionLabel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textMuted, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ),
          Text(
            actionLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppTheme.primaryRed,
            ),
          ),
        ],
      ),
    );
  }
}
