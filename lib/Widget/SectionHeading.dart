import 'package:flutter/material.dart';
import 'AppWidget.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonTitle = 'View all',
    required this.title,
    this.showActionButton = true,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 0,top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: AppWidget.AddToCartText2(),maxLines: 1,overflow: TextOverflow.ellipsis,),
          if(showActionButton)TextButton(onPressed: onPressed, child: Text(buttonTitle,style: AppWidget.subTextFieldStyle()))
        ],
      ),
    );
  }
}
