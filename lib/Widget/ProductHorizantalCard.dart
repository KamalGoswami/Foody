import 'package:flutter/material.dart';
import '../AllScreen/Datiles.dart';
import '../main.dart';
import 'AppWidget.dart';
import 'BrandTitle.dart';
import 'CirculerIcon.dart';
import 'ProductPrice.dart';
import 'ProuductTitle.dart';
import 'RoundedContainer.dart';

class Productcardhorizontal extends StatelessWidget {
  final Map<String, dynamic> ds;
  const Productcardhorizontal({required this.ds, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = supabase.storage
        .from('foody')
        .getPublicUrl(ds['image'] ?? 'https://bpeqayuadpfyzempcsqj.supabase.co/storage/v1/object/public/foody/IpjrC2vkXY.jpg')
        .toString();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(details: '', image: '', price: '', name: '', brand: '',)),
        );
      },
      child: Container(
        width: 315,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AppWidget.productShadow],
          borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
          color: const Color(0xFFF4F4F4),
        ),
        child: Row(
          children: [
            RoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(AppWidget.sm),
              backgroundColor: AppWidget.lightColor,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.network(
                        imageUrl.isNotEmpty ? imageUrl : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      Radius: AppWidget.sm,
                      backgroundColor: AppWidget.secondaryColor.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppWidget.sm,
                        vertical: AppWidget.xs,
                      ),
                      child: Text(
                        '${ds['discount'] ?? 0}%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: Colors.black),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(
                      icon: Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 172,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppWidget.sm,
                      left: AppWidget.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(
                          title: ds['name'] ?? 'Unknown Product',
                          smallSize: true,
                        ),
                        const SizedBox(
                          height: AppWidget.spaceBtwItems / 2,
                        ),
                        BrandTitleText(
                          title: ds['brand'] ?? 'Unknown Brand',
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TProductPriceText(
                          price: ds['price']?.toString() ?? '0.0',
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppWidget.darkColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppWidget.cardRadiusMd),
                            bottomRight: Radius.circular(AppWidget.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: AppWidget.iconLg * 1.2,
                          height: AppWidget.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
