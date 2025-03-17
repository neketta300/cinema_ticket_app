import 'package:cinema_ticket_app/Cinema%20App%20UI/services/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://ldfbzdgnkryfrgcnlvtj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxkZmJ6ZGdua3J5ZnJnY25sdnRqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE3NzU0OTQsImV4cCI6MjA1NzM1MTQ5NH0.oCcnLwKVXeyp27l_cLLJ0oEv_DvzkkyA5B0WE43EaNw');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root widget of the app
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox("Box");
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HiveDatabaseFlutter(),
//     );
//   }
// }
