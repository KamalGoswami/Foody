import 'package:flutter/material.dart';

import '../../Widget/AppWidget.dart';


class HomeAppbar extends StatefulWidget {


  const HomeAppbar({super.key,});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hello",
          style: AppWidget.boldTextFieldStyle(),
        ),
      ],
    );
  }
}
