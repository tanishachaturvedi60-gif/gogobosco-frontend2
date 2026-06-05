import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/core/theme.dart';
import 'package:gogobosco/services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String role = 'General User';
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirm = true;
  bool agreedToTerms = false;

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
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    _animController.dispose();
    super.dispose();
  }

  void register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms & Privacy Policy'),
        ),
      );
      return;
    }
    setState(() => isLoading = true);
    try {
      await AuthService.register(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
        role: role,
      );
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
      backgroundColor: AppTheme.primaryRed,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── Red background
          Container(color: AppTheme.primaryRed),

          // ── Yellow decorative circle (top right)
          Positioned(
            top: -size.width * 0.28,
            right: -size.width * 0.22,
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: const BoxDecoration(
                color: AppTheme.accentYellow,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Small white accent circle (mid left)
          Positioned(
            top: size.height * 0.12,
            left: -26,
            child: Container(
              width: 76,
              height: 76,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
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
                      Image.asset(
                        'assets/ggbLogo.png',
                        height: 52,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Join GoGoBosco ✨',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.2,
                            ),
                          ),
                          Text(
                            'Explore the world',
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

                const SizedBox(height: 22),

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
                              top: Radius.circular(38)),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
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
                                    margin: const EdgeInsets.only(bottom: 24),
                                    decoration: BoxDecoration(
                                      color: AppTheme.borderLight,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),

                                const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Fill in your details to get started',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.textMuted,
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // ── FIRST + LAST NAME ROW
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildLabeledField(
                                        label: 'First Name',
                                        controller: firstName,
                                        hint: 'John',
                                        icon: Icons.person_outline_rounded,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildLabeledField(
                                        label: 'Last Name',
                                        controller: lastName,
                                        hint: 'Doe',
                                        icon: Icons.person_outline_rounded,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // ── EMAIL
                                _buildLabeledField(
                                  label: 'Email Address',
                                  controller: email,
                                  hint: 'gogobosco@gmail.com',
                                  icon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                ),

                                const SizedBox(height: 16),

                                // ── PHONE
                                _buildLabeledField(
                                  label: 'Phone Number',
                                  controller: phone,
                                  hint: '+91 00000 00000',
                                  icon: Icons.phone_outlined,
                                  keyboardType: TextInputType.phone,
                                ),

                                const SizedBox(height: 16),

                 
                                // ── PASSWORD
                                _buildLabeledField(
                                  label: 'Password',
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
                                        obscurePassword = !obscurePassword),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // ── CONFIRM PASSWORD
                                _buildLabeledField(
                                  label: 'Confirm Password',
                                  controller: confirmPassword,
                                  hint: '••••••••',
                                  icon: Icons.lock_outline_rounded,
                                  obscureText: obscureConfirm,
                                  validator: (val) =>
                                      val != password.text
                                          ? 'Passwords do not match'
                                          : null,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureConfirm
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppTheme.textMuted,
                                      size: 20,
                                    ),
                                    onPressed: () => setState(() =>
                                        obscureConfirm = !obscureConfirm),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // ── TERMS CHECKBOX
                                GestureDetector(
                                  onTap: () => setState(
                                      () => agreedToTerms = !agreedToTerms),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: Checkbox(
                                          value: agreedToTerms,
                                          activeColor: AppTheme.primaryRed,
                                          checkColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                              color: AppTheme.borderLight,
                                              width: 1.5),
                                          onChanged: (val) => setState(() =>
                                              agreedToTerms = val ?? false),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.textMuted,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'I agree to the '),
                                              TextSpan(
                                                text: 'Terms',
                                                style: TextStyle(
                                                  color:
                                                      AppTheme.primaryRed,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(text: ' & '),
                                              TextSpan(
                                                text: 'Privacy Policy',
                                                style: TextStyle(
                                                  color:
                                                      AppTheme.primaryRed,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // ── CREATE ACCOUNT BUTTON
                                _RegisterButton(
                                  label: 'Create Account',
                                  backgroundColor: AppTheme.primaryRed,
                                  foregroundColor: Colors.white,
                                  isLoading: isLoading,
                                  onTap: isLoading ? null : register,
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
                                        'OR SIGN UP WITH',
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
                                      child: _RegSocialButton(
                                        label: 'Google',
                                        icon: Image.asset(
                                          'assets/search.png',
                                          height: 20,
                                        ),
                                        onTap: () async {
                                          try {
                                            await AuthService.signInWithGoogle();
                                            if (context.mounted) context.go('/home');
                                          } catch (e) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Google sign-in failed: $e')),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _RegSocialButton(
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

                                // ── LOGIN FOOTER
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                          color: AppTheme.textMuted,
                                          fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () => context.go('/login'),
                                      child: const Text(
                                        'Login',
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

  Widget _buildLabeledField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator ??
              (val) =>
                  val == null || val.isEmpty ? 'Required' : null,
          style: const TextStyle(
            fontSize: 15,
            color: AppTheme.textDark,
            fontWeight: FontWeight.w600,
          ),
          decoration: _fieldDecoration(hint, icon).copyWith(
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  InputDecoration _fieldDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppTheme.textMuted,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Icon(icon, color: AppTheme.textMuted, size: 20),
      filled: true,
      fillColor: AppTheme.bgLight,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        borderSide:
            const BorderSide(color: AppTheme.primaryRed, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide:
            const BorderSide(color: AppTheme.primaryRed, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide:
            const BorderSide(color: AppTheme.primaryRed, width: 2),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Primary action button
// ─────────────────────────────────────────────────────────────────────────────
class _RegisterButton extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;
  final bool isLoading;

  const _RegisterButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  State<_RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<_RegisterButton> {
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
class _RegSocialButton extends StatefulWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _RegSocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_RegSocialButton> createState() => _RegSocialButtonState();
}

class _RegSocialButtonState extends State<_RegSocialButton> {
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
