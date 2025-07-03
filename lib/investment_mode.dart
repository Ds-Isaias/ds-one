import 'package:flutter/material.dart';

class InvestmentMode extends StatelessWidget {
  const InvestmentMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Icon(Icons.trending_up, color: Colors.greenAccent, size: 72),
          const SizedBox(height: 16),
          const Text(
            "💼 Modo Investimento Ativado",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.greenAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            "Sincronizando com o mercado financeiro em tempo real.\nBuscando oportunidades inteligentes...",
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              // Aqui futuramente você pode chamar atualizações, alertas, etc
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("📊 Dados atualizados com sucesso.")));
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Atualizar carteira"),
          ),
        ],
      ),
    );
  }
}
