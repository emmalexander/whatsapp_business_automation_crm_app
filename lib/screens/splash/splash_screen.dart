import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_business_automation_crm_app/screens/main_navigation.dart';
import 'package:whatsapp_business_automation_crm_app/screens/onboarding/onboarding_screen.dart';
import 'package:whatsapp_business_automation_crm_app/services/token_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ─── animation controllers ───────────────────────────────────────────────
  late final AnimationController _bgController;
  late final AnimationController _logoController;
  late final AnimationController _pulseController;
  late final AnimationController _textController;
  late final AnimationController _particleController;

  // ─── animations ──────────────────────────────────────────────────────────
  late final Animation<double> _bgScale;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoY;
  late final Animation<double> _pulse;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _particleRotation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Background radial scale
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _bgScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeOutExpo),
    );

    // Logo entrance
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _logoY = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
    );

    // Continuous pulse glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Text fade-in + slide
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    // Slow background orbit
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    _particleRotation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_particleController);

    _startSequence();
  }

  Future<void> _startSequence() async {
    // 1. Kick off background + particle animations immediately
    _bgController.forward();

    // 2. Logo enters slightly after background
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    // 3. Tagline fades in
    await Future.delayed(const Duration(milliseconds: 700));
    _textController.forward();

    // 4. While animations play, check auth in parallel
    await Future.delayed(const Duration(milliseconds: 1000));
    await _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final tokenService = TokenStorageService();
    final accessToken = await tokenService.getAccessToken();
    final refreshToken = await tokenService.getRefreshToken();

    final isAuthenticated =
        accessToken != null &&
        accessToken.isNotEmpty &&
        refreshToken != null &&
        refreshToken.isNotEmpty;

    if (!mounted) return;

    final destination = isAuthenticated
        ? const MainNavigation()
        : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _bgController.dispose();
    _logoController.dispose();
    _pulseController.dispose();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF07421F),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Deep green radial gradient background ──────────────────────
          _buildBackground(size),

          // ── Orbiting decorative particles ─────────────────────────────
          _buildParticles(size),

          // ── Center content ─────────────────────────────────────────────
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glowing logo mark
              _buildLogoMark(),

              const SizedBox(height: 28),

              // App name
              _buildAppName(),

              const SizedBox(height: 12),

              // Tagline
              _buildTagline(),
            ],
          ),

          // ── Bottom loading indicator ───────────────────────────────────
          _buildBottomDots(),
        ],
      ),
    );
  }

  // ─── background ──────────────────────────────────────────────────────────

  Widget _buildBackground(Size size) {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return CustomPaint(
          painter: _BackgroundPainter(progress: _bgScale.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  // ─── orbiting particles ───────────────────────────────────────────────────

  Widget _buildParticles(Size size) {
    return AnimatedBuilder(
      animation: _particleRotation,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(
            rotation: _particleRotation.value,
            center: Offset(size.width / 2, size.height / 2),
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  // ─── logo mark ────────────────────────────────────────────────────────────

  Widget _buildLogoMark() {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoController, _pulseController]),
      builder: (context, child) {
        return Opacity(
          opacity: _logoOpacity.value,
          child: Transform.translate(
            offset: Offset(0, _logoY.value),
            child: Transform.scale(
              scale: _logoScale.value,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow ring
                  Transform.scale(
                    scale: _pulse.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF13BA5E).withValues(alpha: 0.25),
                            const Color(0xFF13BA5E).withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Inner glow ring
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                  ),

                  // Logo tile
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1FD175), Color(0xFF13BA5E)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF13BA5E).withValues(alpha: 0.6),
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: CustomPaint(painter: _LogoPainter()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ─── app name ─────────────────────────────────────────────────────────────

  Widget _buildAppName() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Opacity(
          opacity: _logoOpacity.value,
          child: Transform.translate(
            offset: Offset(0, _logoY.value * 0.6),
            child: Text(
              'LedgeCRM',
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1.2,
              ),
            ),
          ),
        );
      },
    );
  }

  // ─── tagline ──────────────────────────────────────────────────────────────

  Widget _buildTagline() {
    return FadeTransition(
      opacity: _textOpacity,
      child: SlideTransition(
        position: _textSlide,
        child: Text(
          'Your WhatsApp sales command centre',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.60),
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // ─── bottom loading dots ──────────────────────────────────────────────────

  Widget _buildBottomDots() {
    return Positioned(
      bottom: 56,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _textOpacity,
        child: const _BouncingDots(),
      ),
    );
  }
}

// ─── Bouncing dots loading indicator ─────────────────────────────────────────

class _BouncingDots extends StatefulWidget {
  const _BouncingDots();

  @override
  State<_BouncingDots> createState() => _BouncingDotsState();
}

class _BouncingDotsState extends State<_BouncingDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
    _animations = _controllers
        .map(
          (c) => Tween<double>(
            begin: 0.0,
            end: -10.0,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut)),
        )
        .toList();

    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animations[i].value),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == 0
                      ? const Color(0xFF13BA5E)
                      : Colors.white.withValues(alpha: i == 1 ? 0.5 : 0.25),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// ─── Background painter (radial burst + mesh lines) ──────────────────────────

class _BackgroundPainter extends CustomPainter {
  final double progress;
  _BackgroundPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.42);

    // Subtle top radial glow
    final topGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF1FD175).withValues(alpha: 0.30 * progress),
          const Color(0xFF13BA5E).withValues(alpha: 0.10 * progress),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: size.width * 1.0));
    canvas.drawCircle(center, size.width * progress, topGlow);

    // Bottom vignette (darker edge)
    final bottomVignette = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          const Color(0xFF031A0D).withValues(alpha: 0.6 * progress),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.5, size.width, size.height * 0.5),
      bottomVignette,
    );

    // Subtle mesh grid lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03 * progress)
      ..strokeWidth = 0.8;

    const spacing = 36.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) => old.progress != progress;
}

