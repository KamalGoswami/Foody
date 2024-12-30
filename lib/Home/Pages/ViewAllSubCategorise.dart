import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';
import 'CategoriesTab.dart';



class ViewAllSubcategories extends StatelessWidget {
  final int initialTabIndex;

  const ViewAllSubcategories({super.key, required this.initialTabIndex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 11, // Update this to match the number of tabs
      initialIndex: initialTabIndex, // Use the passed index
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View All Categories'),
        ),
        body: Column(
          children: [
            const TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppWidget.primaryColor,
              labelColor: AppWidget.primaryColor,
              tabs: [
                Tab(child: Text('Pizza')),
                Tab(child: Text('Noodles')),
                Tab(child: Text('Burger')),
                Tab(child: Text('Drinks')),
                Tab(child: Text('Desserts')),
                Tab(child: Text('Rice')),
                Tab(child: Text('Chicken')),
                Tab(child: Text('Paratha')),
                Tab(child: Text('Rolls')),
                Tab(child: Text('Momos')),
                Tab(child: Text('Thali')),
              ],
            ),
            Expanded(
              child: TabBarView(
                  children: [
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                    CategoriesTab(initialTabIndex: initialTabIndex),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
