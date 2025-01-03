import 'package:flutter/material.dart';

class AppWidget {
  // Text Styles
  static TextStyle boldTextFieldStyle() {
    return const TextStyle(
        fontSize: 24.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
  static TextStyle AllboldTextFieldStyle() {
    return const TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle AppBarTextStyle() {
    return const TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
  static TextStyle AppBarColorTextStyle() {
    return const TextStyle(
        fontSize: 22.0,
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle UseNameTextStyle() {
    return const TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle headlineTextFieldStyle() {
    return const TextStyle(
        fontSize: 32.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle subTextFieldStyle() {
    return const TextStyle(
        fontSize: 12.0,
        color: Colors.black54,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins');
  }

  static TextStyle smallTextFieldStyle() {
    return const TextStyle(
        fontSize: 10.0,
        color: Colors.black45,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle subBoldFieldStyle() {
    return const TextStyle(
        fontSize: 16.0,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle LinkBoldFieldStyle() {
    return const TextStyle(
        fontSize: 16.0,
        color: primaryColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle AddToCartText() {
    return const TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }
  static TextStyle AddToCartText2() {
    return const TextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle subBoldTextFieldStyle() {
    return const TextStyle(
        fontSize: 14.0,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  // Shadows
  static final productShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static const EdgeInsetsGeometry PaddingWithAppBarHeight = EdgeInsets.only(
    top: appBarHeight,
    left: defaultSpace,
    right: defaultSpace,
    bottom: defaultSpace,
  );

  //appbar height
  static const double appBarHeight = 56.0;

  // Default Spacing
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwItemsSm = 7.0;
  static const double spaceBtwItemsMd = 12.0;
  static const double spaceBtwSections = 32.0;

  // Border Radius
  static const double borderRadiusSm = 5.0;
  static const double borderRadiusMd = 10.0;
  static const double borderRadiusLg = 15.0;

  // Button Sizes
  static const double buttonHeight = 20.0;
  static const double buttonElevation = 4.0;
  static const double defaultElevation = 1.0;
  static const double buttonRadius = 20.0;
  static const double buttonWidth = 120.0;

  // Input Field
  static const double inputFieldRadius = 12.0;
  static const double spaceBtwInputFields = 16.0;

  // Padding and Margin
  static const double xs = 5.0;
  static const double sm = 10.0;
  static const double md = 18.0;
  static const double lg = 25.0;
  static const double xl = 32.0;

  // Icon Sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // Product Item Dimensions
  static const double productImageSize = 120.0;
  static const double productImageRadius = 16.0;

  // Card Sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;

  //grid view spacing
  static const double gridviewSpacing = 12.0;

  // Colors
  // Primary and Secondary Colors
  static const Color primaryColor2 = Color(0xFF4B68FF);
  static const Color primaryColor = Color(0xFF63D041);
  static const Color secondaryColor = Color(0xFFFFE248);
  static const Color accentColor = Color(0xFFB6C7FF);

  // Text Colors
  static const Color textPrimaryColor = Color(0xFF333333);
  static const Color textSecondaryColor = Color(0xFF6C7570);
  static const Color textInverseColor = Colors.white;

  // Background Colors
  static const Color lightColor = Color(0xFFF6F6F6);
  static const Color darkColor = Color(0xFF272727);
  static const Color primaryBackgroundColor = Color(0xFFF3F5FF);

  // Container Background Colors
  static const Color lightContainerColor = Color(0xFFF6F6F6);
  static const Color darkContainerColor = Colors.white10;

  // Button Colors
  static const Color buttonPrimaryColor = Color(0xFF63D041);
  static const Color buttonSecondaryColor = Color(0xFF6C7570);
  static const Color buttonDisabledColor = Color(0xFFC4C4C4);

  // Border Colors
  static const Color borderPrimaryColor = Color(0xFF090909);
  static const Color borderSecondaryColor = Color(0xFFE6E6E6);

  // Validation and State Colors
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57000);
  static const Color infoColor = Color(0xFF1976D2);

  // Neutral Shades
  static const Color blackColor = Color(0xFF232323);
  static const Color darkerGreyColor = Color(0xFF4F4F4F);
  static const Color darkGreyColor = Color(0xFF939393);
}
