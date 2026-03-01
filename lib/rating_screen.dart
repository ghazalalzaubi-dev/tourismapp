import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  final VoidCallback onBack;

  const RatingScreen({super.key, required this.onBack});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0; 
  final TextEditingController _feedbackController = TextEditingController();

  void _submitRating() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى اختيار عدد النجوم أولاً!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("شكراً لك! 🌹", textAlign: TextAlign.center),
        content: Text(
          "تم استلام تقييمك بـ $_rating نجوم. رأيك يهمنا لتطوير سياحة الأردن.",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _rating = 0;
                  _feedbackController.clear();
                });
              },
              child: const Text(
                "إغلاق",
                style: TextStyle(fontSize: 18, color: Colors.teal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تقييم التطبيق"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        // استبدال أيقونة الرجوع بإيموجي سهم
        leading: IconButton(
          icon: const Text("⬅️", style: TextStyle(fontSize: 22)),
          onPressed: widget.onBack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              // استبدال الأيقونة الكبيرة بإيموجي نجمة
              const Text("⭐", style: TextStyle(fontSize: 80)),
              const SizedBox(height: 20),
              const Text(
                "ما هو رأيك في تجربة تطبيق سياحة الأردن؟",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // صف النجوم التفاعلي باستخدام الإيموجي
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        // إذا كانت النجمة مختارة تظهر ملونة، وإذا لا تظهر باهتة
                        index < _rating ? "⭐" : "⚪", 
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _feedbackController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "اكتب ملاحظاتك هنا (اختياري)...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                  onPressed: _submitRating,
                  child: const Text(
                    "إرسال التقييم",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}