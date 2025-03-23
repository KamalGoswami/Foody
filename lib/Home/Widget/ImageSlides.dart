import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/CirculerContanier.dart';
import '../../Widget/RoundImag.dart';


class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  final Duration autoPlayDuration;

  const ImageSlider({
    super.key,
    required this.imageUrls,
    required this.autoPlayDuration,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return const Center(child: Text("No banners available"));
    }

    return Padding(
      padding: const EdgeInsets.all(AppWidget.defaultSpace),
      child: Column(
        children: [
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
            items: widget.imageUrls
                .map((url) => FRoundImage(imageUrl: url))
                .toList(),
          ),
          const SizedBox(height: AppWidget.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              return CircularContainer(
                width: 20,
                height: 7,
                margin: const EdgeInsets.only(right: 8),
                backgroundColor: index == currentSlide
                    ? AppWidget.primaryColor
                    : Colors.grey.shade400,
              );
            }),
          ),
        ],
      ),
    );
  }
}
