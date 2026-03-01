import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'video_screen.dart';
import 'attractions_screen.dart';
import 'quiz_screen.dart';
import 'rating_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _pages = [
    HomePage(onTabChange: changePage),
    VideoScreen(onBack: () => changePage(0)),
    AttractionsScreen(onBack: () => changePage(0)),
    QuizScreen(onBack: () => changePage(0)),
    RatingScreen(onBack: () => changePage(0)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // تفعيل التصميم الحديث لضمان سلاسة التنقل
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => changePage(index),
          items: const [
            // التعديل هنا: وضعنا الإيموجي مكان الأيقونة التي تسبب المربع
            BottomNavigationBarItem(
              icon: Text("🏠", style: TextStyle(fontSize: 24)), 
              label: "الرئيسية",
            ),
            BottomNavigationBarItem(
              icon: Text("🎥", style: TextStyle(fontSize: 24)), 
              label: "الفيديو",
            ),
            BottomNavigationBarItem(
              icon: Text("🗺️", style: TextStyle(fontSize: 24)), 
              label: "المعالم",
            ),
            BottomNavigationBarItem(
              icon: Text("❓", style: TextStyle(fontSize: 24)), 
              label: "الاختبار",
            ),
            BottomNavigationBarItem(
              icon: Text("⭐", style: TextStyle(fontSize: 24)), 
              label: "التقييم",
            ),
          ],
        ),
      ),
    );
  }
}