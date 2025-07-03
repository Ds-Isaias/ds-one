import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class VisionMode extends StatefulWidget {
  const VisionMode({super.key});

  @override
  State<VisionMode> createState() => _VisionModeState();
}

class _VisionModeState extends State<VisionMode> {
  CameraController? _controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras![0], ResolutionPreset.medium);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visão Jarvis')),
      body: Center(
        child: _controller == null || !_controller!.value.isInitialized
            ? const CircularProgressIndicator()
            : CameraPreview(_controller!),
      ),
    );
  }
}
