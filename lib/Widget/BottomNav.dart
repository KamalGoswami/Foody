import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foode/AllScreen/Favorite.dart';
import 'package:foode/Cart/Pages/Cart.dart';
import '../Home/Pages/home.dart';
import '../Profile/Pages/Profile.dart';
import 'AppWidget.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;
  bool isSidebarVisible = true;

  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homepage;
  late CartScreen cart;
  late FavoriteScreen favorite;
  late ProfileScreen profile;

  @override
  void initState() {
    homepage = const HomeScreen();
    cart = const CartScreen();
    favorite = const FavoriteScreen();
    profile = const ProfileScreen();
    pages = [homepage, cart, favorite, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isMobile = size.width <= 900;

    return Scaffold(
      body: isDesktop
          ? Row(
        children: [
          /// Toggleable Sidebar for Desktop
          if (isSidebarVisible)
            NavigationSidebar(
              currentIndex: currentTabIndex,
              onTabSelected: (index) {
                setState(() {
                  currentTabIndex = index;
                });
              },
              onCloseSidebar: () {
                setState(() {
                  isSidebarVisible = false;
                });
              },
            ),
          // Main Content Area
          Expanded(
            child: Stack(
              children: [
                pages[currentTabIndex],
                if (!isSidebarVisible)
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.menu, size: 30),
                      onPressed: () {
                        setState(() {
                          isSidebarVisible = true;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      )
          : pages[currentTabIndex],
      bottomNavigationBar: isMobile
          ? CurvedNavigationBar(
        height: 65,
        backgroundColor: AppWidget.primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          CurvedNavigationBarItem(
            icon: const Icon(Icons.home_outlined, color: Colors.black54),
            label: "Home",
          ),
          CurvedNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined,
                color: Colors.black54),
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
      )
          : null,
    );
  }
}

class NavigationSidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final VoidCallback onCloseSidebar;

  const NavigationSidebar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onCloseSidebar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: AppWidget.primaryColor,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Foody',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: onCloseSidebar,
              ),
            ],
          ),
          const Divider(color: Colors.white70, thickness: 1),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NavBarItem(
                  icon: Icons.home_outlined,
                  label: "Home",
                  isSelected: currentIndex == 0,
                  onTap: () => onTabSelected(0),
                ),
                NavBarItem(
                  icon: Icons.shopping_cart_outlined,
                  label: "Cart",
                  isSelected: currentIndex == 1,
                  onTap: () => onTabSelected(1),
                ),
                NavBarItem(
                  icon: Icons.favorite_outline,
                  label: "WishList",
                  isSelected: currentIndex == 2,
                  onTap: () => onTabSelected(2),
                ),
                NavBarItem(
                  icon: Icons.person_2_outlined,
                  label: "Profile",
                  isSelected: currentIndex == 3,
                  onTap: () => onTabSelected(3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.black54),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
