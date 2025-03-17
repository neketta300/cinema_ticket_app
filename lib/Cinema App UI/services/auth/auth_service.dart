import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return _supabaseClient.auth
        .signInWithPassword(password: password, email: email);
  }

  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password) async {
    return _supabaseClient.auth.signUp(password: password, email: email);
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  String? getCurrentUserEmail() {
    final sessian = _supabaseClient.auth.currentSession;
    final user = sessian?.user;
    return user?.email;
  }
}
