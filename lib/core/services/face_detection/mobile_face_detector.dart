import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'face_detection_result.dart';
import 'face_detection_service.dart';

class MobileFaceDetector implements FaceDetectionService {
  CameraController? _cameraController;
  FaceDetector? _faceDetector;
  final _controller = StreamController<FaceDetectionResult>.broadcast();
  FaceDetectionResult _currentResult = FaceDetectionResult.initializing();
  bool _isProcessing = false;
  CameraDescription? _cameraDescription;

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
        _updateResult(FaceDetectionResult.error('No camera found on this device.'));
        return;
      }

      // Prioritize front camera for attendance selfie
      _cameraDescription = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        _cameraDescription!,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: defaultTargetPlatform == TargetPlatform.android
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );

      await _cameraController!.initialize();

      _faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          performanceMode: FaceDetectorMode.fast,
          minFaceSize: 0.15,
        ),
      );

      _updateResult(FaceDetectionResult.noFace());
    } catch (e) {
      _updateResult(FaceDetectionResult.error('Failed to initialize camera: ${e.toString()}'));
    }
  }

  @override
  Future<void> startDetection() async {
    final camera = _cameraController;
    if (camera == null || !camera.value.isInitialized) {
      _updateResult(FaceDetectionResult.error('Camera not initialized.'));
      return;
    }

    if (camera.value.isStreamingImages) {
      return;
    }

    try {
      await camera.startImageStream((CameraImage image) {
        if (_isProcessing) return;
        _isProcessing = true;
        _processCameraImage(image).then((_) {
          _isProcessing = false;
        }).catchError((e) {
          _isProcessing = false;
        });
      });
    } catch (e) {
      _updateResult(FaceDetectionResult.error('Failed to start image stream: $e'));
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    final detector = _faceDetector;
    if (detector == null || _cameraDescription == null) return;

    final inputImage = _convertCameraImageToInputImage(image, _cameraDescription!);
    if (inputImage == null) return;

    try {
      final faces = await detector.processImage(inputImage);
      if (faces.isEmpty) {
        _updateResult(FaceDetectionResult.noFace());
        return;
      }

      if (faces.length > 1) {
        _updateResult(FaceDetectionResult.multipleFaces(faces.length));
        return;
      }

      final face = faces.first;
      final imageWidth = (inputImage.metadata?.size.width ?? image.width.toDouble());
      final imageHeight = (inputImage.metadata?.size.height ?? image.height.toDouble());

      final boundingBox = face.boundingBox;
      final centerX = boundingBox.center.dx / imageWidth;
      final centerY = boundingBox.center.dy / imageHeight;
      final faceWidthFraction = boundingBox.width / imageWidth;

      final isCentered = (centerX >= 0.25 && centerX <= 0.75) &&
                         (centerY >= 0.20 && centerY <= 0.80);

      final isSizeValid = (faceWidthFraction >= 0.18 && faceWidthFraction <= 0.85);

      if (!isCentered) {
        _updateResult(FaceDetectionResult.invalidPosition());
      } else if (!isSizeValid) {
        _updateResult(FaceDetectionResult.invalidFaceSize());
      } else {
        _updateResult(FaceDetectionResult.detected());
      }
    } catch (e) {
      _updateResult(FaceDetectionResult.error('Detection error: $e'));
    }
  }

  InputImage? _convertCameraImageToInputImage(
    CameraImage image,
    CameraDescription camera,
  ) {
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;

    final plane = image.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  @override
  Future<void> stopDetection() async {
    if (_cameraController != null && _cameraController!.value.isStreamingImages) {
      await _cameraController!.stopImageStream();
    }
    _updateResult(FaceDetectionResult.noFace());
  }

  @override
  Future<void> dispose() async {
    await stopDetection();
    await _cameraController?.dispose();
    await _faceDetector?.close();
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

