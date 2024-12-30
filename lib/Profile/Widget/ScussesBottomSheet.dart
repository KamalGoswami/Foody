import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CustomElevatedButton.dart';


void showOrderSuccessModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie Animation
            SizedBox(
              height: 120,
              child: Lottie.asset(
                'Assets/Animation/Animation_Success.json', // Path to your Lottie file
                fit: BoxFit.contain,
                repeat: false, // Animation plays once
              ),
            ),
            const SizedBox(height: AppWidget.spaceBtwItems),
            // Title
            Text(
                "Order Success",
                style: AppWidget.UseNameTextStyle()
            ),
            const SizedBox(height: AppWidget.spaceBtwItems),
            // Subtitle
            Text(
                '',
                textAlign: TextAlign.center,
                style: AppWidget.subTextFieldStyle()
            ),
            const SizedBox(height: AppWidget.defaultSpace),
            // Buttons
            CustomElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to home
              }, text: 'Back to Home',


            ),
          ],
        ),
      );
    },
  );
}
