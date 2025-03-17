// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cinema_ticket_app/Cinema%20App%20UI/Widget/log_reg_textfield.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/Widget/login_button.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/consts.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final TextEditingController emailController =
      TextEditingController(text: 'trihana@gmail.com');

  final TextEditingController passwordController =
      TextEditingController(text: '123456');

  final authService = AuthService();

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
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
      backgroundColor: appBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          // Center(
          //   child: Icon(
          //     Icons.theaters,
          //     size: 100,
          //     color: Colors.grey[200],
          //   ),
          // ),

          //Lottie.asset('lib/assets/pal.json', height: 300),

          const SizedBox(
            height: 25,
          ),

          // msg, app slogan
          Text(
            "Login",
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
            height: 100,
          ),
          // sign in button
          LoginButton(text: "Login", onTap: login),

          const SizedBox(
            height: 25,
          ),

          // not a member? register now

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?",
                style:
                    TextStyle(color: const Color.fromARGB(255, 219, 219, 219)),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 219, 219, 219),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
