import 'package:flutter/material.dart';
import 'package:foode/Anthitcation/AnthService.dart';
import 'package:foode/Anthitcation/Widget/AnthHeader.dart';
import 'package:foode/Services/SharedPrefancehelper.dart';
import 'package:foode/Widget/BottomNav.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CustomElevatedButton.dart';
import 'Login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  usersignup() async {
    final email = userEmailController.text;
    final password = userPasswordController.text;
    final name = userNameController.text;
    final Id = randomAlphaNumeric(100);

    setState(() {
      _isLoading = true;
    });

    try {
      await authService.signUpWithEmailPassword(email, password, name);

      await SharedPreferencesHelper().saveUserId(Id);
      await SharedPreferencesHelper().saveUserEmail(email);
      await SharedPreferencesHelper().saveUserName(name);
      await SharedPreferencesHelper().saveUserImage('assets/Images/Categories/ByDefaultProfile.png');

      Map<String, dynamic> userInfoMap = {
        "Name": name,
        "Email": email,
        "Id": Id,
        "Image": "assets/Images/Categories/ByDefaultProfile.png",
      };

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign-Up Successful!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
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
                  const SizedBox(height: AppWidget.defaultSpace),
                  const LoginHeader(title: 'Create Your Account',
                  subtitle: 'Sign Up and get Started',),
                  const SizedBox(height: AppWidget.spaceBtwSections),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: AppWidget.primaryColor,
                            ),
                            labelText: 'Full Name',
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
                          height: AppWidget.spaceBtwSections,
                        ),
                        CustomElevatedButton(
                          onPressed: usersignup, // Call the signup function
                          text: 'Sign Up',
                        ),
                        const SizedBox(
                          height: AppWidget.defaultSpace * 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: AppWidget.subBoldTextFieldStyle(),
                              ),
                              Text(
                                'Log In',
                                style: AppWidget.LinkBoldFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                child:Lottie.asset(
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
