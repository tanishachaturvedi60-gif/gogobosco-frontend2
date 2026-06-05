import 'package:flutter/material.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/services/api_service.dart';
import 'dart:convert';

class InstitutionsPage extends StatefulWidget {
  const InstitutionsPage({super.key});

  @override
  State<InstitutionsPage> createState() => _InstitutionsPageState();
}

class _InstitutionsPageState extends State<InstitutionsPage> {
  List<dynamic> _institutions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Because ApiService._parse assumes a Map is returned (for {data: ..., message: ...} structures),
      // we need to make a raw request since our Spring Boot controller just returns a List JSON.
      final response = await ApiService.getRaw('/data/institutions');
      if (response != null) {
        setState(() {
          _institutions = response;
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
        title: const Text("Institutions"),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _institutions.length,
            itemBuilder: (context, index) {
              final inst = _institutions[index];
              final isRed = index % 2 == 0;
              final Color chipBg = isRed 
                  ? AppTheme.primaryRed.withValues(alpha: 0.08) 
                  : AppTheme.accentYellow.withValues(alpha: 0.15);
              final Color chipText = isRed 
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
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: chipBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.school_rounded,
                          color: chipText,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
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
                                    (inst["type"] ?? "").toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: chipText,
                                    ),
                                  ),
                                ),
                                Text(
                                  inst["students"] ?? "",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.textMuted,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              inst["name"] ?? "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 14,
                                  color: AppTheme.textMuted,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  inst["location"] ?? "",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                              ],
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