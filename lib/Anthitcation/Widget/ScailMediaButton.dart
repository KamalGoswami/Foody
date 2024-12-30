import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';


class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                  width: AppWidget.iconMd,
                  height: AppWidget.iconMd,
                  image: AssetImage('Assets/Images/SocailMediaButton/google.png'))),
        )
      ],
    );
  }
}