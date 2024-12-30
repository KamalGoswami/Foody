import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';


class LoginHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? verticalSpacing;
  final double? subtitleSpacing;

  const LoginHeader({
    Key? key,
    this.title = 'Welcome Back',
    this.subtitle = 'Log in to Continue',
    this.titleStyle,
    this.subtitleStyle,
    this.verticalSpacing,
    this.subtitleSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: verticalSpacing ?? AppWidget.spaceBtwSections * 4.5,
        ),
        Text(
          title,
          style: titleStyle ?? Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: subtitleSpacing ?? AppWidget.spaceBtwItemsSm,
        ),
        Text(
          subtitle,
          style: subtitleStyle ?? AppWidget.subTextFieldStyle(),
        ),
      ],
    );
  }
}