// ─── Orbiting particle painter ────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  final double rotation;
  final Offset center;

  _ParticlePainter({required this.rotation, required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..style = PaintingStyle.fill;

    // Three rings of orbiting dots at different radii/speeds
    final rings = [
      _Ring(radius: 130, count: 6, dotSize: 3, opacity: 0.18, speedMul: 1.0),
      _Ring(radius: 185, count: 8, dotSize: 2, opacity: 0.10, speedMul: 0.65),
      _Ring(radius: 240, count: 5, dotSize: 4, opacity: 0.07, speedMul: 0.35),
    ];

    for (final ring in rings) {
      final angleStep = (2 * math.pi) / ring.count;
      for (int i = 0; i < ring.count; i++) {
        final angle = rotation * ring.speedMul + angleStep * i;
        final x = center.dx + ring.radius * math.cos(angle);
        final y = center.dy + ring.radius * math.sin(angle);
        dotPaint.color = const Color(
          0xFF13BA5E,
        ).withValues(alpha: ring.opacity);
        canvas.drawCircle(Offset(x, y), ring.dotSize, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) =>
      old.rotation != rotation || old.center != center;
}

class _Ring {
  final double radius;
  final int count;
  final double dotSize;
  final double opacity;
  final double speedMul;

  const _Ring({
    required this.radius,
    required this.count,
    required this.dotSize,
    required this.opacity,
    required this.speedMul,
  });
}

// ─── Logo CustomPainter (reused from app_logo / onboarding) ──────────────────

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    // Left shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * 0.4, size.height * 0.7),
        const Radius.circular(2),
      ),
      paint,
    );
    // Right shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.5,
          size.height * 0.3,
          size.width * 0.5,
          size.height * 0.7,
        ),
        const Radius.circular(2),
      ),
      paint,
    );
    // Overlap bridge shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.3,
          size.height * 0.4,
          size.width * 0.4,
          size.height * 0.2,
        ),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
