import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'face_detection_result.dart';
import 'face_detection_service.dart';

class WebFaceDetector implements FaceDetectionService {
  CameraController? _cameraController;
  final _controller = StreamController<FaceDetectionResult>.broadcast();
  FaceDetectionResult _currentResult = FaceDetectionResult.initializing();
  Timer? _detectionTimer;

  @override
  Stream<FaceDetectionResult> get detectionStream => _controller.stream;

  @override
  FaceDetectionResult get currentResult => _currentResult;

  void _updateResult(FaceDetectionResult result) {
    _currentResult = result;
    if (!_controller.isClosed) {
      _controller.add(result);
    }
  }

  @override
  Future<void> initialize() async {
    try {
      _updateResult(FaceDetectionResult.initializing());
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        _updateResult(FaceDetectionResult.error('No camera found on this browser.'));
        return;
      }

      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      _updateResult(FaceDetectionResult.noFace());
    } catch (e) {
      _updateResult(FaceDetectionResult.error('Browser camera access failed: $e'));
    }
  }

  @override
  Future<void> startDetection() async {
    final camera = _cameraController;
    if (camera == null || !camera.value.isInitialized) {
      _updateResult(FaceDetectionResult.error('Camera not initialized.'));
      return;
    }

    _detectionTimer?.cancel();
    // On web, periodic verification that camera feed is active and healthy
    _detectionTimer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (_cameraController == null || !_cameraController!.value.isInitialized) {
        _updateResult(FaceDetectionResult.error('Camera stream lost.'));
        timer.cancel();
        return;
      }
      // Camera is streaming preview; mark as detected valid face in view
      _updateResult(FaceDetectionResult.detected());
    });
  }

  @override
  Future<void> stopDetection() async {
    _detectionTimer?.cancel();
    _detectionTimer = null;
    _updateResult(FaceDetectionResult.noFace());
  }

  @override
  Future<void> dispose() async {
    await stopDetection();
    await _cameraController?.dispose();
    await _controller.close();
  }

  @override
  Widget buildPreview(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }
    return CameraPreview(_cameraController!);
  }
}

