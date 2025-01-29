import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foode/Widget/CustomElevatedButton.dart';

import '../../Widget/AppWidget.dart';
import '../../Widget/BottomNav.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.shopping_cart_outlined, size: 80, color: AppWidget.primaryColor),
        const SizedBox(height: 20),
        const Text(
          "Your cart is empty!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "Add items to it now.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(AppWidget.defaultSpace),
          child: CustomElevatedButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>const BottomNav()));
            }, text: 'Add To Cart Now ',

          ),
        ),
      ],
    );
  }
}