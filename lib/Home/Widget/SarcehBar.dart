import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';
import '../Pages/Search.dart';



class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: AppWidget.primaryColor,
              size: 30,
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 4,
              child: TextField(
                readOnly: true, // Makes the TextField non-editable
                decoration: const InputDecoration(
                  hintText: "Search....",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  // Navigate to SearchPage when the TextField is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
              ),
            ),
            Container(
              height: 25,
              width: 1.5,
              color: AppWidget.primaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.tune,
                color: AppWidget.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
