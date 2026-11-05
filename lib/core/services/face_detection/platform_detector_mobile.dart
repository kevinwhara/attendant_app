import 'face_detection_service.dart';
import 'mobile_face_detector.dart';

FaceDetectionService createPlatformFaceDetector() => MobileFaceDetector();
