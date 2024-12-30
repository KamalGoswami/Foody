import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';


class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"title": "Pizza", "image":  "Assets/Images/CategoriesImages/pizza.png", "bgColor": Colors.pink[100]},
      {"title": "Noodles", "image":"Assets/Images/CategoriesImages/noodles.png", "bgColor": Colors.orange[100]},
      {"title": "Burgers", "image":"Assets/Images/CategoriesImages/burger.png", "bgColor": Colors.blue[100]},
      {"title": "Drinks", "image": "Assets/Images/CategoriesImages/drink.png", "bgColor": Colors.red[100]},
      {"title": "Desserts","image":"Assets/Images/CategoriesImages/pancakes.png", "bgColor": Colors.pink[100]},
      {"title": "Rice", "image":   "Assets/Images/CategoriesImages/fried-rice.png", "bgColor": Colors.blue[100]},
      {"title": "Chicken", "image":"Assets/Images/CategoriesImages/chicken.png", "bgColor": Colors.yellow[100]},
      {"title": "Paratha", "image":"Assets/Images/CategoriesImages/roti.png", "bgColor": Colors.purple[100]},
      {"title": "Rolls", "image":  "Assets/Images/CategoriesImages/spring-roll.png", "bgColor": Colors.pink[100]},
      {"title": "Momos", "image":  "Assets/Images/CategoriesImages/momo.png", "bgColor": Colors.blue[100]},
      {"title": "Thali", "image":  "Assets/Images/CategoriesImages/thali.png", "bgColor": Colors.tealAccent[100]},
    ];

    return SizedBox(
      height: 130, // Adjust height to fit CircleAvatar, shadow, and text
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              //ViewAllSubcategories(initialTabIndex: index),
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
                      backgroundColor: category["bgColor"] as Color? ?? Colors.grey,
                      child: Image.asset(
                        category["image"] as String,
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppWidget.defaultSpace/2),
                  Text(
                    category["title"] as String,
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
        },
      ),
    );
  }
}
