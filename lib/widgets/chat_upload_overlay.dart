import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A full-screen animated overlay shown while a WhatsApp chat export is
/// being uploaded to the server.
class ChatUploadOverlay extends StatefulWidget {
  /// Upload progress from 0.0 to 1.0.
  final double progress;

  /// Name of the file being uploaded (shown in the subtitle).
  final String? fileName;

  const ChatUploadOverlay({
    super.key,
    required this.progress,
    this.fileName,
  });

  @override
  State<ChatUploadOverlay> createState() => _ChatUploadOverlayState();
}

class _ChatUploadOverlayState extends State<ChatUploadOverlay>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _particleController;
  late AnimationController _entryController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _entryAnimation;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _entryAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOutCubic,
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _particleController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  String get _progressLabel {
    final pct = (widget.progress * 100).toInt();
    if (pct == 0) return 'Preparing...';
    if (pct < 100) return 'Uploading $pct%';
    return 'Finalising...';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _entryAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _entryAnimation.value,
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.black.withOpacity(0.78),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle radial gradient backdrop
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.85,
                      colors: [
                        Color(0x2210B96B), // #10B96B at ~13 %
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Rotating dashed ring
              AnimatedBuilder(
                animation: _rotateController,
                builder: (_, __) {
                  return Transform.rotate(
                    angle: _rotateController.value * 2 * math.pi,
                    child: CustomPaint(
                      size: const Size(220, 220),
                      painter: _DashedRingPainter(
                        color: const Color(0xFF10B96B).withOpacity(0.35),
                        strokeWidth: 1.5,
                        dashCount: 24,
                      ),
                    ),
                  );
                },
              ),

              // Counter-rotating dashed ring (inner)
              AnimatedBuilder(
                animation: _rotateController,
                builder: (_, __) {
                  return Transform.rotate(
                    angle: -_rotateController.value * 2 * math.pi * 0.7,
                    child: CustomPaint(
                      size: const Size(170, 170),
                      painter: _DashedRingPainter(
                        color: const Color(0xFF10B96B).withOpacity(0.2),
                        strokeWidth: 1,
                        dashCount: 16,
                      ),
                    ),
                  );
                },
              ),

              // Orbiting particles
              AnimatedBuilder(
                animation: _particleController,
                builder: (_, __) {
                  return CustomPaint(
                    size: const Size(260, 260),
                    painter: _OrbitParticlesPainter(
                      progress: _particleController.value,
                    ),
                  );
                },
              ),

              // Centre pulsing icon
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (_, __) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF10B96B),
                            Color(0xFF0A8A4F),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B96B).withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: _WhatsAppUploadIcon(),
                      ),
                    ),
                  );
                },
              ),

              // Text content below
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.22,
                left: 32,
                right: 32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Uploading Chat',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.fileName != null
                          ? widget.fileName!
                          : 'WhatsApp Export',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 28),

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: widget.progress > 0 ? widget.progress : null,
                        minHeight: 6,
                        backgroundColor: Colors.white.withOpacity(0.12),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF10B96B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _progressLabel,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10B96B),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Animated WhatsApp + upload icon composite
// ---------------------------------------------------------------------------

class _WhatsAppUploadIcon extends StatelessWidget {
  const _WhatsAppUploadIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // WhatsApp-style speech bubble outline
        Icon(
          Icons.chat_bubble_rounded,
          color: Colors.white.withOpacity(0.2),
          size: 64,
        ),
        // Upload arrow
        const Icon(
          Icons.cloud_upload_rounded,
          color: Colors.white,
          size: 38,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Custom painters
// ---------------------------------------------------------------------------

class _DashedRingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;

  _DashedRingPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final dashAngle = (2 * math.pi) / dashCount;
    final gapFraction = 0.4;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * (1 - gapFraction);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedRingPainter old) => old.color != color;
}

class _OrbitParticlesPainter extends CustomPainter {
  final double progress;

  _OrbitParticlesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 115.0;
    const particleCount = 5;

    for (int i = 0; i < particleCount; i++) {
      final angle =
          progress * 2 * math.pi + (i * 2 * math.pi / particleCount);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      final opacity = 0.4 + 0.6 * ((math.sin(progress * math.pi * 2 + i) + 1) / 2);
      final particleRadius = 3.0 + 2.0 * ((math.cos(progress * math.pi * 2 + i) + 1) / 2);

      canvas.drawCircle(
        Offset(x, y),
        particleRadius,
        Paint()..color = const Color(0xFF10B96B).withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_OrbitParticlesPainter old) => old.progress != progress;
}
