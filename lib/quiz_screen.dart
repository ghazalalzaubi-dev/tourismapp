import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizScreen extends StatefulWidget {
  final VoidCallback onBack; // ← أضفنا callback للرجوع

  const QuizScreen({super.key, required this.onBack});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late AudioPlayer _audioPlayer;
  
  int score = 0;
  int currentQuestionIndex = 0;

  final List<Map<String, dynamic>> questions = [
    {'question': 'أين تقع البتراء؟', 'answers': ['معان', 'عمان', 'اربد', 'الزرقاء'], 'correctIndex': 0},
    {'question': 'ما هو اللقب الذي يطلق على مدينة عمان؟', 'answers': ['المدينة الوردية', 'مدينة الحب الأخوي', 'عروس الشمال', 'مدينة الفسيفساء'], 'correctIndex': 1},
    {'question': 'في أي مدينة توجد قلعة عجلون؟', 'answers': ['جرش', 'السلط', 'عجلون', 'الكرك'], 'correctIndex': 2},
    {'question': 'ما هو أخفض نقطة على سطح الأرض في الأردن؟', 'answers': ['خليج العقبة', 'وادي رم', 'البحر الميت', 'نهر الأردن'], 'correctIndex': 2},
    {'question': 'ما هي الزهرة الوطنية للمملكة الأردنية الهاشمية؟', 'answers': ['الياسمين', 'السوسنة السوداء', 'النرجس', 'الأقحوان'], 'correctIndex': 1},
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); 
    super.dispose();
  }

  void _playFeedbackSound(bool isCorrect) async {
    try {
      await _audioPlayer.stop(); 
      if (isCorrect) {
        await _audioPlayer.play(AssetSource('audio/correct.mp3'));
      } else {
        await _audioPlayer.play(AssetSource('audio/wrong.mp3'));
      }
    } catch (e) {
      debugPrint("خطأ في تشغيل الصوت: $e");
    }
  }

  void checkAnswer(int selectedIndex) {
    bool isCorrect = selectedIndex == questions[currentQuestionIndex]['correctIndex'];
    if (isCorrect) score++;
    _playFeedbackSound(isCorrect);

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("انتهى الاختبار! 🎉", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("نتيجتك هي:", style: TextStyle(fontSize: 18)),
            Text("$score من ${questions.length}", 
                 style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal)),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  score = 0;
                  currentQuestionIndex = 0;
                });
              },
              child: const Text("إعادة الاختبار"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("اختبار عن الأردن 🇯🇴", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack, // ← زر الرجوع
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[50]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (currentQuestionIndex + 1) / questions.length,
                        minHeight: 12,
                        backgroundColor: Colors.teal.shade100,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("${currentQuestionIndex + 1}/${questions.length}"),
                ],
              ),
              const SizedBox(height: 40),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    currentQuestion['question'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion['answers'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => checkAnswer(index),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.teal.withOpacity(0.5), width: 1.5),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentQuestion['answers'][index],
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              const Icon(Icons.check_circle_outline, color: Colors.teal, size: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}