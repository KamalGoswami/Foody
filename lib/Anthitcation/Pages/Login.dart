import 'package:flutter/material.dart';
import 'package:foode/Anthitcation/AnthService.dart';
import 'package:foode/Widget/BottomNav.dart';
import 'package:lottie/lottie.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CustomElevatedButton.dart';
import '../Widget/AnthHeader.dart';
import 'ForgetPassword.dart';
import 'SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  userlogin() async {
    final email = userEmailController.text;
    final password = userPasswordController.text;

    setState(() {
      _isLoading = true; // Start loading animation
    });

    try {
      await authService.signInWithEmailPassword(email, password);


      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNav(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: AppWidget.PaddingWithAppBarHeight,
              child: Column(
                children: [
                  const LoginHeader(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppWidget.spaceBtwSections,
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userEmailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppWidget.primaryColor,
                              ),
                              labelText: 'E-mail',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppWidget.primaryColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppWidget.spaceBtwInputFields),
                          TextFormField(
                            controller: userPasswordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: AppWidget.primaryColor,
                              ),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppWidget.primaryColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppWidget.spaceBtwInputFields / 2,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ForgotPassword()));
                              },
                              child: const Text(
                                'Forget Password',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppWidget.spaceBtwSections,
                          ),
                          CustomElevatedButton(
                            onPressed: userlogin, // Call the login function
                            text: 'Log In',
                          ),
                          const SizedBox(
                            height: AppWidget.defaultSpace * 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: AppWidget.subBoldTextFieldStyle(),
                                ),
                                Text(
                                  'Sign Up',
                                  style: AppWidget.LinkBoldFieldStyle(),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppWidget.defaultSpace / 3,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppWidget.defaultSpace,
                  ),
                ],
              ),
            ),
          ),

          // Loading Overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Lottie.asset(
                  'assets/Animations/Loading.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
                ),
              ),

        ],
      ),
    );
  }
}
