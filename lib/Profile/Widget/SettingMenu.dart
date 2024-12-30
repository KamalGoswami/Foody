import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';


class Settingmenutile extends StatelessWidget {
  const Settingmenutile(
      {super.key,
        required this.icon,
        required this.title,
        required this.subTitle,
        this.trailing,
        this.onTap});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: AppWidget.primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
