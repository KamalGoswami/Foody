import 'package:flutter/material.dart';

import 'AppWidget.dart';


class GridLayoutView extends StatelessWidget {
  const  GridLayoutView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 290,
  });

  final int itemCount;
  final double mainAxisExtent;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: AppWidget.gridviewSpacing,
        crossAxisSpacing: AppWidget.gridviewSpacing,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
