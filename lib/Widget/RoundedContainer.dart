import 'package:flutter/material.dart';

import 'AppWidget.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
        this.child,
        this.width,
        this.height,
        this.margin,
        this.padding,
        this.showBorder = false,
        this.Radius = AppWidget.cardRadiusLg,
        this.backgroundColor = Colors.white,
        this.borderColor = AppWidget.borderPrimaryColor});

  final double? width;
  final double? height;
  final double Radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
