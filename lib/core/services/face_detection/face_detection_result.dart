enum DetectionStatus {
  initializing,
  noFace,
  detected,
  multipleFaces,
  invalidPosition,
  invalidFaceSize,
  error,
}

class FaceDetectionResult {
  final int faceCount;
  final bool isFaceDetected;
  final bool isCentered;
  final bool faceSizeValid;
  final DetectionStatus detectionStatus;
  final String? errorMessage;

  const FaceDetectionResult({
    required this.faceCount,
    required this.isFaceDetected,
    required this.isCentered,
    required this.faceSizeValid,
    required this.detectionStatus,
    this.errorMessage,
  });

  bool get isValidForAttendance => detectionStatus == DetectionStatus.detected;

  factory FaceDetectionResult.initializing() => const FaceDetectionResult(
        faceCount: 0,
        isFaceDetected: false,
        isCentered: false,
        faceSizeValid: false,
        detectionStatus: DetectionStatus.initializing,
      );

  factory FaceDetectionResult.noFace() => const FaceDetectionResult(
        faceCount: 0,
        isFaceDetected: false,
        isCentered: false,
        faceSizeValid: false,
        detectionStatus: DetectionStatus.noFace,
      );

  factory FaceDetectionResult.multipleFaces(int count) => FaceDetectionResult(
        faceCount: count,
        isFaceDetected: true,
        isCentered: false,
        faceSizeValid: false,
        detectionStatus: DetectionStatus.multipleFaces,
        errorMessage: 'Multiple faces detected ($count). Exactly 1 face required.',
      );

  factory FaceDetectionResult.invalidPosition({String? reason}) => FaceDetectionResult(
        faceCount: 1,
        isFaceDetected: true,
        isCentered: false,
        faceSizeValid: true,
        detectionStatus: DetectionStatus.invalidPosition,
        errorMessage: reason ?? 'Face is not centered in the frame.',
      );

  factory FaceDetectionResult.invalidFaceSize({String? reason}) => FaceDetectionResult(
        faceCount: 1,
        isFaceDetected: true,
        isCentered: true,
        faceSizeValid: false,
        detectionStatus: DetectionStatus.invalidFaceSize,
        errorMessage: reason ?? 'Face is too far or too close. Move into the circle.',
      );

  factory FaceDetectionResult.detected() => const FaceDetectionResult(
        faceCount: 1,
        isFaceDetected: true,
        isCentered: true,
        faceSizeValid: true,
        detectionStatus: DetectionStatus.detected,
      );

  factory FaceDetectionResult.error(String message) => FaceDetectionResult(
        faceCount: 0,
        isFaceDetected: false,
        isCentered: false,
        faceSizeValid: false,
        detectionStatus: DetectionStatus.error,
        errorMessage: message,
      );
}
