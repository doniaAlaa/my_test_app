import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/auth/cubit/auth_cubit.dart';
import 'package:test_app/auth/cubit/auth_state.dart';
import 'package:test_app/auth/data/models/user_model.dart';
import 'package:test_app/const/app_colors.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      ///  Bloc Listener
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registered Successfully")),
            );
            Navigator.pop(context);
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Sign up to get started",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /// Name
                          TextFormField(
                            controller: nameController,
                            decoration: _inputStyle("Full Name", Icons.person),
                            validator: (v) =>
                            v!.isEmpty ? "Enter your name" : null,
                          ),

                          const SizedBox(height: 15),

                          /// Email
                          TextFormField(
                            controller: emailController,
                            decoration: _inputStyle("Email", Icons.email),
                            validator: (v) =>
                            !v!.contains("@") ? "Invalid email" : null,
                          ),

                          const SizedBox(height: 15),

                          /// Phone
                          TextFormField(
                            controller: phoneController,
                            decoration: _inputStyle("Phone", Icons.phone),
                            validator: (v) =>
                            v!.length < 11 ? "Invalid phone" : null,
                          ),

                          const SizedBox(height: 15),

                          /// Password
                          TextFormField(
                            controller: passwordController,
                            obscureText: isPasswordHidden,
                            decoration: _inputStyle(
                              "Password",
                              Icons.lock,
                              suffix: IconButton(
                                icon: Icon(isPasswordHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                              ),
                            ),
                            validator: (v) =>
                            v!.length < 6 ? "Weak password" : null,
                          ),

                          const SizedBox(height: 15),

                          /// Confirm Password
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: isConfirmHidden,
                            decoration: _inputStyle(
                              "Confirm Password",
                              Icons.lock,
                              suffix: IconButton(
                                icon: Icon(isConfirmHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isConfirmHidden = !isConfirmHidden;
                                  });
                                },
                              ),
                            ),
                            validator: (v) => v != passwordController.text
                                ? "Passwords don't match"
                                : null,
                          ),

                          const SizedBox(height: 25),

                          /// 🔥 Register Button
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // context.read<AuthCubit>().register(
                                  //   emailController.text,
                                  //   passwordController.text,
                                  // );
                                  context.read<AuthCubit>().register(
                                    UserModel(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label, IconData icon,
      {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}