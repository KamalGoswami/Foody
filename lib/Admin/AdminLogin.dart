import 'package:flutter/material.dart';
import 'package:foode/Admin/HomeAdmin.dart';
import 'package:foode/Anthitcation/Widget/AnthHeader.dart';
import 'package:foode/Widget/AppWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _errorMessage;

  Future<void> loginAdmin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Debug log for inputs (remove this in production)
      print('Username: ${_usernameController.text.trim()}');
      print('Password: ${_passwordController.text.trim()}');

      // Query admin table
      final response = await Supabase.instance.client
          .from('admin')
          .select()
          .eq('id', _usernameController.text.trim())
          .eq('password', _passwordController.text.trim())
          .maybeSingle();

      if (response == null) {
        setState(() {
          _errorMessage = "Invalid username or password.";
        });
      } else {
        // Successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homeadmin(),
          ),
        );
      }
    } catch (error) {
      setState(() {
        _errorMessage = "An error occurred: ${error.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black87],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  top:
                      Radius.elliptical(MediaQuery.of(context).size.width, 110.0),
                ),
              )),
          Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 160.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LoginHeader(
                  title: "Let's start with\n      Admin",
                ),
                const SizedBox(
                  height: AppWidget.defaultSpace,
                ),
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(
                      color: AppWidget.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppWidget.defaultSpace),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: AppWidget.primaryColor,
                              ),
                              labelText: 'Username',
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
                          const SizedBox(height: AppWidget.defaultSpace),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.password,
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
                            obscureText: !_isPasswordVisible,
                          ),
                          const SizedBox(height: AppWidget.defaultSpace),
                          SizedBox(width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : loginAdmin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppWidget.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: AppWidget.spaceBtwItemsSm,),
                          if (_errorMessage != null)
                            Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),maxLines: 2,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
