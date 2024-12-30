import 'package:flutter/material.dart';
import 'package:foode/Home/Pages/Search.dart';

import '../../AllScreen/AllProduct.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/GridView.dart';
import '../../Widget/ProductList.dart';
import '../../Widget/ProductVertical.dart';
import '../../Widget/SectionHeading.dart';
import '../Widget/HomeAppBar.dart';
import '../Widget/ImageSlides.dart';
import '../Widget/ProductImageCard.dart';
import 'HomeCategories.dart';


class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({Key? key, required this.userId,}):
        super(key:key,);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin  {

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppWidget.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: AppWidget.spaceBtwSections),

              // Include HomeAppbar here
              HomeAppbar(),
              const SizedBox(height: AppWidget.defaultSpace),

              // Search bar
              const SearchSuggestionApp(),
              const SizedBox(height: AppWidget.spaceBtwItems),

              // Categories Section
              SectionHeading(
                title: "Our Categories",
                showActionButton: true,
                onPressed: () {
                  //Navigator.push(
                    //context,
                   // MaterialPageRoute(builder: (context) =>// ViewAllCategories()),
                  //);
                },
              ),
              const SizedBox(height: AppWidget.spaceBtwItems),
              const HomeCategories(),

              // Image Slider
              const ImageSlider(
                imageUrls: [
                  'Assets/Images/SliderImage/slider6.png',
                  'Assets/Images/SliderImage/slider7.png',
                  'Assets/Images/SliderImage/slider4.png',
                ],
                autoPlayDuration: Duration(seconds: 8),
              ),

              // For you
              const ImageHorizontalProduct(),
              const SizedBox(height: AppWidget.spaceBtwSections),
              const SectionHeading(
                title: "Today's Special",
                showActionButton: false,
              ),
              const SizedBox(height: AppWidget.defaultSpace / 1.2),
              const ProductList(),
              const SizedBox(height: AppWidget.spaceBtwItems),

              // Popular Products Section
              SectionHeading(
                title: "Popular Products",
                showActionButton: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Allproduct()),
                  );
                },
              ),
              const SizedBox(height: AppWidget.spaceBtwItems),
              GridLayoutView(
                itemCount: 20,
                itemBuilder: (_, index) => const ProductCardVertical(),
              ),
              const SizedBox(height: AppWidget.defaultSpace / 1.1),
            ],
          ),
        ),
      ),
    );
  }
}
