import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/services/face_detection/face_detection_provider.dart';
import '../../../core/services/face_detection/face_detection_result.dart';
import 'attendance_providers.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  final String actionType; // 'checkin' or 'checkout'

  const ScannerScreen({
    super.key,
    required this.actionType,
  });

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  bool _isSubmitting = false;
  FaceDetectionNotifier? _faceNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _faceNotifier = ref.read(faceDetectionProvider.notifier);
      await _faceNotifier?.initialize();
      await _faceNotifier?.startDetection();
    });
  }

  @override
  void dispose() {
    _faceNotifier?.stopDetection();
    super.dispose();
  }

  Future<void> _handleConfirmAttendance(FaceDetectionResult result) async {
    if (!result.isValidForAttendance || _isSubmitting) return;

    setState(() => _isSubmitting = true);
    final isCheckIn = widget.actionType == 'checkin';
    final controller = ref.read(attendanceControllerProvider.notifier);

    final success = isCheckIn
        ? await controller.checkIn(faceDetected: true)
        : await controller.checkOut(faceDetected: true);

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      context.pushReplacement(
        '/attendance/confirmation?type=${widget.actionType}&status=success',
      );
    } else {
      final error = ref.read(attendanceControllerProvider).errorMessage ?? 'Attendance recording failed.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.primaryDark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(faceDetectionServiceProvider);
    final detectionResult = ref.watch(faceDetectionProvider);
    final isCheckIn = widget.actionType == 'checkin';
    final title = isCheckIn ? 'Check In Face Scanner' : 'Check Out Face Scanner';

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (detectionResult.detectionStatus) {
      case DetectionStatus.detected:
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        statusText = 'Face Detected — Hold steady & tap submit';
        break;
      case DetectionStatus.multipleFaces:
        statusColor = AppColors.primary;
        statusIcon = Icons.group;
        statusText = 'Multiple faces detected. Only 1 person allowed.';
        break;
      case DetectionStatus.invalidPosition:
        statusColor = AppColors.warning;
        statusIcon = Icons.center_focus_weak;
        statusText = 'Face not centered. Move into the center.';
        break;
      case DetectionStatus.invalidFaceSize:
        statusColor = AppColors.warning;
        statusIcon = Icons.zoom_in;
        statusText = 'Adjust your distance to fit inside the oval.';
        break;
      case DetectionStatus.initializing:
        statusColor = Colors.blue;
        statusIcon = Icons.hourglass_top;
        statusText = 'Initializing camera and scanner...';
        break;
      case DetectionStatus.error:
        statusColor = AppColors.primary;
        statusIcon = Icons.error_outline;
        statusText = detectionResult.errorMessage ?? 'Camera/scanner error.';
        break;
      case DetectionStatus.noFace:
        statusColor = Colors.orange;
        statusIcon = Icons.face_retouching_natural;
        statusText = 'Position your face clearly within the oval.';
        break;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Camera Preview
          Positioned.fill(
            child: service.buildPreview(context),
          ),

          // Dark Overlay with Cutout Mask
          Positioned.fill(
            child: CustomPaint(
              painter: ScannerOverlayPainter(
                borderColor: statusColor,
              ),
            ),
          ),

          // Header Instruction
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(statusIcon, color: statusColor, size: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      statusText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (detectionResult.detectionStatus == DetectionStatus.error) ...[
                  FilledButton.icon(
                    onPressed: () {
                      ref.read(faceDetectionProvider.notifier).initialize();
                    },
                    style: FilledButton.styleFrom(backgroundColor: Colors.white24),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry Camera'),
                  ),
                  const SizedBox(height: 12),
                ],
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: (detectionResult.isValidForAttendance && !_isSubmitting)
                        ? () => _handleConfirmAttendance(detectionResult)
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: detectionResult.isValidForAttendance
                          ? AppColors.primary
                          : Colors.grey.shade800,
                      disabledBackgroundColor: Colors.grey.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Icon(
                            detectionResult.isValidForAttendance
                                ? Icons.verified_user
                                : Icons.lock_outline,
                            color: Colors.white,
                          ),
                    label: Text(
                      _isSubmitting
                          ? 'Recording Attendance...'
                          : (detectionResult.isValidForAttendance
                              ? (isCheckIn ? 'Confirm Check In' : 'Confirm Check Out')
                              : 'Face Required to Submit'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final Color borderColor;

  ScannerOverlayPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = Colors.black.withValues(alpha: 0.55);
    final ovalWidth = size.width * 0.72;
    final ovalHeight = size.height * 0.46;
    final center = Offset(size.width / 2, size.height * 0.40);
    final ovalRect = Rect.fromCenter(center: center, width: ovalWidth, height: ovalHeight);

    // Draw background with hole
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, backgroundPaint);

    // Draw Oval Guide Border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawOval(ovalRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant ScannerOverlayPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor;
  }
}
