import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foode/Services/Database.dart';
import 'package:foode/Widget/AppWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Widget/CustomElevatedButton.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final supabase = Supabase.instance.client;

  final List<String> itemsCategory = [
    'Pizza',
    'Noodles',
    'Burgers',
    'Drinks',
    'Dessert',
    'Rice',
    'Chicken',
    'Paratha',
    'Rolls',
    'Momos',
    'Thali'
  ];
  String? value;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future<void> uploadFood() async {
    if (selectedImage != null && nameController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {
        String fileName = "ProductImage/${randomAlphaNumeric(10)}.jpg";
        final bytes = await File(selectedImage!.path).readAsBytes();

        await supabase.storage.from('foody').uploadBinary(fileName, bytes);

        final imageUrl = supabase.storage.from('foody').getPublicUrl(fileName);

        Map<String, dynamic> addItem = {
          "name": nameController.text,
          "image": imageUrl,
          "price": double.parse(priceController.text),
          "discount": double.tryParse(discountController.text) ?? 0.0,
          "details": detailsController.text,
          "brand": brandController.text,
          "category": value,
        };

        await supabase.from('post').insert(addItem);

        await DatabaseMethods().addProduct(addItem, value!).then((value) {
        });

        setState(() {
          selectedImage = null;
          nameController.clear();
          discountController.clear();
          brandController.clear();
          priceController.clear();
          detailsController.clear();
          value = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Product uploaded successfully"),
        ));
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error uploading product: $e"),
        ));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please fill in all fields and select an image."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppWidget.spaceBtwItems + 6,
                ),
                Center(
                    child: Text(
                  'Add Food ',
                  style: AppWidget.AppBarTextStyle(),
                )),
                const SizedBox(
                  height: AppWidget.spaceBtwItems,
                ),
                Text(
                  'Upload the Food Picture',
                  style: AppWidget.subBoldFieldStyle(),
                ),
                const SizedBox(height: AppWidget.spaceBtwItemsSm + 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          selectedImage = image;
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: selectedImage == null
                            ? const Icon(Icons.camera_alt_outlined,
                                size: 50, color: Colors.green)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(File(selectedImage!.path),
                                    fit: BoxFit.cover),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Item Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppWidget.defaultSpace / 2),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter food name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: AppWidget.spaceBtwItems),
                Text(
                  'Seller Name',
                  style: AppWidget.subBoldFieldStyle(),
                ),
                const SizedBox(height: AppWidget.defaultSpace / 2),
                TextField(
                  controller: brandController,
                  decoration: InputDecoration(
                    hintText: 'Enter Seller name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: AppWidget.defaultSpace - 3),
                Text(
                  'Item Price',
                  style: AppWidget.subBoldFieldStyle(),
                ),
                const SizedBox(height: AppWidget.defaultSpace / 2),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter food price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: AppWidget.defaultSpace),
                Text(
                  'Item Details',
                  style: AppWidget.subBoldFieldStyle(),
                ),
                const SizedBox(height: AppWidget.defaultSpace / 2),
                TextField(
                  controller: detailsController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter food details',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: AppWidget.defaultSpace),
                Text(
                  'Add Food discount',
                  style: AppWidget.subBoldFieldStyle(),
                ),
                const SizedBox(height: AppWidget.defaultSpace / 2),
                TextField(
                  controller: discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter food discount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Select Category',
                  style: AppWidget.subBoldFieldStyle(),
                ),
                const SizedBox(height: AppWidget.defaultSpace / 2),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  items: itemsCategory.map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  value: value,
                  onChanged: (val) => setState(() => value = val),
                  hint: const Text('Select Category'),
                ),
                const SizedBox(height: AppWidget.defaultSpace * 1.2),
                CustomElevatedButton(
                  onPressed: uploadFood,
                  text: 'Add Food',
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Lottie.asset(
                  'assets/Animations/Loading.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
