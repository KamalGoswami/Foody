import 'package:flutter/material.dart';
import 'package:foode/Anthitcation/Pages/ForgetPassword.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/BottomNav.dart';
import '../../Widget/CustomElevatedButton.dart';
import '../Widget/AnthHeader.dart';
import '../Widget/FromDivider.dart';
import '../Widget/ScailMediaButton.dart';
import 'SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String email = "";
  String password = "";

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  Future<void> userLogin(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,);

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome back, ${response.user!.userMetadata?['name']}!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(
              userId: response.user!.id,
              userName: response.user!.userMetadata?['name'] ?? "User",
            ),
          ),
        );
      } else {
        throw Exception("Login failed. Please check your email and password.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Login failed. ${e.toString()}'),
      ));
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
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userEmailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
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
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = userEmailController.text.trim();
                                  password = userPasswordController.text.trim();
                                });
                                userLogin(context);
                              }
                            },
                            text: 'Log In',
                          ),
                          const SizedBox(
                            height: AppWidget.defaultSpace * 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
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
                  const FormDivider(dividerText: 'Or Sign In With'),
                  const SizedBox(
                    height: AppWidget.defaultSpace,
                  ),
                  const SocialButtons(),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
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
