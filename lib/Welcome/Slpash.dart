import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Anthitcation/Pages/Login.dart';
import '../Widget/AppWidget.dart';
import '../Widget/BottomNav.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    // Navigate based on user authentication state after a 3-second delay
    Timer(const Duration(seconds: 3), () async {
      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        // User is logged in; navigate to BottomNav
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(
              userId: user.id,
              userName: user.userMetadata?['username'] ?? 'User',
            ),
          ),
        );
      } else {
        // User is not logged in; navigate to LoginScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('Assets/Images/Logo/FoodyLogo.png')),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Text(
              'By\n Anubhav & Kuldeep',
              style: TextStyle(
                color: AppWidget.primaryColor,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
