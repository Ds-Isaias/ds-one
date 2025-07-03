import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'investment_mode.dart';
import 'vision_mode.dart';

void main() {
  runApp(const DSOneApp());
}

class DSOneApp extends StatelessWidget {
  const DSOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DS-ONE | LYARA',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueAccent,
      ),
      home: const LYARAMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum ModoAtivo { neutro, investimento, visao }

class LYARAMain extends StatefulWidget {
  const LYARAMain({super.key});

  @override
  State<LYARAMain> createState() => _LYARAMainState();
}

class _LYARAMainState extends State<LYARAMain> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final FlutterTts _tts = FlutterTts();
  ModoAtivo _modoAtivo = ModoAtivo.neutro;
  String _textoFalado = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _tts.setLanguage("pt-BR");
  }

  void _ouvirComando() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _textoFalado = val.recognizedWords;
            if (_textoFalado.toLowerCase().contains("investimento")) {
              _ativarModo(ModoAtivo.investimento);
            } else if (_textoFalado.toLowerCase().contains("visão")) {
              _ativarModo(ModoAtivo.visao);
            }
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _ativarModo(ModoAtivo modo) async {
    setState(() => _modoAtivo = modo);
    String mensagem = "";

    switch (modo) {
      case ModoAtivo.investimento:
        mensagem = "💼 Modo Investimento ativado. Analisando sua carteira.";
        break;
      case ModoAtivo.visao:
        mensagem = "👁️ Visão Jarvis ativada. Câmera e reconhecimento online.";
        break;
      case ModoAtivo.neutro:
        mensagem = "Modo neutro ativado.";
        break;
    }

    await _tts.speak(mensagem);
  }

  Widget _obterConteudoModo() {
    switch (_modoAtivo) {
      case ModoAtivo.investimento:
        return const InvestmentMode();
      case ModoAtivo.visao:
        return const VisionMode();
      default:
        return const Center(child: Text("Olá! Sou a LYARA 💙 Toque ou fale para começar."));
    }
  }

  Widget _iconeModo(ModoAtivo modo, String label, String asset) {
    final isAtivo = _modoAtivo == modo;
    return GestureDetector(
      onTap: () => _ativarModo(modo),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isAtivo ? Colors.blueAccent.withOpacity(0.3) : Colors.grey[850],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(asset, color: isAtivo ? Colors.blue : Colors.white),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: isAtivo ? Colors.blue : Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DS‑ONE | LYARA"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
            onPressed: _ouvirComando,
          ),
        ],
      ),
      body: Stack(
        children: [
          _obterConteudoModo(),
          Positioned(
            bottom: 90,
            right: 20,
            child: Lottie.asset(
              'assets/animations/lyara_talking.json',
              width: 72,
              height: 72,
              repeat: true,
              animate: _isListening,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(color: Colors.black, boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2)),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _iconeModo(ModoAtivo.investimento, "Investimento", "assets/images/invest_icon.png"),
            _iconeModo(ModoAtivo.visao, "Visão", "assets/images/vision_icon.png"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _speech.stop();
    _tts.stop();
    super.dispose();
  }
}
