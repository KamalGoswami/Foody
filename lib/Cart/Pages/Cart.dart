import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CustomElevatedButton.dart';
import '../Widget/FcartItem.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: false,
        title: Text(
          'My Cart',
          style: AppWidget.AppBarTextStyle(),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(AppWidget.defaultSpace),
          child: Fcartitems(
            showAddRemoveButton: true,
          )),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: AppWidget.defaultSpace,
            right: AppWidget.defaultSpace,
            left: AppWidget.defaultSpace,
          ),
          child: CustomElevatedButton(
              onPressed: () {
                //Navigator.push(context,
                  //  MaterialPageRoute(builder: (context) => const Checkout()));
              },
              text: 'Checkout \$250.0')),
    );
  }
}
