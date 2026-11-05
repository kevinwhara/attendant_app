import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/core/services/face_detection/face_detection_result.dart';
import 'package:updated_attendant_app/core/services/face_detection/fake_face_detection_service.dart';

void main() {
  group('FaceDetectionResult rules', () {
    test('Only single valid detected face is allowed for attendance', () {
      final noFace = FaceDetectionResult.noFace();
      expect(noFace.isValidForAttendance, isFalse);
      expect(noFace.detectionStatus, equals(DetectionStatus.noFace));

      final multiple = FaceDetectionResult.multipleFaces(3);
      expect(multiple.isValidForAttendance, isFalse);
      expect(multiple.faceCount, equals(3));
      expect(multiple.detectionStatus, equals(DetectionStatus.multipleFaces));

      final uncentered = FaceDetectionResult.invalidPosition();
      expect(uncentered.isValidForAttendance, isFalse);
      expect(uncentered.detectionStatus, equals(DetectionStatus.invalidPosition));

      final badSize = FaceDetectionResult.invalidFaceSize();
      expect(badSize.isValidForAttendance, isFalse);
      expect(badSize.detectionStatus, equals(DetectionStatus.invalidFaceSize));

      final error = FaceDetectionResult.error('Camera busy');
      expect(error.isValidForAttendance, isFalse);
      expect(error.detectionStatus, equals(DetectionStatus.error));

      final valid = FaceDetectionResult.detected();
      expect(valid.isValidForAttendance, isTrue);
      expect(valid.detectionStatus, equals(DetectionStatus.detected));
      expect(valid.faceCount, equals(1));
    });
  });

  group('FakeFaceDetectionService lifecycle', () {
    test('Lifecycle transitions through stream correctly', () async {
      final service = FakeFaceDetectionService();
      final results = <FaceDetectionResult>[];
      final sub = service.detectionStream.listen(results.add);

      await service.initialize();
      expect(service.currentResult.detectionStatus, equals(DetectionStatus.noFace));

      await service.startDetection();
      expect(service.currentResult.detectionStatus, equals(DetectionStatus.detected));

      await service.stopDetection();
      expect(service.currentResult.detectionStatus, equals(DetectionStatus.noFace));

      await sub.cancel();
      await service.dispose();
      expect(results.length, equals(3));
    });
  });
}
