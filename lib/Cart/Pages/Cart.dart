import 'package:flutter/material.dart';
import 'package:foode/Cart/Widget/EmptyCart.dart';
import 'package:foode/Widget/CustomElevatedButton.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Widget/AppBar.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/BrandTitle.dart';
import '../../Widget/ProductPrice.dart';
import '../../Widget/ProuductTitle.dart';
import '../../Widget/RoundImag.dart';
import '../Widget/ProductQuantityCheck.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<dynamic> cartItems = [];
  bool isLoading = true;

  late Stream<List<Map<String, dynamic>>> fooditemStream;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      fooditemStream = supabase
          .from('FCart')
          .stream(primaryKey: ['id'])
          .map((data) => data.map((e) => e as Map<String, dynamic>).toList());

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _removeItemFromCart(int itemId) async {
    try {
      await supabase.from('FCart').delete().eq('id', itemId);
      setState(() {
        cartItems.removeWhere((item) => item['id'] == itemId);
      });
    } catch (e) {
      debugPrint('Error removing item from cart: $e');
    }
  }

  double _calculateTotalPrice() {
    return cartItems.fold<double>(
      0.0,
          (sum, item) => sum + ((item['price'] ?? 0.0) * (item['quantity'] ?? 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: false,
        title: Text(
          'My Cart',
          style: AppWidget.AppBarTextStyle(),
        ),
      ),
      body: isLoading
          ? Center(
        child: Lottie.asset(
          'assets/Animations/Loading.json',
          width: 250,
          height: 250,
        ),
      )
          : StreamBuilder<List<Map<String, dynamic>>>(
        stream: fooditemStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/Animations/Loading.json',
                width: 250,
                height: 250,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: EmptyCartScreen());
          }

          cartItems = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(AppWidget.spaceBtwItemsMd),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: cartItems.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: AppWidget.spaceBtwItems),
              itemBuilder: (_, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FRoundImage(
                        imageUrl: item['image_url'] ??
                            'assets/Images/Categories/thali.png',
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(AppWidget.sm),
                        backgroundColor:
                        AppWidget.primaryColor.withOpacity(0.2),
                      ),
                      const SizedBox(width: AppWidget.spaceBtwItems),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BrandTitleText(
                                title: item['brand'] ?? 'Unknown'),
                            ProductTitleText(
                              title: item['name'] ?? 'Unnamed Product',
                              maxLines: 1,
                            ),
                            const SizedBox(height: AppWidget.spaceBtwItems),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                ProductQuantityCheck(
                                  initialQuantity: item['quantity'] ?? 1,
                                  onQuantityChanged: (newQuantity) {
                                    setState(() {
                                      item['quantity'] = newQuantity;
                                    });
                                    supabase
                                        .from('FCart')
                                        .update({'quantity': newQuantity})
                                        .eq('id', item['id']);
                                  },
                                  onRemoveItem: () {
                                    _removeItemFromCart(item['id']);
                                  },
                                ),
                                TProductPriceText(
                                    price: '${item['price'] ?? '0.0'}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.all(AppWidget.defaultSpace),
        child: CustomElevatedButton(
          onPressed: () {
            // Handle checkout logic
          },
          text: 'Checkout ₹${_calculateTotalPrice().toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
