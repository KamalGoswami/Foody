import 'package:flutter/material.dart';

import '../AllScreen/Datiles.dart';
import '../AllScreen/Favorite.dart';
import 'AppWidget.dart';
import 'BrandTitle.dart';
import 'ProductPrice.dart';
import 'ProuductTitle.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsScreen(details: '', image: '', name: '', price: '', brand: '',)));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Discount Badge
            Stack(
              children: [
                /// Product Image
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
                    child: Image.asset(
                      'assets/Images/ProductImages/butter-chicken.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ///Discount Badge
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '14%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppWidget.spaceBtwItemsMd),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Favorite Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ProductTitleText(
                          title: 'Burger',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!isFavorited) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  const Text('Your Item Is Added to Wishlist'),
                              action: SnackBarAction(
                                label: 'View',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FavoriteScreen(),
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
                          height: 38,
                          width: 38,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorited ? Colors.red : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Brand with Verified Icon
                  const BrandTitleText(
                    title: 'Burger King',
                  ),
                  const SizedBox(height: AppWidget.spaceBtwItems / 2),
                  // Price and Add to Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TProductPriceText(price: '50'),
                      GestureDetector(
                        onTap: () {
                          {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Your Item Is Added to on Cart'),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppWidget.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(AppWidget.productImageRadius),
                            ),
                          ),
                          child: const Icon(
                            Icons.add, // Pass IconData directly
                            color: Colors.white,
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
