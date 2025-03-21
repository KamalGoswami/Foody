import 'package:flutter/material.dart';
import 'package:foode/Admin/AddFoodonForYou.dart';
import 'package:foode/Admin/BannerAdd.dart';
import '../Widget/AppWidget.dart';
import 'Addfood.dart';

class Homeadmin extends StatefulWidget {
  const Homeadmin({super.key});

  @override
  State<Homeadmin> createState() => _HomeadminState();
}

class _HomeadminState extends State<Homeadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
      child: Column(
        children: [
          Center(
            child: Text(
              'Home Admin',
              style: AppWidget.AppBarTextStyle(),
            ),
          ),
          const SizedBox(
            height: AppWidget.defaultSpace,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddFoodOnForYou()));
                    },
                    child: Material(
                      elevation: AppWidget.defaultElevation,
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppWidget.primaryColor,
                            borderRadius:
                                BorderRadius.circular(AppWidget.spaceBtwItems),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.all(AppWidget.spaceBtwItemsSm),
                                  child: Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                width: AppWidget.defaultSpace/5,
                              ),
                              Text(
                                'Add Food Items on Popular',
                                style: AppWidget.AllboldTextFieldStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppWidget.spaceBtwSections * 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddFood()));
                    },
                    child: Material(
                      elevation: AppWidget.defaultElevation,
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppWidget.primaryColor,
                            borderRadius:
                                BorderRadius.circular(AppWidget.spaceBtwItems),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.all(AppWidget.spaceBtwItemsSm),
                                  child: Icon(
                                    Icons.shopping_basket_outlined,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                width: AppWidget.defaultSpace/5,
                              ),
                              Text(
                                'Add Food Items on Special',
                                style: AppWidget.AllboldTextFieldStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),const SizedBox(height: AppWidget.spaceBtwSections * 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Banneradd()));
                    },
                    child: Material(
                      elevation: AppWidget.defaultElevation,
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppWidget.primaryColor,
                            borderRadius:
                                BorderRadius.circular(AppWidget.spaceBtwItems),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.all(AppWidget.spaceBtwItemsSm),
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                width: AppWidget.defaultSpace/5,
                              ),
                              Text(
                                'Add Food Banner',
                                style: AppWidget.AllboldTextFieldStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
