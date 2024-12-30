import 'package:flutter/material.dart';

import '../../Widget/AppWidget.dart';
import '../../Widget/GridView.dart';
import '../../Widget/ProductVertical.dart';
import '../../Widget/SectionHeading.dart';


class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key, required int initialTabIndex});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      // Allow scrolling by removing NeverScrollableScrollPhysics
      children: [
        Padding(
          padding: const EdgeInsets.all(AppWidget.defaultSpace),
          child: Column(
            children: [
              const SectionHeading(title: 'Veg Pizza', showActionButton: false),
              const SizedBox(height: AppWidget.spaceBtwItems),
              GridLayoutView(
                itemCount: 8,
                itemBuilder: (_, index) => const ProductCardVertical(),
              ),
              const SizedBox(height: AppWidget.spaceBtwSections),
              const SectionHeading(title: 'Paneer Pizza', showActionButton: false),
              const SizedBox(height: AppWidget.spaceBtwSections,),
              GridLayoutView(
                itemCount: 8,
                itemBuilder: (_, index) => const ProductCardVertical(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
