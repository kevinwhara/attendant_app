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
          backgroundColor: AppColors.error,
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
        statusIcon = Icons.check_circle_outline;
        statusText = 'Face detected. Ready to submit.';
        break;
      case DetectionStatus.multipleFaces:
        statusColor = AppColors.error;
        statusIcon = Icons.group_outlined;
        statusText = 'Multiple faces detected. Only 1 person allowed.';
        break;
      case DetectionStatus.invalidPosition:
        statusColor = AppColors.warning;
        statusIcon = Icons.center_focus_weak_outlined;
        statusText = 'Face not centered. Move to the center.';
        break;
      case DetectionStatus.invalidFaceSize:
        statusColor = AppColors.warning;
        statusIcon = Icons.zoom_in_outlined;
        statusText = 'Adjust your distance to fit inside the frame.';
        break;
      case DetectionStatus.initializing:
        statusColor = AppColors.info;
        statusIcon = Icons.hourglass_top_outlined;
        statusText = 'Initializing camera and scanner...';
        break;
      case DetectionStatus.error:
        statusColor = AppColors.error;
        statusIcon = Icons.error_outline;
        statusText = detectionResult.errorMessage ?? 'Camera/scanner error.';
        break;
      case DetectionStatus.noFace:
        statusColor = AppColors.textMuted;
        statusIcon = Icons.face_outlined;
        statusText = 'Position your face inside the frame.';
        break;
    }

    final isReady = detectionResult.isValidForAttendance;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Camera Preview
          Positioned.fill(
            child: service.buildPreview(context),
          ),

          // Clean Dark Overlay with Cutout Mask
          Positioned.fill(
            child: CustomPaint(
              painter: ScannerOverlayPainter(
                borderColor: isReady ? AppColors.success : Colors.white54,
              ),
            ),
          ),

          // Top Status Pill
          Positioned(
            top: AppSpacing.lg,
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: AppRadius.borderRadiusRound,
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 16),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Controls Container
          Positioned(
            bottom: AppSpacing.xxl,
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (detectionResult.detectionStatus == DetectionStatus.error) ...[
                      OutlinedButton.icon(
                        onPressed: () {
                          ref.read(faceDetectionProvider.notifier).initialize();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white30),
                        ),
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Retry Camera'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: (isReady && !_isSubmitting)
                            ? () => _handleConfirmAttendance(detectionResult)
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: isReady ? AppColors.primary : Colors.grey.shade800,
                          disabledBackgroundColor: Colors.white12,
                          disabledForegroundColor: Colors.white38,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        icon: _isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : Icon(
                                isReady ? Icons.check_circle_outline : Icons.lock_outline,
                                size: 18,
                                color: isReady ? Colors.white : Colors.white38,
                              ),
                        label: Text(
                          _isSubmitting
                              ? 'Recording Attendance...'
                              : (isReady
                                  ? (isCheckIn ? 'Confirm Check In' : 'Confirm Check Out')
                                  : 'Face Required to Submit'),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isReady ? Colors.white : Colors.white38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
    final backgroundPaint = Paint()..color = Colors.black.withValues(alpha: 0.5);
    final ovalWidth = size.width * 0.72;
    final ovalHeight = size.height * 0.44;
    final center = Offset(size.width / 2, size.height * 0.40);
    final ovalRect = Rect.fromCenter(center: center, width: ovalWidth, height: ovalHeight);

    // Draw background with cutout
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, backgroundPaint);

    // Draw clean minimalist frame
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawOval(ovalRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant ScannerOverlayPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor;
  }
}
