import 'package:flutter/material.dart';
import 'package:foode/Anthitcation/Pages/Login.dart';
import 'package:foode/Widget/BottomNav.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authgete extends StatelessWidget {
  const Authgete({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Lottie.asset(
                'Assets/Animation/Loading_Animation.json',
                fit: BoxFit.contain,
                repeat: true,
              ),
            ),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return const BottomNav();
        } else {
          return const LoginScreen(); // User is not logged in
        }
      },
    );
  }
}
