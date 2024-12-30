import 'package:flutter/material.dart';
import '../Widget/AppBar.dart';
import '../Widget/AppWidget.dart';
import '../Widget/GridView.dart';
import '../Widget/ProductVertical.dart';

class Allproduct extends StatelessWidget {
  const Allproduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'All Food Product',
          style: AppWidget.AppBarTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppWidget.defaultSpace),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppWidget.primaryColor, width: 2),
                ),
                prefixIcon: const Icon(Icons.sort),
              ),
              items: ['Name', 'Higher Price', 'Lower Price']
                  .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: AppWidget.spaceBtwSections,),
            GridLayoutView(itemCount: 20, itemBuilder: (_,index)=>const ProductCardVertical())
          ],
        ),
      ),
    );
  }
}
