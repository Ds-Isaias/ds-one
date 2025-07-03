import 'package:flutter/material.dart';
import 'investment_mode.dart';
import 'vision_mode.dart';

void main() => runApp(const DSOneApp());

class DSOneApp extends StatelessWidget {
  const DSOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DS‑ONE | LYARA',
      theme: ThemeData.dark(),
      home: const MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LYARA - DS‑ONE')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/invest_icon.png', height: 100),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InvestmentMode()),
                );
              },
              icon: const Icon(Icons.show_chart),
              label: const Text('Modo Investimento'),
            ),
            const SizedBox(height: 40),
            Image.asset('assets/images/vision_icon.png', height: 100),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VisionMode()),
                );
              },
              icon: const Icon(Icons.visibility),
              label: const Text('Visão Jarvis'),
            ),
          ],
        ),
      ),
    );
  }
}
