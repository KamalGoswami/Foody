import 'package:flutter/material.dart';
import '../AllScreen/Datiles.dart';
import '../AllScreen/Favorite.dart';
import '../main.dart';
import 'AppWidget.dart';
import 'BrandTitle.dart';
import 'ProductPrice.dart';
import 'ProuductTitle.dart';
import 'RoundedContainer.dart';

class ProductCardVertical extends StatefulWidget {
  final Map<String, dynamic> ds;
  const ProductCardVertical({required this.ds, super.key});

  @override
  State<ProductCardVertical> createState() => _ProductCardVerticalState();
}

class _ProductCardVerticalState extends State<ProductCardVertical> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {

    final imageUrl = widget.ds['image'] ?? '';
    final validImageUrl = supabase.storage
        .from('foody')
        .getPublicUrl(imageUrl)
        .toString();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(details: '', name: '', image: '', price: '', brand: '',)),
        );
      },
      child: Container(
        width: 205,
        padding: const EdgeInsets.all(AppWidget.spaceBtwItemsSm / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedContainer(
              padding: const EdgeInsets.all(2),
              backgroundColor: AppWidget.lightContainerColor,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppWidget.productImageRadius),
                    child: Image.network(
                      validImageUrl.isNotEmpty ? validImageUrl : '',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    child: RoundedContainer(
                      Radius: AppWidget.sm,
                      backgroundColor: AppWidget.secondaryColor.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppWidget.sm,
                        vertical: AppWidget.xs,
                      ),

                      child: Text(
                        '${widget.ds['discount'] ?? 0}%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: AppWidget.blackColor),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(isFavorited
                              ? 'Your Item Is Added to Wishlist'
                              : 'Your Item Is Removed from Wishlist'),
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
                      },
                      child: CircleAvatar(
                        backgroundColor: AppWidget.primaryColor,
                        child: Icon(
                          isFavorited
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppWidget.spaceBtwItems * 1.8),
            Padding(
              padding: const EdgeInsets.only(
                left: AppWidget.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(title: widget.ds['name'] ?? 'Unknown Product'),
                  const SizedBox(height: AppWidget.spaceBtwItems / 2),
                  BrandTitleText(title: widget.ds['brand'] ?? 'Unknown Brand'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TProductPriceText(price: widget.ds['price'] ?? '0'),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Your Item Is Added on Cart'),
                            duration: Duration(seconds: 3),
                          ));
                        },
                        child: Container(
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
                              child: Icon(Icons.add, color: Colors.white),
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
