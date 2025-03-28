import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foode/Widget/AppWidget.dart';
import 'package:foode/Widget/SectionHeading.dart';
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
  List<String> banners = []; // Store banner URLs
  final PageController _pageController = PageController();
  int currentIndex = 0; // For dot indicator

  @override
  void initState() {
    super.initState();
    fetchBanners(); // Load banners when screen loads
  }

  Future<void> fetchBanners() async {
    final response = await supabase.from('Banner').select('banner');

    if (response.isNotEmpty) {
      setState(() {
        banners = response.map<String>((e) => e['banner'] as String).toList();
      });
    }
  }

  Future<void> uploadBanner() async {
    if (selectedImage != null) {
      setState(() {
        isLoading = true;
      });

      try {
        String fileName = "ProductImage/${randomAlphaNumeric(10)}.jpg";
        final bytes = await File(selectedImage!.path).readAsBytes();
        await supabase.storage.from('foody').uploadBinary(fileName, bytes);
        final imageUrl = supabase.storage.from('foody').getPublicUrl(fileName);

        Map<String, dynamic> addBanner = {"banner": imageUrl};
        await supabase.from('Banner').insert(addBanner);

        setState(() {
          selectedImage = null;
        });

        fetchBanners();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Banner uploaded successfully!"),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error uploading banner: $e"),
        ));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please select an image to upload."),
      ));
    }
  }

  Future<void> deleteBanner(String imageUrl) async {
    try {
      Uri uri = Uri.parse(imageUrl);
      String fileName = uri.pathSegments.last;
      await supabase.storage.from('foody').remove(["ProductImage/$fileName"]);
      await supabase.from('Banner').delete().match({'banner': imageUrl});

      fetchBanners();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Banner deleted successfully!"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Error deleting banner: $e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Banner"),
        centerTitle: true,
        backgroundColor: AppWidget.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Upload the Food Picture',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  border: Border.all(color: AppWidget.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: selectedImage == null
                    ? const Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 50,
                    color: AppWidget.primaryColor,
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
                backgroundColor: AppWidget.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Upload Banner", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: AppWidget.defaultSpace),
            const SectionHeading(title: 'Your Banners', showActionButton: false),
            const SizedBox(height: AppWidget.spaceBtwItems),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: banners.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  banners[index],
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'Delete') {
                                      deleteBanner(banners[index]);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(value: 'Delete', child: Text('Delete')),
                                  ],
                                  icon: const Icon(Icons.more_vert, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppWidget.defaultSpace-4),
                  // Dot Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: index == currentIndex ? 12 : 8,
                        height: index == currentIndex ? 12 : 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == currentIndex
                              ? AppWidget.primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
