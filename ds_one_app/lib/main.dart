import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:avatar_glow/avatar_glow.dart';

void main() {
  runApp(const DSOneApp());
}

class DSOneApp extends StatelessWidget {
  const DSOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LYARA - DS.ONE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.deepPurpleAccent,
      ),
      home: const LyaraHomePage(),
    );
  }
}

class LyaraHomePage extends StatefulWidget {
  const LyaraHomePage({super.key});

  @override
  State<LyaraHomePage> createState() => _LyaraHomePageState();
}

class _LyaraHomePageState extends State<LyaraHomePage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Ative a LYARA para começar';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => debugPrint('STATUS: $val'),
        onError: (val) => debugPrint('ERRO: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
            });
            // Aqui futuramente você pode integrar comandos de voz → GPT/Gemini
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LYARA - DS.ONE Ultra'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Animate(
              effects: const [FadeEffect(), SlideEffect()],
              child: Text(
                _text,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            AvatarGlow(
              glowColor: Colors.deepPurpleAccent,
              animate: _isListening,
              endRadius: 90.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              child: GestureDetector(
                onTap: _listen,
                child: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  radius: 40,
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
