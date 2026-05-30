import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogobosco/services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  String role = "General User";

  bool isLoading = false;
  bool obscurePassword = true;

  /// REGISTER LOGIC
  void register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final res = await AuthService.register(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
        role: role,
      );

      print(res);

      if (!mounted) return;

      context.go('/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔴 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GoGoBosco",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Create Account ✨",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          /// BODY
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// STEP BAR
                    Row(children: [_step(true), _step(true), _step(false)]),

                    const SizedBox(height: 20),

                    /// AVATAR
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.red.shade100,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Add profile photo",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// NAME
                    Row(
                      children: [
                        Expanded(child: _input(firstName, "First Name")),
                        const SizedBox(width: 10),
                        Expanded(child: _input(lastName, "Last Name")),
                      ],
                    ),

                    _input(email, "Email", type: TextInputType.emailAddress),

                    _input(phone, "Phone", type: TextInputType.phone),

                    /// ROLE
                    DropdownButtonFormField<String>(
                      initialValue: role,
                      decoration: _decoration("Role"),
                      items: const [
                        DropdownMenuItem(
                          value: "General User",
                          child: Text("General User"),
                        ),
                        DropdownMenuItem(
                          value: "Student",
                          child: Text("Student"),
                        ),
                        DropdownMenuItem(
                          value: "Job Seeker",
                          child: Text("Job Seeker"),
                        ),
                      ],
                      onChanged: (val) => setState(() => role = val!),
                    ),

                    const SizedBox(height: 12),

                    /// PASSWORD
                    TextFormField(
                      controller: password,
                      obscureText: obscurePassword,
                      validator: (val) => val == null || val.length < 6
                          ? "Min 6 characters"
                          : null,
                      decoration: _decoration("Password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// REGISTER BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Create Account",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// LOGIN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFFD32F2F),
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (val) => val == null || val.isEmpty ? "Required" : null,
        decoration: _decoration(label),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _step(bool done) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 4,
        decoration: BoxDecoration(
          color: done ? const Color(0xFFD32F2F) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
