import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Widget/ProductVertical.dart';

class CategoriesProduct extends StatefulWidget {
  final String category; // Fixed missing "final" keyword and semicolon.

  CategoriesProduct({required this.category, Key? key}) : super(key: key);

  @override
  State<CategoriesProduct> createState() => _CategoriesProductState();
}

class _CategoriesProductState extends State<CategoriesProduct> {
  late Stream<List<Map<String, dynamic>>> categoryStream;

  @override
  void initState() {
    super.initState();
    getOnLoad(); // Properly call the method to initialize the stream.
  }

  void getOnLoad() {
    // Fetch the stream based on the "category" field using Supabase.
    categoryStream = Supabase.instance.client
        .from('products') // Replace with your actual Supabase table name.
        .stream(primaryKey: ['id']) // Replace 'id' with your primary key.
        .eq('category', widget.category) // Filter by the selected category.
        .execute();
    setState(() {});
  }

  Widget allProducts() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: categoryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        final data = snapshot.data!;

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final product = data[index];
            return ProductCardVertical(ds: product); // Pass product data to the card.
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category Products')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: allProducts(), // Removed "Expanded", not needed here.
      ),
    );
  }
}
