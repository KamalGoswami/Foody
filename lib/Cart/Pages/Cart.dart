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
          padding: EdgeInsets.all(AppWidget.defaultSpace),
          child:Center(child: Text('           This future is not\n    available right now Maybe\n  UpComing Update Available',style: AppWidget.AppBarColorTextStyle(),)),//Fcartitems(
            //showAddRemoveButton: true,
        // )),
      //ottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(
      //     bottom: AppWidget.defaultSpace,
      //     right: AppWidget.defaultSpace,
      //     left: AppWidget.defaultSpace,
      //   ),
      //   child: CustomElevatedButton(
      //       onPressed: () {
      //         //Navigator.push(context,
      //           //  MaterialPageRoute(builder: (context) => const Checkout()));
      //       },
      //       text: 'Checkout \$250.0')),
      )
    );
  }
}
