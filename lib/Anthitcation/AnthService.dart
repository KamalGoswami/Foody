import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Sign in with email And password
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
  }

  /// Sign in with email And password
  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password, String name) async {
    return await _supabase.auth.signUp(password: password, email: email);
  }

  /// Sign out
  Future<void> signout() async {
    await _supabase.auth.signOut();
  }

  /// Get user name from user metadata
  static String? getCurrentUserName() {
    final session = Supabase.instance.client.auth.currentSession;
    final user = session?.user;
    return user!.userMetadata?['name'];
  }


}
