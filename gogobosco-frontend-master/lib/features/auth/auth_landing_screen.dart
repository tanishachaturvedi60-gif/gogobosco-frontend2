import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';

class AuthLandingScreen extends StatefulWidget {
  const AuthLandingScreen({super.key});

  @override
  State<AuthLandingScreen> createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends State<AuthLandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.accentYellow,
      body: Stack(
        children: [
          // ── Yellow background
          Container(color: AppTheme.accentYellow),

          // ── Red decorative circle (top right)
          Positioned(
            top: -size.width * 0.3,
            right: -size.width * 0.25,
            child: Container(
              width: size.width * 0.85,
              height: size.width * 0.85,
              decoration: const BoxDecoration(
                color: AppTheme.primaryRed,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Small yellow accent circle (mid left)
          Positioned(
            top: size.height * 0.14,
            left: -30,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Logo + branding (top section)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Hero(
                    tag: 'ggb_logo',
                    child: Image.asset(
                      'assets/ggbLogo.png',
                      height: 64,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'GoGoBosco',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Your gateway to opportunities',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── White card bottom sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(28, 36, 28, 40),
                  decoration: const BoxDecoration(
                    color: AppTheme.backgroundWhite,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 40,
                        offset: Offset(0, -8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 44,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 28),
                          decoration: BoxDecoration(
                            color: AppTheme.borderLight,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),

                      const Text(
                        'Welcome back! 👋',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Sign in to continue your journey',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textMuted,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ── LOGIN BUTTON (Yellow)
                      _LandingButton(
                        label: 'Login',
                        backgroundColor: AppTheme.accentYellow,
                        foregroundColor: AppTheme.textDark,
                        trailingIcon: Icons.arrow_forward_rounded,
                        onTap: () => context.go('/login'),
                      ),

                      const SizedBox(height: 14),

                      // ── CREATE ACCOUNT BUTTON (Red)
                      _LandingButton(
                        label: 'Create Account',
                        backgroundColor: AppTheme.primaryRed,
                        foregroundColor: Colors.white,
                        onTap: () => context.go('/register'),
                      ),

                      const SizedBox(height: 14),

                      // ── GUEST BUTTON (Outline)
                      _LandingButton(
                        label: 'Continue as Guest',
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppTheme.textDark,
                        isOutlined: true,
                        leadingIcon: Icons.person_outline_rounded,
                        onTap: () => context.go('/home'),
                      ),

                      const SizedBox(height: 28),

                      // Terms footer
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                            children: [
                              const TextSpan(text: 'By continuing, you agree to our '),
                              TextSpan(
                                text: 'Terms',
                                style: const TextStyle(
                                  color: AppTheme.primaryRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: ' & '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                  color: AppTheme.primaryRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable landing button
// ─────────────────────────────────────────────────────────────────────────────
class _LandingButton extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final bool isOutlined;
  final VoidCallback onTap;

  const _LandingButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
    this.trailingIcon,
    this.leadingIcon,
    this.isOutlined = false,
  });

  @override
  State<_LandingButton> createState() => _LandingButtonState();
}

class _LandingButtonState extends State<_LandingButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            color: widget.isOutlined ? Colors.transparent : widget.backgroundColor,
            borderRadius: BorderRadius.circular(18),
            border: widget.isOutlined
                ? Border.all(color: AppTheme.borderLight, width: 1.8)
                : null,
            boxShadow: widget.isOutlined
                ? null
                : [
                    BoxShadow(
                      color: widget.backgroundColor.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.leadingIcon != null) ...[
                Icon(widget.leadingIcon, color: widget.foregroundColor, size: 20),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.foregroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              if (widget.trailingIcon != null) ...[
                const SizedBox(width: 10),
                Icon(widget.trailingIcon, color: widget.foregroundColor, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
