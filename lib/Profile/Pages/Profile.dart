import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foode/Profile/Pages/About.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Admin/AdminLogin.dart';
import '../../Anthitcation/Pages/SignUp.dart';
import '../../Services/SharedPrefancehelper.dart';
import '../../Widget/AppBar.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CustomElevatedButton.dart';
import '../../Widget/SectionHeading.dart';
import '../Widget/SettingMenu.dart';
import 'Order.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();

  String? profile, name, email;
  bool isLoading = true;

  Future<void> getSharedPrefs() async {
    profile = await SharedPreferencesHelper().getUserImage() ?? '';
    name = await SharedPreferencesHelper().getUserName() ?? 'User Name';
    email = await SharedPreferencesHelper().getUserEmail() ?? 'UserName@gmail.com';

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = XFile(image.path);
      await uploadImage();
      setState(() {});
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage != null) {
      setState(() {
        isLoading = true;
      });

      try {
        String fileName = "ProductImage/${randomAlphaNumeric(10)}.jpg";
        final bytes = await File(selectedImage!.path).readAsBytes();

        await Supabase.instance.client.storage
            .from('foody')
            .uploadBinary(fileName, bytes);
        final imageUrl = Supabase.instance.client.storage
            .from('foody')
            .getPublicUrl(fileName);

        await SharedPreferencesHelper().saveUserImage(
            'https://bpeqayuadpfyzempcsqj.supabase.co/storage/v1/object/public/foody/Profile%20Image/user.png');

        setState(() {
          profile = imageUrl;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading image: $e")),
        );
      }
    }
  }

  Future<void> showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Icon(
              Icons.logout,
              size: 35,
              color: Colors.red,
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppWidget.primaryColor, // Blue background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      logout();
    }
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error logging out: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Lottie.asset(
                'assets/Animations/Loading.json',
                fit: BoxFit.contain,
                repeat: true,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(
                      'Account',
                      style: AppWidget.AppBarTextStyle().apply(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppWidget.spaceBtwItemsMd),
                  ListTile(
                    leading: GestureDetector(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: profile == null
                            ? const AssetImage('assets/Images/Categories/ByDefaultProfile.png')
                            : NetworkImage(profile!),
                      ),
                    ),
                    title: Text(
                      name ?? 'User Name',
                      style: AppWidget.UseNameTextStyle().apply(color: Colors.black87),
                    ),
                    subtitle: Text(
                      email ?? 'UserName@gmail.com',
                      style: AppWidget.subTextFieldStyle().apply(color: Colors.black87),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(AppWidget.defaultSpace),
                    child: Column(
                      children: [
                        const SectionHeading(
                          title: 'Account Settings',
                          showActionButton: false,
                        ),
                        const SizedBox(height: AppWidget.spaceBtwItems),
                        Settingmenutile(
                          icon: Icons.shopping_bag_outlined,
                          title: 'My Orders',
                          subTitle: 'In-progress and Completed Orders',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Order(),
                              ),
                            );
                          },
                        ),
                        Settingmenutile(
                          icon: Icons.headset_mic_outlined,
                          title: 'Service',
                          subTitle: 'Help and Feedback',
                          onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const About()));
                          },
                        ),
                        Settingmenutile(
                          icon: Icons.help_center_outlined,
                          title: 'Become a seller',
                          subTitle: 'Start your journey as a seller',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminLogin(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: AppWidget.spaceBtwSections),
                        CustomElevatedButton(
                          onPressed: showLogoutDialog,
                          text: 'Log Out',
                        ),
                        const SizedBox(height: AppWidget.spaceBtwSections * 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
