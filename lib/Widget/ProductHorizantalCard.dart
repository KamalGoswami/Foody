import 'package:flutter/material.dart';
import '../AllScreen/Datiles.dart';
import 'AppWidget.dart';
import 'BrandTitle.dart';
import 'CirculerIcon.dart';
import 'ProductPrice.dart';
import 'ProuductTitle.dart';
import 'RoundImag.dart';
import 'RoundedContainer.dart';


class Productcardhorizontal extends StatelessWidget {
  const Productcardhorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  const DetailsScreen()));
      },
      child: Container(
        width: 315,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AppWidget.productShadow],
          borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
          color: const Color(0xFFF4F4F4),),
        child: Row(
          children: [
            RoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(AppWidget.sm),
              backgroundColor: AppWidget.lightColor,
              child: Stack(
                children: [
                  const SizedBox(
                    height: 120,
                    width: 120,
                    child: FRoundImage(
                      imageUrl: 'Assets/Images/ProductImage/PizaaDeli.jpg',
                      applyImageRadius: true,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      Radius: AppWidget.sm,
                      backgroundColor:
                      AppWidget.secondaryColor.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppWidget.sm, vertical: AppWidget.xs),
                      child: Text(
                        '65%',
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
                      ))
                ],
              ),
            ),
            SizedBox(
              width: 172,
              child: Column(
                children: [
                  const Padding(
                    padding:
                    EdgeInsets.only(top: AppWidget.sm, left: AppWidget.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(
                          title: 'Paratha',
                          smallSize: true,
                        ),
                        SizedBox(
                          height: AppWidget.spaceBtwItems / 2,
                        ),
                        BrandTitleText(title: 'Bergur King'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(child: TProductPriceText(price: '78.0')),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppWidget.darkColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppWidget.cardRadiusMd),
                            bottomRight:
                            Radius.circular(AppWidget.productImageRadius),
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
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
