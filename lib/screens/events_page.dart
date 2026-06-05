import 'package:flutter/material.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/services/api_service.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<dynamic> _events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await ApiService.getRaw('/data/events');
      if (response != null) {
        setState(() {
          _events = response;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final event = _events[index];
              final isEven = index % 2 == 0;
              final Color accentColor = isEven ? AppTheme.primaryRed : AppTheme.accentYellow;
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
                child: Row(
                  children: [
                    /// Left Color accent bar
                    Container(
                      width: 6,
                      height: 110,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: chipBg,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    (event["tag"] ?? "").toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: chipText,
                                    ),
                                  ),
                                ),
                                Text(
                                  event["date"] ?? "",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryRed,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              event["title"] ?? "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded, size: 14, color: AppTheme.textMuted),
                                const SizedBox(width: 4),
                                Text(
                                  event["time"] ?? "",
                                  style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textMuted),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    event["location"] ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}