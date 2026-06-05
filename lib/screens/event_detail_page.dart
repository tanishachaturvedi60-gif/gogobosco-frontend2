import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/data/mock_data.dart';

class EventDetailPage extends StatefulWidget {
  final String id;

  const EventDetailPage({super.key, required this.id});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool _isRegistered = false;

  void _registerForEvent() {
    setState(() {
      _isRegistered = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🎉 Registration successful! Check your email for details."),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = MockData.events.firstWhere(
      (element) => element["id"] == widget.id,
      orElse: () => {},
    );

    if (event.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Not Found")),
        body: const Center(child: Text("Event not found")),
      );
    }

    final isEven = int.tryParse(widget.id) != null && int.parse(widget.id) % 2 == 0;
    final Color accentColor = isEven ? AppTheme.primaryRed : AppTheme.accentYellow;

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        title: const Text("Event Details"),
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
            // Event Title Header
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      event["tag"]!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: accentColor == AppTheme.accentYellow ? AppTheme.textDark : accentColor,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    event["title"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(color: AppTheme.borderLight),
                  const SizedBox(height: 10),
                  _metaRow(Icons.calendar_today_rounded, "Date", event["date"]!),
                  const SizedBox(height: 10),
                  _metaRow(Icons.access_time_rounded, "Time", event["time"]!),
                  const SizedBox(height: 10),
                  _metaRow(Icons.location_on_outlined, "Location", event["location"]!),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // About Event
            const Text(
              "About the Event",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              event["description"]!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppTheme.textMuted,
              ),
            ),

            const SizedBox(height: 24),

            // Organizer / Speakers info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.backgroundWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderLight, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoDetailRow("Organizer", event["organizer"]!),
                  const SizedBox(height: 14),
                  _infoDetailRow("Keynote Speakers", event["speaker"]!),
                  const SizedBox(height: 14),
                  _infoDetailRow("Participation Fee", event["fee"]!),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isRegistered ? null : _registerForEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryRed,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                  disabledForegroundColor: Colors.grey[600],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: _isRegistered ? 0 : 6,
                  shadowColor: AppTheme.primaryRed.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  _isRegistered ? "Registered" : "Register Now",
                  style: const TextStyle(
                    fontSize: 16,
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

  Widget _metaRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryRed, size: 18),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 1),
            Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textDark),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textMuted,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}
