import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Function(int) onTabChange;

  const HomePage({super.key, required this.onTabChange});

  Widget buildMenuButton({
    required String title,
    required String emoji, // نستخدم إيموجي بدل أيقونة
    required Color color,
    required int index,
  }) {
    return ElevatedButton(
      onPressed: () => onTabChange(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 30), // صغر حجم الإيموجي
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("Jordan Explorer 🇯🇴"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "اختر القسم الذي تريد استكشافه",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  buildMenuButton(
                    title: "الفيديو",
                    color: Colors.red,
                    index: 1,
                    emoji: "🎥",
                  ),
                  buildMenuButton(
                    title: "المعالم",
                    color: Colors.blue,
                    index: 2,
                    emoji: "🗺️",
                  ),
                  buildMenuButton(
                    title: "الاختبار",
                    color: Colors.orange,
                    index: 3,
                    emoji: "❓",
                  ),
                  buildMenuButton(
                    title: "التقييم",
                    color: Colors.amber,
                    index: 4,
                    emoji: "⭐",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}