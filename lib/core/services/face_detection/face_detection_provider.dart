import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'face_detection_factory.dart';
import 'face_detection_result.dart';
import 'face_detection_service.dart';

final faceDetectionServiceProvider = Provider<FaceDetectionService>((ref) {
  final service = createFaceDetectionService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

final faceDetectionResultStreamProvider = StreamProvider<FaceDetectionResult>((ref) {
  final service = ref.watch(faceDetectionServiceProvider);
  return service.detectionStream;
});

class FaceDetectionNotifier extends Notifier<FaceDetectionResult> {
  late final FaceDetectionService _service;
  StreamSubscription<FaceDetectionResult>? _subscription;

  @override
  FaceDetectionResult build() {
    _service = ref.watch(faceDetectionServiceProvider);
    _subscription = _service.detectionStream.listen((result) {
      if (ref.mounted) {
        state = result;
      }
    });
    ref.onDispose(() {
      _subscription?.cancel();
    });
    return _service.currentResult;
  }

  Future<void> initialize() => _service.initialize();
  Future<void> startDetection() => _service.startDetection();
  Future<void> stopDetection() => _service.stopDetection();
}

final faceDetectionProvider = NotifierProvider<FaceDetectionNotifier, FaceDetectionResult>(() {
  return FaceDetectionNotifier();
});
