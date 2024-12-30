import 'package:flutter/material.dart';
import '../../AllScreen/Datiles.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/BrandTitle.dart';
import '../../Widget/ProuductTitle.dart';
import '../../Widget/RoundImag.dart';


class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const DetailsScreen()));
      },
      child: Row(
        children: [
          FRoundImage(
            imageUrl: 'Assets/Images/ProductImage/HBergur.png',
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(AppWidget.sm),
            backgroundColor: AppWidget.primaryColor.withOpacity(0.2),
          ),
          const SizedBox(
            width: AppWidget.spaceBtwItems,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BrandTitleText(title: 'KFC'),
                Flexible(
                    child: ProductTitleText(
                      title: 'Bergur',
                      maxLines: 1,
                    )),
                Text.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: 'Size', style: AppWidget.smallTextFieldStyle()),
                    TextSpan(
                        text: 'Normal', style: AppWidget.subTextFieldStyle()),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
