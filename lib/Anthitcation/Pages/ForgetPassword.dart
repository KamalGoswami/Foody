import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Widget/AppWidget.dart';
import '../../Widget/CustomElevatedButton.dart';
import 'SignUp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = "";

  /// Reset password function using Supabase
  Future<void> resetPassword() async {
    try {
      // Get the email from the controller
      email = emailController.text.trim();

      // Attempt to send the reset password email using Supabase
      final response = await Supabase.instance.client.auth.api
          .resetPasswordForEmail(email);

      // Check for errors in the response
      if (response.error == null) {
        // Success - Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email has been sent!'),
          ),
        );
      } else {
        // Handle error - show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.error?.message}'),
          ),
        );
      }
    } catch (e) {
      // If there's an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Password Recovery',
                  style: AppWidget.AppBarTextStyle(),
                ),
              ),
              const SizedBox(height: AppWidget.defaultSpace),
              Text(
                'Enter Your E-mail',
                style: AppWidget.subBoldFieldStyle(),
              ),
              Padding(
                padding: const EdgeInsets.all(AppWidget.defaultSpace),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Invalid email address';
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
                        borderSide: const BorderSide(width: 1.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppWidget.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppWidget.spaceBtwItems,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        resetPassword(); // Call the resetPassword function
                      }
                    },
                    text: 'Send Email',
                  ),
                ),
              ),
              const SizedBox(height: AppWidget.spaceBtwSections),
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
                      "Don't have an Account?",
                      style: AppWidget.subBoldTextFieldStyle(),
                    ),
                    const SizedBox(width: AppWidget.spaceBtwItems / 3),
                    Text(
                      "Login",
                      style: AppWidget.LinkBoldFieldStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on GoTrueClient {
  get api => null;

}
