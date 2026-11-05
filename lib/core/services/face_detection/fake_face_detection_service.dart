import 'dart:async';
import 'package:flutter/material.dart';
import 'face_detection_result.dart';
import 'face_detection_service.dart';

class FakeFaceDetectionService implements FaceDetectionService {
  final _controller = StreamController<FaceDetectionResult>.broadcast();
  FaceDetectionResult _currentResult = FaceDetectionResult.initializing();

  @override
  Stream<FaceDetectionResult> get detectionStream => _controller.stream;

  @override
  FaceDetectionResult get currentResult => _currentResult;

  void emitResult(FaceDetectionResult result) {
    _currentResult = result;
    if (!_controller.isClosed) {
      _controller.add(result);
    }
  }

  @override
  Future<void> initialize() async {
    emitResult(FaceDetectionResult.noFace());
  }

  @override
  Future<void> startDetection() async {
    emitResult(FaceDetectionResult.detected());
  }

  @override
  Future<void> stopDetection() async {
    emitResult(FaceDetectionResult.noFace());
  }

  @override
  Future<void> dispose() async {
    await _controller.close();
  }

  @override
  Widget buildPreview(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: const Center(
        child: Icon(
          Icons.face,
          size: 100,
          color: Colors.white38,
        ),
      ),
    );
  }
}

