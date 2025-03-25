import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foode/Services/SharedPrefancehelper.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../AllScreen/Datiles.dart';
import '../../AllScreen/Favorite.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/BrandTitle.dart';
import '../../Widget/ProductPrice.dart';
import '../../Widget/ProuductTitle.dart';
import '../../Widget/RoundedContainer.dart';
import '../../Widget/SectionHeading.dart';
import '../Widget/ImageSlides.dart';
import '../Widget/SarcehBar.dart';
import 'HomeCategories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  String? name;
  bool isLoading = true;
  bool isFavorited = false;
  int currentSlide = 0;

  @override
  bool get wantKeepAlive => true;

  final SupabaseClient supabase = Supabase.instance.client;

  late Stream<List<Map<String, dynamic>>> fooditemStream;

  late Stream<List<Map<String, dynamic>>> fooditemListStream;

  late Stream<List<Map<String, dynamic>>> bannerStream;

  Future<void> getSharedPrefs() async {
    name = await SharedPreferencesHelper().getUserName() ?? 'User Name';
    setState(() {
      isLoading = false;
    });
  }

  void onTheLoad() {
    fooditemStream = supabase.from('products').stream(primaryKey: ['id']).map(
        (data) => data.map((e) => e as Map<String, dynamic>).toList());
  }

  void onTheLoadList() {
    fooditemListStream = supabase.from('post').stream(primaryKey: ['id']).map(
        (data) => data.map((e) => e as Map<String, dynamic>).toList());
  }

  void bannerload() {
    bannerStream = supabase.from('Banner').stream(primaryKey: ['id']).map(
            (data) => data.map((e) => e as Map<String, dynamic>).toList());
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    onTheLoad();
    onTheLoadList();
    bannerload();
  }

  Widget allItems() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fooditemStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        final products = snapshot.data!;

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: supabase
                  .from('wishlist')
                  .select()
                  .eq('product_id', product['id']),
              builder: (context, snapshot) {
                bool isFavorited = snapshot.hasData && snapshot.data!.isNotEmpty;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product['image'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Lottie.asset(
                        'assets/Animations/ImageLoadAnimation.json',
                        height: 30,
                        width: 30,
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                    title: Text(product['name'] ?? 'Unknown'),
                    subtitle: Text('₹${product['price']?.toString() ?? '0'}'),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorited ? Colors.red : Colors.grey,
                      ),
                      onPressed: () async {
                        final userId = supabase.auth.currentUser?.id;
                        if (userId == null) return;

                        if (isFavorited) {
                          await supabase
                              .from('wishlist')
                              .delete()
                              .eq('user_id', userId)
                              .eq('product_id', product['id']);
                        } else {
                          await supabase.from('wishlist').insert({
                            'user_id': userId,
                            'product_id': product['id'],
                            'name': product["name"],
                            'image': product["image"],
                            'price': product['price'],
                            'brand': product["brand"]
                          });
                        }
                        setState(() {}); // Refresh UI
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }


  Widget allItemsListView() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fooditemListStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Foods found.'));
        }

        final post = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: post.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final posts = post[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            details: posts["details"],
                            image: posts["image"],
                            name: posts["name"],
                            price: posts['price']?.toString() ?? '0.0',
                            brand: posts["brand"],
                          )),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                padding: const EdgeInsets.all(AppWidget.spaceBtwItems),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: posts['image'] ?? '',
                            height: 130,
                            // Corrected height
                            width: 130,
                            // Corrected width
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Center(
                                child: Lottie.asset(
                                  'assets/Animations/ImageLoadAnimation.json',
                                  height: 50,
                                  width: 50,
                                  repeat: true,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: AppWidget.spaceBtwItems,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductTitleText(
                              title: posts['name'] ?? 'Unknown Product',
                            ),
                            const SizedBox(
                              height: AppWidget.spaceBtwItems,
                            ),
                            BrandTitleText(
                              title: posts['brand'] ?? 'Unknown Brand',
                            ),
                            const SizedBox(
                              height: AppWidget.spaceBtwItems,
                            ),
                            TProductPriceText(
                              price: posts['price']?.toString() ?? '0',
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Positioning the favorite button
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorited = !isFavorited;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(isFavorited
                                ? 'Your Item Is Added to Wishlist'
                                : 'Your Item Is Removed from Wishlist'),
                            action: SnackBarAction(
                              label: 'View',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FavoriteScreen(),
                                  ),
                                );
                              },
                            ),
                            duration: const Duration(seconds: 3),
                          ));
                        },
                        child: CircleAvatar(
                          backgroundColor: AppWidget.primaryColor,
                          child: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Positioning the cart button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Your Item Is Added to Cart'),
                            duration: Duration(seconds: 3),
                          ));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppWidget.darkColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppWidget.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(AppWidget.productImageRadius),
                            ),
                          ),
                          child: const SizedBox(
                            width: AppWidget.iconLg * 1.2,
                            height: AppWidget.iconLg * 1.2,
                            child: Center(
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -1,
                      left: -1,
                      child: RoundedContainer(
                        backgroundColor:
                            AppWidget.secondaryColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppWidget.sm,
                          vertical: AppWidget.xs,
                        ),
                        child: Text(
                          '${posts['discount']}%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: AppWidget.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<Map<String, dynamic>> categories = [
      {
        "title": "Pizza",
        "image": "assets/Images/Categories/pizza.png",
        "bgColor": Colors.pink[100],
      },
      {
        "title": "Noodles",
        "image": "assets/Images/Categories/noodles.png",
        "bgColor": Colors.orange[100],
      },
      {
        "title": "Burgers",
        "image": "assets/Images/Categories/burger.png",
        "bgColor": Colors.blue[100],
      },
      {
        "title": "Drinks",
        "image": "assets/Images/Categories/drink.png",
        "bgColor": Colors.red[100],
      },
      {
        "title": "Desserts",
        "image": "assets/Images/Categories/pancakes.png",
        "bgColor": Colors.purple[100],
      },
      {
        "title": "Rice",
        "image": "assets/Images/Categories/rice.png",
        "bgColor": Colors.blue[100]
      },
      {
        "title": "Chicken",
        "image": "assets/Images/Categories/chicken-leg.png",
        "bgColor": Colors.yellow[100]
      },
      {
        "title": "Paratha",
        "image": "assets/Images/Categories/roti.png",
        "bgColor": Colors.purple[100]
      },
      {
        "title": "Rolls",
        "image": "assets/Images/Categories/spring-roll.png",
        "bgColor": Colors.pink[100]
      },
      {
        "title": "Momos",
        "image": "assets/Images/Categories/momo.png",
        "bgColor": Colors.blue[100]
      },
      {
        "title": "Thali",
        "image": "assets/Images/Categories/thali.png",
        "bgColor": Colors.tealAccent[100]
      },
    ];

    return Scaffold(
      body: isLoading
          ? Center(
              child: Lottie.asset(
                'assets/Animations/Loading.json',
                fit: BoxFit.contain,
                repeat: false,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: AppWidget.defaultSpace / 1.8,
                  left: AppWidget.defaultSpace / 1.8,
                  bottom: AppWidget.defaultSpace / 1.5,
                  top: AppWidget.spaceBtwItemsSm * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppWidget.spaceBtwSections,
                    ),
                    Row(
                      children: [
                        Text(
                          'Hey, ${name!}',
                          style: AppWidget.UseNameTextStyle().apply(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppWidget.spaceBtwItems),
                    const SearchTab(),
                    const SizedBox(height: AppWidget.spaceBtwItems),
                    const SectionHeading(
                      title: 'Our Categories',
                      showActionButton: false,
                    ),
                    const SizedBox(height: AppWidget.spaceBtwItems),
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return HomeCategories(
                            name: category['title'],
                            image: category['image'],
                            bgColor: category['bgColor'],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppWidget.spaceBtwItems),

                    /// Banner Slider - Dynamic from Supabase

                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: bannerStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No banners available.'));
                        }

                        List<String> bannerImages = snapshot.data!
                            .map((banner) => banner['banner'] as String)
                            .toList();

                        return ImageSlider(
                          imageUrls: bannerImages, // Dynamic banner images
                          autoPlayDuration: const Duration(seconds: 5),
                        );
                      },
                    ),

                    const SizedBox(height: AppWidget.defaultSpace),
                    SizedBox(
                      height: 300,
                      child: allItems(),
                    ),
                    const SizedBox(height: AppWidget.spaceBtwItems * 1.3),
                    const SectionHeading(
                      title: 'Popular Foods',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: AppWidget.spaceBtwItems,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        children: [
                          Expanded(
                            child: allItemsListView(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppWidget.spaceBtwItems),
                    Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            ),
    );
  }
}
