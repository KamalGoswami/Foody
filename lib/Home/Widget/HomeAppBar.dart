import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';

class HomeAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const HomeAppbar(this.title, {super.key});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppbarState extends State<HomeAppbar> {
  @override
  Widget build(BuildContext context) {

    return
      Padding(
        padding: const EdgeInsets.only(top: 45,left: 30,bottom: 5,right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
               'Foody',
              style: AppWidget.boldTextFieldStyle(),
            ),
          ],
        ),
      );
  }
}
