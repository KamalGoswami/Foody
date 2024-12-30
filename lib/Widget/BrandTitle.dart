import 'package:flutter/material.dart';
import 'AppWidget.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText({
    super.key,
    Color? color, required this.title,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          width: AppWidget.xs,
        ),
        const Icon(
          Icons.verified_rounded,
          color: AppWidget.primaryColor,
          size: AppWidget.iconSm,
        ),
      ],
    );
  }
}
