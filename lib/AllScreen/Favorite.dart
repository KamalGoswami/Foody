import 'package:flutter/material.dart';
import '../Widget/AppBar.dart';
import '../Widget/AppWidget.dart';
import '../Widget/BottomNav.dart';
import '../Widget/CustomElevatedButton.dart';
import '../Widget/ProductHorizantalCard.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated dynamic data source for the wishlist
    final List<Productcardhorizontal> wishlistItems = []; // Initially empty

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'WishList',
          style: AppWidget.AppBarTextStyle(),
        ),
        showBackArrow: false,
      ),
      body: wishlistItems.isEmpty
          ? _buildEmptyWishlist(context) // Show empty state
          : _buildWishlist(wishlistItems), // Show items in the wishlist
    );
  }

  // Build the empty wishlist UI
  Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 80, color: AppWidget.primaryColor),
          const SizedBox(height: 16),
          const Text(
            'Your Wishlist is Empty',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add items that you like to your wishlist.\nReview them anytime and easily move them to the Cart.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: AppWidget.lg,left: AppWidget.xl,right: AppWidget.xl,top: AppWidget.sm),
            child: CustomElevatedButton(
              onPressed: () {
                // Navigate to the shopping screen or other action
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const BottomNav(userId: '', userName: '',)));
              },
              text: 'Continue Shopping',
            ),
          ),
        ],
      ),
    );
  }

  // Build the wishlist when it has items
  Widget _buildWishlist(List<Productcardhorizontal> items) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return items[index]; // Render each ProductCardHorizontal widget
      },
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemCount: items.length,
    );
  }
}
