import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔴 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello ANT 👋", style: TextStyle(fontSize: 16)),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    child: const Icon(Icons.person, color: Colors.red),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔍 SEARCH
              TextField(
                decoration: InputDecoration(
                  hintText: "Search institutions...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🟡 QUICK CARDS
              Row(
                children: [
                  _card(
                    context,
                    "Institutions",
                    Icons.school,
                    "/institutions",
                  ),

                  _card(
                    context,
                    "Events",
                    Icons.event,
                    "/events",
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  _card(
                    context,
                    "Jobs",
                    Icons.work,
                    "/jobs",
                  ),

                  _card(
                    context,
                    "News",
                    Icons.article,
                    "/news",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 📰 FEED TITLE
              const Text(
                "Latest Updates",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              /// 📰 FEED LIST
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, i) => _feedCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 DASHBOARD CARD
  Widget _card(
      BuildContext context,
      String title,
      IconData icon,
      String route,
      ) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          context.go(route);
        },
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFFD32F2F)),
              const SizedBox(height: 10),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 FEED CARD
  Widget _feedCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.event, color: Colors.red),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bosco Event Update",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "New event happening this weekend...",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
