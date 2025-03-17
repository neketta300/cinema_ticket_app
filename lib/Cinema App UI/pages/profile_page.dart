import 'package:cinema_ticket_app/Cinema%20App%20UI/Widget/login_button.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/consts.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = AuthService();

  void logout() async {
    await _auth.signOut();
    // Navigate to login page or other appropriate action when logout is successful.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoginButton(
              text: "Logout",
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
