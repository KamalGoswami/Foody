import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Anthitcation/Pages/SignUp.dart';
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
  String? profile, name, email;
  bool isLoading = true;

  /// Fetch user data from Supabase
  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        // Assuming profile URL is stored in a "profile" bucket
        profile = user.userMetadata?['avatar_url'] as String?;
        name = user.userMetadata?['full_name'] ?? 'User Name';
        email = user.email;
      }
    } catch (e) {
      print("Error fetching user data from Supabase: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Show logout confirmation dialog
  Future<void> showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure to logout?'),
        content: const Icon(Icons.logout, size: 50, color: Colors.red),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Cancel logout
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true), // Confirm logout
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      logout(); // Call logout if user confirms
    }
  }

  /// Log out user
  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUp()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error logging out: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData(); // Load user data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(), // Loading indicator
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
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: profile != null
                    ? NetworkImage(profile!)
                    : const AssetImage('assets/Images/User/user.png')
                as ImageProvider,
              ),
              title: Text(
                name ?? 'User Name',
                style: AppWidget.UseNameTextStyle()
                    .apply(color: Colors.black87),
              ),
              subtitle: Text(
                email ?? 'UserName@gmail.com',
                style: AppWidget.subTextFieldStyle()
                    .apply(color: Colors.black87),
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
                    icon: Icons.security_outlined,
                    title: 'Contact Us',
                    subTitle: 'If you need help Contact Us',
                    onTap: () {
                      // Add your logic for "Contact Us"
                    },
                  ),
                  Settingmenutile(
                    icon: Icons.help_center_outlined,
                    title: 'Become a seller',
                    subTitle: 'Hey everyone',
                    onTap: () {
                      // Add logic for "Become a Seller"
                    },
                  ),
                  const SizedBox(height: AppWidget.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: showLogoutDialog,
                      text: 'Log Out',
                    ),
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
