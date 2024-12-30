import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/RoundedContainer.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 7,
      separatorBuilder: (_,__)=>const SizedBox(height: AppWidget.spaceBtwItems,),
      itemBuilder:(_,index)=> RoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(AppWidget.md),
        backgroundColor: AppWidget.lightContainerColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.local_shipping_outlined),
                const SizedBox(
                  width: AppWidget.spaceBtwItems / 1,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: AppWidget.subBoldTextFieldStyle().apply(
                            color: AppWidget.primaryColor,
                            fontWeightDelta: 1),
                      ),
                      Text(
                        '07 Jun 2025',
                        style: AppWidget.subBoldFieldStyle(),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: AppWidget.iconSm,
                    ))
              ],
            ),
            const SizedBox(height: AppWidget.spaceBtwItems/3,),
            const Divider(),
            const SizedBox(height: AppWidget.spaceBtwItems/3,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.tab),
                      const SizedBox(
                        width: AppWidget.spaceBtwItems / 1,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID',
                              style: AppWidget.subBoldTextFieldStyle().apply(
                                  color: AppWidget.primaryColor,
                                  fontWeightDelta: 1),
                            ),
                            Text(
                              '45065',
                              style: AppWidget.smallTextFieldStyle(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.watch_later_outlined),
                      const SizedBox(
                        width: AppWidget.spaceBtwItems / 1,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deliverd Time',
                              style: AppWidget.subBoldTextFieldStyle().apply(
                                  color: AppWidget.primaryColor,
                                  fontWeightDelta: 1),
                            ),
                            Text(
                              '11:51 AM',
                              style: AppWidget.smallTextFieldStyle(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
