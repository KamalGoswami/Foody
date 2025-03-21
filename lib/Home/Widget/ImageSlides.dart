import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CirculerContanier.dart';
import '../../Widget/RoundImag.dart';
import '../../main.dart';


class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required List<String> imageUrls, required Duration autoPlayDuration});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imageUrls = [];
  int currentSlide = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    final response = await supabase.from('Banner').select('banner');
    setState(() {
      imageUrls = response.map<String>((item) => item['banner'].toString()).toList();
      isLoading = false;
    });
    }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(AppWidget.defaultSpace),
      child: Column(
        children: [
          if (imageUrls.isEmpty)
            const Text("No banners available")
          else
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentSlide = index;
                  });
                },
              ),
              items: imageUrls.map((url) => FRoundImage(imageUrl: url)).toList(),
            ),
          const SizedBox(height: AppWidget.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imageUrls.length, (index) {
              return CircularContainer(
                width: 20,
                height: 4,
                margin: const EdgeInsets.only(right: 10),
                backgroundColor: index == currentSlide
                    ? AppWidget.primaryColor
                    : Colors.grey,
              );
            }),
          ),
        ],
      ),
    );
  }
}
