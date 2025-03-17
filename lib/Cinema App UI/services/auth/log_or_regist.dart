import 'package:cinema_ticket_app/Cinema%20App%20UI/pages/login_page.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show login page
  bool showLoginPage = true;

  // toggle beetween login and register page
  void togglesPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglesPage);
    } else {
      return RegisterPage(onTap: togglesPage);
    }
  }
}
