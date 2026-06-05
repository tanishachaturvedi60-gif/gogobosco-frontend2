import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;
  bool rememberMe = false;

  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    _animController.dispose();
    super.dispose();
  }

  void login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    try {
      await AuthService.login(email: email.text, password: password.text);
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.accentYellow,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── Yellow background
          Container(color: AppTheme.accentYellow),

          // ── Red decorative circle (top right)
          Positioned(
            top: -size.width * 0.28,
            right: -size.width * 0.22,
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: const BoxDecoration(
                color: AppTheme.primaryRed,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Small white accent circle (mid left)
          Positioned(
            top: size.height * 0.13,
            left: -28,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── TOP BAR
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      // Back button
                      GestureDetector(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/auth_landing');
                            }
                          },
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 10, 28, 0),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'ggb_logo',
                        child: Image.asset(
                          'assets/ggbLogo.png',
                          height: 52,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back! 👋',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.2,
                            ),
                          ),
                          Text(
                            'Login to your account',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── FORM CARD
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeIn,
                    child: SlideTransition(
                      position: _slideUp,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.backgroundWhite,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(38),
                          ),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding:
                              const EdgeInsets.fromLTRB(28, 32, 28, 24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Drag handle
                                Center(
                                  child: Container(
                                    width: 44,
                                    height: 5,
                                    margin:
                                        const EdgeInsets.only(bottom: 24),
                                    decoration: BoxDecoration(
                                      color: AppTheme.borderLight,
                                      borderRadius:
                                          BorderRadius.circular(3),
                                    ),
                                  ),
                                ),

                                const Text(
                                  'Login to Account',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Enter your credentials to continue',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.textMuted,
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // ── EMAIL
                                _buildLabel('Email Address'),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: email,
                                  hint: 'gogobosco@gmail.com',
                                  icon: Icons.email_outlined,
                                  keyboardType:
                                      TextInputType.emailAddress,
                                  validator: (val) =>
                                      val == null || val.isEmpty
                                          ? 'Enter your email'
                                          : null,
                                ),

                                const SizedBox(height: 18),

                                // ── PASSWORD
                                _buildLabel('Password'),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  controller: password,
                                  hint: '••••••••',
                                  icon: Icons.lock_outline_rounded,
                                  obscureText: obscurePassword,
                                  validator: (val) =>
                                      val == null || val.length < 6
                                          ? 'Min 6 characters'
                                          : null,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppTheme.textMuted,
                                      size: 20,
                                    ),
                                    onPressed: () => setState(() =>
                                        obscurePassword =
                                            !obscurePassword),
                                  ),
                                ),

                                // ── REMEMBER + FORGOT
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: Checkbox(
                                        value: rememberMe,
                                        activeColor:
                                            AppTheme.accentYellow,
                                        checkColor: AppTheme.textDark,
                                        shape:
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        side: const BorderSide(
                                            color: AppTheme.borderLight,
                                            width: 1.5),
                                        onChanged: (val) => setState(
                                            () =>
                                                rememberMe =
                                                    val ?? false),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Remember me',
                                      style: TextStyle(
                                        color: AppTheme.textMuted,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize
                                                .shrinkWrap,
                                        foregroundColor:
                                            AppTheme.primaryRed,
                                      ),
                                      child: const Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 28),

                                // ── LOGIN BUTTON
                                _ActionButton(
                                  label: 'Login',
                                  backgroundColor: AppTheme.accentYellow,
                                  foregroundColor: AppTheme.textDark,
                                  isLoading: isLoading,
                                  onTap: isLoading ? null : login,
                                ),

                                const SizedBox(height: 28),

                                // ── DIVIDER
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(
                                          color: AppTheme.borderLight,
                                          thickness: 1.2),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      child: Text(
                                        'OR CONTINUE WITH',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                          color: AppTheme.textMuted
                                              .withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Divider(
                                          color: AppTheme.borderLight,
                                          thickness: 1.2),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                // ── GOOGLE + APPLE ROW
                                Row(
                                  children: [
                                    Expanded(
                                      child: _SocialButton(
                                        label: 'Google',
                                        icon: Image.asset(
                                          'assets/search.png',
                                          height: 20,
                                        ),
                                        onTap: () async {
                                          try {
                                            await AuthService.signInWithGoogle();
                                            if (context.mounted) {
                                              context.go('/home');
                                            }
                                          } catch (e) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Google sign‑in failed: $e')),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _SocialButton(
                                        label: 'Apple',
                                        icon: const Icon(
                                          Icons.apple_rounded,
                                          color: AppTheme.textDark,
                                          size: 22,
                                        ),
                                        onTap: () async {
                                          try {
                                            await AuthService.signInWithApple();
                                            if (context.mounted) context.go('/home');
                                          } catch (e) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Apple sign-in failed: $e')),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 28),

                                // ── SIGN UP FOOTER
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account? ",
                                      style: TextStyle(
                                          color: AppTheme.textMuted,
                                          fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          context.go('/register'),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: AppTheme.primaryRed,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppTheme.textDark,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontSize: 15,
        color: AppTheme.textDark,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppTheme.textMuted,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(icon, color: AppTheme.textMuted, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppTheme.bgLight,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
              color: AppTheme.accentYellow, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
              color: AppTheme.primaryRed, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
              color: AppTheme.primaryRed, width: 2),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable primary action button
// ─────────────────────────────────────────────────────────────────────────────
class _ActionButton extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;
  final bool isLoading;

  const _ActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 110),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withValues(alpha: 0.38),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: widget.isLoading
                  ? SizedBox(
                      key: const ValueKey('loader'),
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: widget.foregroundColor,
                      ),
                    )
                  : Text(
                      widget.label,
                      key: const ValueKey('label'),
                      style: TextStyle(
                        color: widget.foregroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.3,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Social sign-in button (outlined)
// ─────────────────────────────────────────────────────────────────────────────
class _SocialButton extends StatefulWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
        duration: const Duration(milliseconds: 110),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppTheme.backgroundWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.borderLight, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
