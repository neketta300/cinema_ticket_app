// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cinema_ticket_app/Cinema%20App%20UI/Widget/log_reg_textfield.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/Widget/login_button.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/consts.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');
  final TextEditingController emailController =
      TextEditingController(text: 'trihana@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456');

  final authService = AuthService();

  void signUp() async {
    final email = emailController.text;
    final confirmPassword = confirmPasswordController.text;
    final password = passwordController.text;

    if (confirmPassword != password) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
    }
    try {
      await authService.signUpWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: appBackgroundColor,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 45,
              ),

              // msg, app slogan
              Text(
                "Register",
                style: TextStyle(
                    fontSize: 25,
                    color: const Color(0xFFEEEEEE),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Access to purschased tickets",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),

              const SizedBox(
                height: 100,
              ),

              // email textfield
              MyLogRegTextfield(
                controller: emailController,
                hintText: "Email",
                obscurreText: false,
              ),

              const SizedBox(
                height: 20,
              ),
              // password textfield
              MyLogRegTextfield(
                controller: passwordController,
                hintText: "Password",
                obscurreText: true,
              ),

              const SizedBox(
                height: 20,
              ),

              MyLogRegTextfield(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscurreText: true,
              ),
              const SizedBox(
                height: 100,
              ),
              // sign in button
              LoginButton(text: "Login", onTap: signUp),

              const SizedBox(
                height: 25,
              ),

              // not a member? register now

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 219, 219, 219)),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login here",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 219, 219, 219),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
