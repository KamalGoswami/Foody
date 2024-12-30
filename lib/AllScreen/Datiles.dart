import 'package:flutter/material.dart';
import '../Widget/AppWidget.dart';
import '../Widget/BrandTitle.dart';
import '../Widget/ProductPrice.dart';
import '../Widget/ProuductTitle.dart';
import 'Favorite.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  bool isExpanded = false; // State to manage "Read More" functionality
  bool isFavorited = false; // State to track the favorite button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 390,
                  child: Padding(
                    padding: EdgeInsets.all(AppWidget.productImageRadius * 1.3),
                    child: Center(
                      child: Image(image: AssetImage('Assets/Images/ProductImage/Momos.jpg')),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProductTitleText(title: 'Pizza'),
                      const SizedBox(height: AppWidget.spaceBtwItemsSm),
                      const SizedBox(height: AppWidget.spaceBtwItems),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const BrandTitleText(title: 'KFC'),
                            const VerticalDivider(
                              color: AppWidget.primaryColor,
                              thickness: 2,
                              width: 35,
                              indent: 15,
                              endIndent: 15,
                            ),
                            Text("15 mins",
                                style: AppWidget.subBoldTextFieldStyle()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TProductPriceText(price: '50'),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppWidget.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppWidget.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "About Food",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: AppWidget.defaultSpace),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isExpanded
                                ? "Popular donburi dish consisting of Chicken and onion served over a bowl of rice. The meat and onion are cooked in a mixture of soy sauce, mirin, sugar and sake, giving the dish a unique sweet and savory flavor what is the error what is the error what is the error."
                                : "Popular donburi dish consisting of Chicken and onion served over a bowl of rice. The meat and onion are cooked in a mixture of soy sauce, mirin, sugar and sake, giving the dish a unique sweet...",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "Read Less" : "Read More",
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppWidget.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(thickness: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            top: 45,
            right: 20,
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
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // Background color for visibility
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorited ? Colors.red : AppWidget.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 105,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.share, color: AppWidget.primaryColor),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.subBoldTextFieldStyle(),
                  ),
                  Text("₹${(quantity * 50).toStringAsFixed(2)}",
                      style: AppWidget.AppBarTextStyle()),
                ],
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'SuccessFully Added',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins'),
                      )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppWidget.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Add To Cart", style: AppWidget.AddToCartText()),
                      const SizedBox(width: AppWidget.spaceBtwItems),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppWidget.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: AppWidget.spaceBtwItems),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
