
import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AllScreen/Favorite.dart';
import '../Cart/Pages/Cart.dart';
import '../Home/Pages/Home.dart';
import '../Profile/Pages/Profile.dart';
import 'AppWidget.dart';

class BottomNav extends StatefulWidget {
  final String userId;

  final String userName;
  const BottomNav({super. key, required this.userId, required this.userName});

  @override
  State<BottomNav> createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      HomeScreen(userId: widget.userId),
      const CartScreen(),
      const FavoriteScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: AppWidget.primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (int index) => setState(() => currentTabIndex = index),
        items: [
          CurvedNavigationBarItem(
            icon: const Icon(Icons.home_outlined, color: Colors.black54),
            label: "Home",
          ),
          CurvedNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black54),
            label: "Cart",
          ),
          CurvedNavigationBarItem(
            icon: const Icon(Icons.favorite_outline, color: Colors.black54),
            label: "WishList",
          ),
          CurvedNavigationBarItem(
            icon: const Icon(Icons.person_outlined, color: Colors.black54),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
