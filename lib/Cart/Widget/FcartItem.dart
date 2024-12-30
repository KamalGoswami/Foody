import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/ProductPrice.dart';
import 'CartItem.dart';


class Fcartitems extends StatelessWidget {
  const Fcartitems({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (_, __) => const SizedBox(
        height: AppWidget.spaceBtwItems,
      ),
      itemBuilder: (_, index) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TCartItem(),
          ),
          if (showAddRemoveButton)
            const SizedBox(
              height: AppWidget.spaceBtwItems,
            ),
          if (showAddRemoveButton)
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 65,
                      ),
                     // ProductQuantityCheck(),
                    ],
                  ),
                  TProductPriceText(price: '78.0'),
                ])
        ],
      ),
    );
  }
}
