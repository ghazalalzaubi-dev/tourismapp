import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'quiz_screen.dart';

class VideoScreen extends StatefulWidget {
  final VoidCallback onBack;

  const VideoScreen({super.key, required this.onBack});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isVideoFinished = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/jordan.mp4')
      ..initialize().then((_) {
        if (mounted) setState(() {});
      });

    _controller.addListener(() {
      if (_controller.value.isInitialized &&
          _controller.value.position >= _controller.value.duration &&
          !_isVideoFinished) {
        setState(() {
          _isVideoFinished = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _controller.value.isPlaying
          ? _controller.pause()
          : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("فيديو تعريفي 🎥"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // الفيديو
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // شريط التقدم
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.teal,
                        bufferedColor: Colors.tealAccent,
                        backgroundColor: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // زر ابدأ الفيديو
                    ElevatedButton(
                      onPressed: _togglePlay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _controller.value.isPlaying
                            ? "⏸ إيقاف الفيديو"
                            : "🎬 ابدأ الفيديو",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // زر الاختبار
                    ElevatedButton.icon(
                      onPressed: _isVideoFinished
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(
                                    onBack: widget.onBack,
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      icon: const Icon(Icons.quiz),
                      label: Text(
                        _isVideoFinished
                            ? "ابدأ الاختبار الآن"
                            : "شاهد الفيديو كاملاً لتفعيل الاختبار",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(color: Colors.teal),
      ),
    );
  }
}