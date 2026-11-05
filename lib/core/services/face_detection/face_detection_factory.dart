import 'face_detection_service.dart';
import 'fake_face_detection_service.dart';
import 'platform_detector_mobile.dart' if (dart.library.js_interop) 'platform_detector_web.dart' as platform;

FaceDetectionService createFaceDetectionService({bool isTest = false}) {
  if (isTest) {
    return FakeFaceDetectionService();
  }
  return platform.createPlatformFaceDetector();
}
