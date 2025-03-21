import 'package:flutter/material.dart';
import 'package:foode/Widget/AppBar.dart';
import 'package:foode/Widget/AppWidget.dart';
import '../../Widget/CustomElevatedButton.dart';
import '../../main.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  dynamic selectedImage;
  String? fileName;
  List<int>? bytes;
  dynamic value;

  Future<void> uploadFeedback() async {
    if (nameController.text.isNotEmpty && detailsController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {
        Map<String, dynamic> addItem = {
          "name": nameController.text,
          "description": detailsController.text,
        };


        await supabase.from('feedback').insert(addItem);

        setState(() {
          nameController.clear();
          detailsController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Feedback uploaded successfully"),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error uploading feedback: $e"),
        ));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please fill in both fields."),
      ));
    }
  }

  // Function to open the URL
  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'About Us',
          style: AppWidget.AppBarTextStyle(),
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppWidget.defaultSpace),
          child: Column(
            children: [
              const Text(
                '''       Foody is a dynamic food ordering app designed to streamline the process of ordering food and managing food-related services. Developed by Kuldeep and Anubhav, this app aims to provide a seamless user experience for both customers and administrators. The app offers an intuitive interface for users to browse through a variety of food items, add them to their cart, and place orders with just a few taps.''',
              ),
              const SizedBox(height: AppWidget.spaceBtwItems),
              const Text('''       The core functionality of 'Foody' revolves around simplifying the food ordering experience for users, offering features such as real-time updates on order status, a user-friendly checkout process, and payment gateway integration for smooth transactions. Customers can easily search for restaurants, view menus, and customize their orders based on preferences. Additionally, the app supports multiple payment methods for convenience.'''),
              const SizedBox(height: AppWidget.spaceBtwItems),
              const Text('''      From the admin side, 'Foody' provides a comprehensive admin panel that allows restaurant owners and managers to efficiently manage orders, track deliveries, update menus, and monitor inventory. The admin panel also enables the creation and management of special offers and promotions, ensuring restaurant owners can boost customer engagement and satisfaction.'''),
              const SizedBox(height: AppWidget.spaceBtwItems),
              const Text('''       Both Kuldeep and Anubhav worked collaboratively to ensure the app's performance, security, and user experience are optimized. The development focuses on providing a robust and scalable solution that can handle high traffic and ensure timely order deliveries. The goal of 'Foody' is to revolutionize food ordering by offering a streamlined solution for users and a powerful management tool for restaurant administrators.'''),
              const SizedBox(height: AppWidget.spaceBtwItems),
              const Divider(thickness: 1),
              const SizedBox(height: AppWidget.spaceBtwItems),
              const SizedBox(height: AppWidget.spaceBtwItems),
              TextField(
                controller: nameController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: AppWidget.spaceBtwSections),
              TextField(
                controller: detailsController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter Your Feedback',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: AppWidget.defaultSpace * 1.2),
              CustomElevatedButton(
                onPressed: uploadFeedback,
                text: isLoading ? 'Uploading...' : 'Add Your Feedback',
              ),
              const SizedBox(height: AppWidget.spaceBtwSections),

              /// Social media images row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _launchUrl('https://www.linkedin.com/in/kamal-goswami-8b41902b8?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app');
                    },
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        image: AssetImage('assets/Images/Categories/boy.png'),
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppWidget.spaceBtwSections*1.5),
                  GestureDetector(
                    onTap: () {
                      _launchUrl('https://www.instagram.com/tra___guy___?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        image: AssetImage('assets/Images/Categories/man.png'),
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppWidget.spaceBtwSections,)
            ],
          ),
        ),
      ),
    );
  }
}
