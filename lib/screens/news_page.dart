import 'package:flutter/material.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/services/api_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _news = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await ApiService.getRaw('/data/news');
      if (response != null) {
        setState(() {
          _news = response;
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
        title: const Text("News"),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
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
                              (article["category"] ?? "").toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: chipText,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Text(
                            article["date"] ?? "",
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
                        article["title"] ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        article["summary"] ?? "",
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