import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class InvestmentMode extends StatefulWidget {
  const InvestmentMode({super.key});

  @override
  State<InvestmentMode> createState() => _InvestmentModeState();
}

class _InvestmentModeState extends State<InvestmentMode> {
  final FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speakInfo();
  }

  Future<void> _speakInfo() async {
    await _tts.setLanguage("pt-BR");
    await _tts.setPitch(1.1);
    await _tts.speak("Bem-vindo ao Modo Investimento. Sua carteira está sendo analisada.");
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modo Investimento')),
      body: const Center(
        child: Text(
          '🔍 Aqui vai o painel da carteira de investimentos\n(Lucros, gráficos, rebalanceamento)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
