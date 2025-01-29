import 'package:flutter/material.dart';
import '../../AllScreen/Datiles.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/BrandTitle.dart';
import '../../Widget/ProuductTitle.dart';
import '../../Widget/RoundImag.dart';
import '../../main.dart';


class TCartItem extends StatefulWidget {
  const TCartItem({
    super.key,
  });

  @override
  State<TCartItem> createState() => _TCartItemState();
}

late Stream<List<Map<String, dynamic>>> fooditemStream;

void OnAdd() {
  fooditemStream = supabase.from('products').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => e as Map<String, dynamic>).toList());
}

class _TCartItemState extends State<TCartItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailsScreen(details: '', image: '', name: '', price: '', brand: '',)));
      },
      child: Row(
        children: [
          FRoundImage(
            imageUrl: 'assets/Images/ProductImages/butter-chicken.jpg',
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
                const Flexible(
                    child: ProductTitleText(
                      title: 'Berger',
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
