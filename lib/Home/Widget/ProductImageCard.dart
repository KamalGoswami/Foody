import 'package:flutter/material.dart';
import '../../AllScreen/Datiles.dart';
import '../../AllScreen/Favorite.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/BrandTitle.dart';
import '../../Widget/CirculerContanier.dart';
import '../../Widget/ProductPrice.dart';
import '../../Widget/ProuductTitle.dart';
import '../../Widget/RoundImag.dart';


class ImageHorizontalProduct extends StatefulWidget {
  const ImageHorizontalProduct({super.key});

  @override
  State<ImageHorizontalProduct> createState() => _ImageHorizontalProductState();
}

class _ImageHorizontalProductState extends State<ImageHorizontalProduct> {
  bool isFavorited = false;
  int currentSlide = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'For You',
                style: AppWidget.subBoldFieldStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  // Number of dots matches the itemCount
                  return CircularContainer(
                    width: index == currentSlide ? 12 : 8,
                    height: index == currentSlide ? 12 : 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    backgroundColor: index == currentSlide
                        ? AppWidget.primaryColor // Highlight active dot
                        : Colors.grey, // Inactive dot
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppWidget.spaceBtwItems*1.5),
        SizedBox(
          height: 324,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
              setState(() {
                currentSlide = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppWidget.productImageRadius,
                    ),
                    color: Colors.grey[100],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(details: '', name: '', price: '', image: '', brand: '',)));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
                              child: const FRoundImage(
                                imageUrl: 'assets/Images/ProductImages/mexican-pizza.jpg',
                                height: 240,
                                width: 550,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
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
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isFavorited
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: AppWidget.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Your Item Is Added on Cart'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: const BorderRadius.only(
                                    topLeft:
                                    Radius.circular(AppWidget.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        AppWidget.productImageRadius),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add, // Pass IconData directly
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(AppWidget.md),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductTitleText(title: 'Momos'),
                                  Row(
                                    children: [
                                      BrandTitleText(title: 'Food Villa'),
                                      SizedBox(
                                          width: AppWidget.defaultSpace / 4),
                                    ],
                                  ),
                                ],
                              ),
                              TProductPriceText(price: '80'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
