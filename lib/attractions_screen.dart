import 'package:flutter/material.dart';

class AttractionsScreen extends StatelessWidget {
  final VoidCallback onBack; // ← أضفنا callback للرجوع

  const AttractionsScreen({super.key, required this.onBack});

  // كل بطاقة قابلة للنقر
  Widget buildCard(BuildContext context, String name, String imgPath, String shortDesc, String fullDesc) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(name: name, imgPath: imgPath, desc: fullDesc),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shadowColor: Colors.teal.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imgPath,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    shortDesc,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("أهم المعالم السياحية 🇯🇴"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack, // ← زر الرجوع للصفحة الرئيسية
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          buildCard(
            context,
            "البتراء 🌹",
            "assets/image/petra.jpg",
            "المدينة الوردية وأحد عجائب الدنيا.",
            "مدينة البتراء الوردية، إحدى عجائب الدنيا السبع، تقع في محافظة معان جنوب الأردن، وتعتبر موقعًا أثريًا مهمًا يعود إلى الحضارة النبطية. تحتوي على الخزنة والمقابر والمعابد المنحوتة في الصخور الوردية.",
          ),
          buildCard(
            context,
            "جرش 🏛️",
            "assets/image/jerash.jpg",
            "مدينة الألف عمود الرومانية.",
            "جرش، مدينة الألف عمود، تعتبر من أفضل المدن الرومانية المحفوظة في العالم، وتحتوي على المعابد والساحات والمسرح الروماني الشهير. تقع شمال الأردن وتعتبر مقصدًا سياحيًا رائعًا لمحبي التاريخ.",
          ),
          buildCard(
            context,
            "البحر الميت 🌊",
            "assets/image/deadsea.jpeg",
            "أخفض نقطة على سطح الأرض.",
            "البحر الميت، أخفض نقطة على سطح الأرض وأكثر البحار ملوحة في العالم. يشتهر بالطين المعدني وفوائده العلاجية، ويقع بين الأردن وفلسطين ويعتبر مقصدًا صحيًا وسياحيًا رائعًا.",
          ),
          buildCard(
            context,
            "قلعة عجلون 🏰",
            "assets/image/Ajloun.jpg",
            "قلعة تاريخية في شمال الأردن.",
            "قلعة عجلون بنيت في القرن الثاني عشر لحماية المملكة من الغزاة الصليبيين، وتقع في شمال الأردن بين جبال عجلون. تعتبر من المعالم التاريخية المهمة وتوفر إطلالات رائعة على المنطقة المحيطة.",
          ),
          buildCard(
            context,
            "وادي رم 🏜️",
            "assets/image/Wadi Rum.jpeg",
            "صحراء خلابة تعرف بوادي القمر.",
            "وادي رم، المعروف باسم وادي القمر، صحراء خلابة تشتهر بتكويناتها الصخرية المدهشة، مناظرها الطبيعية الفريدة، ورحلات السفاري الصحراوية. تقع جنوب الأردن وتعد من أبرز مناطق السياحة الطبيعية في المملكة.",
          ),
        ],
      ),
    );
  }
}

// صفحة التفاصيل لكل معلم
class DetailScreen extends StatelessWidget {
  final String name;
  final String imgPath;
  final String desc;

  const DetailScreen({super.key, required this.name, required this.imgPath, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name), backgroundColor: Colors.teal),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(imgPath, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                desc,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}