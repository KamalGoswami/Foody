import 'package:flutter/material.dart';

class HomeCategories extends StatelessWidget {
  final String name;
  final String image;
  final Color bgColor;

  HomeCategories({
    required this.name,
    required this.image,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This future is not available right now")),
        );

      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Column(
          children: [
            Material(
              elevation: 4,
              shape: const CircleBorder(),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: bgColor,
                child: Image.asset(
                  image,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
