import 'package:flutter/material.dart';

class VisionMode extends StatelessWidget {
  const VisionMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Icon(Icons.remove_red_eye, color: Colors.cyanAccent, size: 72),
          const SizedBox(height: 16),
          const Text(
            "👁️ Visão Jarvis Ativada",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            "Câmera conectada.\nAnalisando objetos e textos em tempo real...",
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              // Em breve aqui: ativar câmera e detecção de objetos
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎥 Câmera ativada")));
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text("Iniciar câmera"),
          ),
        ],
      ),
    );
  }
}
