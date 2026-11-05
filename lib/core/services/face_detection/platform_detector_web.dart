import 'face_detection_service.dart';
import 'web_face_detector.dart';

FaceDetectionService createPlatformFaceDetector() => WebFaceDetector();

