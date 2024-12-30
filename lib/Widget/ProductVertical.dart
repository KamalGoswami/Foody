import 'package:flutter/material.dart';
import '../AllScreen/Datiles.dart';
import '../AllScreen/Favorite.dart';
import 'AppWidget.dart';
import 'BrandTitle.dart';
import 'ProductPrice.dart';
import 'ProuductTitle.dart';
import 'RoundImag.dart';
import 'RoundedContainer.dart';

class ProductCardVertical extends StatefulWidget {
  const ProductCardVertical({super.key});

  @override
  State<ProductCardVertical> createState() => _ProductCardVerticalState();
}

class _ProductCardVerticalState extends State<ProductCardVertical> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailsScreen()),
        );
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          // Adding elevation with BoxShadow
          borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(AppWidget.sm),
              backgroundColor: AppWidget.lightContainerColor,
              child: Stack(
                children: [
                  const FRoundImage(
                    imageUrl: 'Assets/Images/ProductImage/PizaaDeli.jpg',
                    applyImageRadius: true,
                  ),
                  Positioned(
                    top: 8,
                    child: RoundedContainer(
                      Radius: AppWidget.sm,
                      backgroundColor:
                      AppWidget.secondaryColor.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppWidget.sm,
                        vertical: AppWidget.xs,
                      ),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: AppWidget.blackColor),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (!isFavorited) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Your Item Is Added to Wishlist'),
                            action: SnackBarAction(
                              label: 'View',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FavoriteScreen(),
                                  ),
                                );
                              },
                            ),
                            duration: const Duration(seconds: 3),
                          ));
                        }
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppWidget.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(AppWidget.cardRadiusMd),
                            bottomLeft: Radius.circular(AppWidget.productImageRadius),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: AppWidget.primaryColor,
                          child: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppWidget.spaceBtwItemsSm/1.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppWidget.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTitleText(title: 'Veg Pizza'),
                  const SizedBox(
                    height: AppWidget.spaceBtwItems / 2,
                  ),
                  const BrandTitleText(title: 'KFC'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TProductPriceText(price: '200'),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Your Item Is Added on Cart'),
                            duration: Duration(seconds: 3),
                          ));
                        },
                        child: Container(
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
