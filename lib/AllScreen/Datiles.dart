import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foode/Cart/Pages/Cart.dart';
import 'package:foode/Services/Database.dart';
import 'package:foode/Services/SharedPrefancehelper.dart';
import 'package:lottie/lottie.dart';
import '../Widget/AppWidget.dart';
import '../Widget/BrandTitle.dart';
import '../Widget/ProductPrice.dart';
import '../Widget/ProuductTitle.dart';
import '../main.dart';

class DetailsScreen extends StatefulWidget {
  String image, name, details, price, brand;

  DetailsScreen({
    super.key,
    required this.details,
    required this.image,
    required this.name,
    required this.price,
    required this.brand,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1, total = 0;
  bool isExpanded = false;
  bool isFavorited = false;
  String? id;
  bool isLoading = false;

  Future<void> getSharedPreferences() async {
    id = await SharedPreferencesHelper().getUserId();
    setState(() {});
  }

  Future<void> uploadFoodOnCart() async {
    if (id == null || widget.name.isEmpty || widget.price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("User ID or Product information missing."),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Create the data to be added to the 'FCart' table
      Map<String, dynamic> addItem = {
        "name": widget.name,
        "image": widget.image,
        "price": widget.price,
        "Quantity": quantity,
        "brand":widget.brand,
        "created_at": DateTime.now().toIso8601String(),
      };

      // Insert the data into the Supabase table
      await supabase.from('FCart').insert(addItem);

      // Display success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue,
        content: const Text("Product added to cart successfully."),
        action: SnackBarAction(label: "View", onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CartScreen()));
        }),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Error adding product to cart: $e"),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    total = int.parse(widget.price);
  }

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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Center(
                    child: Hero(
                      tag: 'Hello',
                      child: CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: Lottie.asset(
                            'assets/Animations/ImageLoadAnimation.json',
                            height: 50,
                            width: 50,
                            repeat: true,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(title: widget.name),
                      const SizedBox(height: AppWidget.spaceBtwItemsSm),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BrandTitleText(title: widget.brand),
                            const VerticalDivider(
                              color: AppWidget.primaryColor,
                              thickness: 2,
                              width: 35,
                              indent: 15,
                              endIndent: 15,
                            ),
                            Text("35 mins to 45 mins",
                                style: AppWidget.subBoldTextFieldStyle()),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppWidget.defaultSpace - 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TProductPriceText(price: widget.price),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                      total -= int.parse(widget.price);
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
                                    total += int.parse(widget.price);
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
                      const Divider(thickness: 1),
                      const SizedBox(height: AppWidget.defaultSpace - 2),
                      const Text(
                        "About Food",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: AppWidget.defaultSpace),
                      Text(widget.details),
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
                  Text("Total Price", style: AppWidget.subBoldTextFieldStyle()),
                  Text(
                    "₹${(quantity * int.parse(widget.price)).toStringAsFixed(2)}",
                    style: AppWidget.AppBarTextStyle(),
                  ),
                ],
              ),
              GestureDetector(
                onTap: uploadFoodOnCart,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppWidget.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add to Cart", style: AppWidget.AddToCartText()),
                      const SizedBox(width: 4),
                      const Icon(Icons.shopping_cart_outlined, color: Colors.white),
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
