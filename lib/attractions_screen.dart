import 'package:flutter/material.dart';

class Attraction {
  final String name;
  final String imgPath;
  final String shortDesc;
  final String fullDesc;

  Attraction(
    this.name,
    this.imgPath,
    this.shortDesc,
    this.fullDesc,
  );
}

class AttractionsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const AttractionsScreen({super.key, required this.onBack});

  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {

  late List<Attraction> attractions;

  @override
  void initState() {
    super.initState();

    attractions = [
      Attraction(
        "البتراء 🌹",
        "assets/image/petra.jpg",
        "المدينة الوردية وأحد عجائب الدنيا.",
        "مدينة البتراء الوردية تعتبر من أشهر المواقع الأثرية في العالم وتقع في جنوب الأردن.",
      ),
      Attraction(
        "جرش 🏛️",
        "assets/image/jerash.jpg",
        "مدينة الألف عمود الرومانية.",
        "جرش من أفضل المدن الرومانية المحفوظة خارج إيطاليا وتشتهر بأعمدتها الضخمة.",
      ),
      Attraction(
        "البحر الميت 🌊",
        "assets/image/deadsea.jpeg",
        "أخفض نقطة على سطح الأرض.",
        "البحر الميت يتميز بملوحته العالية التي تسمح للناس بالطفو بسهولة.",
      ),
      Attraction(
        "قلعة عجلون 🏰",
        "assets/image/Ajloun.jpg",
        "قلعة تاريخية في شمال الأردن.",
        "بنيت قلعة عجلون في القرن الثاني عشر لحماية المنطقة من الغزوات.",
      ),
      Attraction(
        "وادي رم 🏜️",
        "assets/image/Wadi Rum.jpeg",
        "صحراء خلابة تعرف بوادي القمر.",
        "وادي رم يتميز بمناظره الصحراوية الجميلة ويعد من أهم المواقع السياحية في الأردن.",
      ),
    ];
  }

  Widget buildCard(BuildContext context, Attraction attr) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(
              name: attr.name,
              imgPath: attr.imgPath,
              desc: attr.fullDesc,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.asset(
                attr.imgPath,
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
                    attr.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    attr.shortDesc,
                    style: const TextStyle(fontSize: 16),
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
          onPressed: widget.onBack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: attractions
            .map((attr) => buildCard(context, attr))
            .toList(),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String name;
  final String imgPath;
  final String desc;

  const DetailScreen({
    super.key,
    required this.name,
    required this.imgPath,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.teal,
      ),
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