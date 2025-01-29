import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import '../main.dart';

class Banneradd extends StatefulWidget {
  const Banneradd({super.key});

  @override
  State<Banneradd> createState() => _BanneraddState();
}

class _BanneraddState extends State<Banneradd> {
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future<void> uploadBanner() async {
    if (selectedImage != null) {
      setState(() {
        isLoading = true;
      });

      try {
        // Generate a unique file name
        String fileName = "ProductImage/${randomAlphaNumeric(10)}.jpg";

        // Read image file as bytes
        final bytes = await File(selectedImage!.path).readAsBytes();

        // Upload image to Supabase storage
        await supabase.storage.from('foody').uploadBinary(fileName, bytes);

        // Retrieve public URL of the uploaded image
        final imageUrl = supabase.storage.from('foody').getPublicUrl(fileName);

        // Prepare data for database insertion
        Map<String, dynamic> addBanner = {
          "image": imageUrl,
        };

        // Insert the banner data into Supabase table
        await supabase.from('Banner').insert(addBanner);

        setState(() {
          selectedImage = null; // Reset the selected image
        });

        // Success message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Banner uploaded successfully!"),
        ));
      } catch (e) {
        // Error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error uploading banner: $e"),
        ));
      } finally {
        setState(() {
          isLoading = false; // Ensure loading state is reset
        });
      }
    } else {
      // No image selected error
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please select an image to upload."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Banner"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Upload the Food Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  selectedImage = image;
                });
              },
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: selectedImage == null
                    ? const Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 50,
                    color: Colors.green,
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(selectedImage!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : uploadBanner,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
                  : const Text(
                "Upload Banner",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
