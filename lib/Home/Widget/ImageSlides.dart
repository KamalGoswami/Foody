import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CirculerContanier.dart';
import '../../Widget/RoundImag.dart';


class ImageSlider extends StatefulWidget {
  final List<String> imageUrls; // List of image URLs
  final Duration autoPlayDuration; // Duration for auto-slide

  const ImageSlider({
    super.key,
    required this.imageUrls,
    this.autoPlayDuration = const Duration(seconds: 5), // Default duration
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppWidget.defaultSpace),
      child: Column(
        children: [
          // Carousel Slider
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: widget.autoPlayDuration,
              onPageChanged: (index, reason) {
                setState(() {
                  currentSlide = index;
                });
              },
            ),
            items: widget.imageUrls.map((url) {
              return FRoundImage(imageUrl: url);
            }).toList(),
          ),
          const SizedBox(height: AppWidget.spaceBtwItems),
          // Dynamic Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              return CircularContainer(
                width: 20,
                height: 4,
                margin: const EdgeInsets.only(right: 10),
                backgroundColor: index == currentSlide
                    ? AppWidget.primaryColor
                    : Colors.grey, //
              );
            }),
          ),
        ],
      ),
    );
  }
}
