import 'package:flutter/material.dart';

import 'AppWidget.dart';


class FRoundImage extends StatelessWidget {
  const FRoundImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = true,
    this.fit = BoxFit.contain,
    this.backgroundColor = Colors.white,
    this.isNetworkImage=false,
    required this.imageUrl,
    this.borderRadius=AppWidget.md,
  });

  final double? width, height;
  final String imageUrl;
  final double borderRadius;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(AppWidget.md):BorderRadius.zero,
          child: Image(fit:fit, image:isNetworkImage? NetworkImage(imageUrl):
          AssetImage(imageUrl) as ImageProvider),
        ),
      ),
    );

  }
}