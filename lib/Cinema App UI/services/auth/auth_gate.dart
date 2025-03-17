import 'package:cinema_ticket_app/Cinema%20App%20UI/pages/cinema_main_screen.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/services/auth/log_or_regist.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return const CinemaMainScreen();
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}
