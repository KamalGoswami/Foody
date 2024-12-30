import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/BottomNav.dart';
import '../../Widget/CustomElevatedButton.dart';
import '../Widget/AnthHeader.dart';
import '../Widget/FromDivider.dart';
import '../Widget/ScailMediaButton.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  bool _isPasswordVisible = false; // For showing/hiding the password
  bool isLoading = false; // For showing the loading indicator

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Supabase Client
  final supabase = Supabase.instance.client;

  // Registration function
  Future<void> registration() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user != null) {
        final userId = response.user!.id;

        // Save user details to Supabase
        await supabase.from('users').insert({
          'id': userId,
          'name': name,
          'email': email,
          'image':
          'https://www.flaticon.com/free-icon/user_149071?term=user&page=1&position=11&origin=search&related_id=149071',
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppWidget.successColor,
          content: Text('Registered Successfully'),
        ));

        // Navigate to the BottomNav page
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNav(
                userId: userId,
                userName: name,
              ),
            ),
          );
        }
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppWidget.errorColor,
        content: Text(
          e.message,
          style: AppWidget.subTextFieldStyle(),
        ),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppWidget.errorColor,
        content: Text(
          'Registration failed. Please try again.',
          style: AppWidget.subTextFieldStyle(),
        ),
      ));
    } finally {
      setState(() {
        isLoading = false; // Stop showing the spinner
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
                  const LoginHeader(
                    title: 'Create Your Account',
                    subtitle: 'Sign Up and get Started',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppWidget.spaceBtwSections),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person_outline,
                                  color: AppWidget.primaryColor),
                              labelText: 'User Name',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppWidget.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppWidget.spaceBtwInputFields),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Invalid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: AppWidget.primaryColor),
                              labelText: 'E-mail',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppWidget.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppWidget.spaceBtwInputFields),
                          TextFormField(
                            controller: passwordController,
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline,
                                  color: AppWidget.primaryColor),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppWidget.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppWidget.spaceBtwSections),
                          CustomElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text.trim();
                                  name = nameController.text.trim();
                                  password = passwordController.text.trim();
                                });
                                await registration();
                              }
                            },
                            text: 'Create Account',
                          ),
                          const SizedBox(height: AppWidget.defaultSpace * 2),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? ",
                                    style: AppWidget.subBoldTextFieldStyle()),
                                Text('Log In',
                                    style: AppWidget.LinkBoldFieldStyle()),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppWidget.spaceBtwSections),
                          const FormDivider(dividerText: 'Or Sign In With'),
                          const SizedBox(height: AppWidget.spaceBtwSections),
                          const SocialButtons(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Lottie.asset(
                  'Assets/Animation/Loading_Animation.json',
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
