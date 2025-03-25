import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Widget/AppWidget.dart';
import '../Widget/BottomNav.dart';
import '../Widget/CustomElevatedButton.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> wishlistItems = [];
  bool isLoading = true;

  Future<void> fetchWishlist() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response =
    await supabase.from('wishlist').select().eq('user_id', userId);

    setState(() {
      wishlistItems = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist', style: AppWidget.AppBarTextStyle()),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : _buildWishlist(),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: AppWidget.primaryColor),
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
            padding: const EdgeInsets.only(
                bottom: AppWidget.lg,
                left: AppWidget.xl,
                right: AppWidget.xl,
                top: AppWidget.sm),
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const BottomNav()));
              },
              text: 'Continue Shopping',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlist() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final item = wishlistItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Image.network(
              item['image'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 50),
            ),
            title: Text(item['name']),
            subtitle: Text('₹${item['price'].toString()}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final userId = supabase.auth.currentUser?.id;
                if (userId == null) return;

                await supabase
                    .from('wishlist')
                    .delete()
                    .eq('user_id', userId)
                    .eq('product_id', item['product_id']);

                setState(() {
                  wishlistItems.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Removed from Wishlist'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
