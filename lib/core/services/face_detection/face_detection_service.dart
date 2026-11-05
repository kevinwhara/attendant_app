import 'dart:async';
import 'package:flutter/widgets.dart';
import 'face_detection_result.dart';

abstract class FaceDetectionService {
  Future<void> initialize();
  Stream<FaceDetectionResult> get detectionStream;
  FaceDetectionResult get currentResult;
  Future<void> startDetection();
  Future<void> stopDetection();
  Future<void> dispose();

  /// Returns a widget showing the camera preview if available
  Widget buildPreview(BuildContext context);
}
