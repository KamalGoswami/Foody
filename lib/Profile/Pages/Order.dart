import 'package:flutter/material.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/AppWidget.dart';
import '../Widget/OrderList.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text('My Orders'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppWidget.defaultSpace),
        child: OrderList(),
      ),
    );
  }
}
