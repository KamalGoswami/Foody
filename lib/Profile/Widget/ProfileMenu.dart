import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key, this.icon= Icons.arrow_forward_ios, required this.onPressed, required this.title, required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: AppWidget.spaceBtwItems / 1.1),
      child: Row(
        children: [
          Expanded(flex: 3,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(flex: 5,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
