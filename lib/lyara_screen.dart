import 'package:flutter/material.dart'; import 'package:speech_to_text/speech_to_text.dart' as stt;

class LyaraScreen extends StatefulWidget { const LyaraScreen({Key? key}) : super(key: key);

@override State<LyaraScreen> createState() => _LyaraScreenState(); }

class _LyaraScreenState extends State<LyaraScreen> { late stt.SpeechToText _speech; bool _isListening = false; String _text = 'Toque no microfone para falar com a LYARA'; double _confidence = 1.0;

@override void initState() { super.initState(); _speech = stt.SpeechToText(); }

void _listen() async { if (!_isListening) { bool available = await _speech.initialize( onStatus: (val) => setState(() => _isListening = val == 'listening'), onError: (val) => print('Erro: $val'), ); if (available) { setState(() => _isListening = true); _speech.listen( onResult: (val) => setState(() { _text = val.recognizedWords; if (val.hasConfidenceRating && val.confidence > 0) { _confidence = val.confidence; } }), ); } } else { setState(() => _isListening = false); _speech.stop(); } }

@override Widget build(BuildContext context) { return Scaffold( backgroundColor: Colors.black, appBar: AppBar( backgroundColor: Colors.black, title: Text('👩‍💻 LYARA Ativada'), foregroundColor: Colors.cyanAccent, ), body: Padding( padding: const EdgeInsets.all(16.0), child: Column( children: [ Text( 'Precisão: ${(_confidence * 100.0).toStringAsFixed(1)}%', style: const TextStyle( color: Colors.cyanAccent, fontSize: 16, ), ), const SizedBox(height: 20), Expanded( child: SingleChildScrollView( reverse: true, child: Text( _text, style: const TextStyle( color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w500, ), ), ), ), const SizedBox(height: 20), FloatingActionButton( onPressed: _listen, backgroundColor: Colors.cyanAccent, child: Icon( _isListening ? Icons.mic : Icons.mic_none, color: Colors.black, ), ), ], ), ), ); } }
