import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/views/add_shop_view.dart';
import 'package:p_2_find_shop/views/shop_details_view.dart';

import '../controllers/shop_controller.dart';
import '../controllers/theme_controller.dart';
import '../theme/font_size.dart';

class HomeView extends StatelessWidget {
  final ShopController shopController = Get.find();
  final ThemeController themeController = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Digital Jasdan',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          // Theme switch button
          IconButton(
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: themeController.toggleTheme,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search field
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by Shop Name or Category',
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context).iconTheme.color),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,
                      color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    searchController.clear();
                    shopController.filterShops('');
                  },
                ),
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              onChanged: (value) {
                shopController.filterShops(value);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.to(() => AddShopView()); // Navigate to AddShopView
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .surface, // Use the secondary color from the current theme
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                shadowColor: Theme.of(context).colorScheme.secondary,
                textStyle: const TextStyle(
                  fontSize: FontSize
                      .button, // You can use your FontSize constant here
                  color: Colors.white, // White text color
                ),
              ),
              child: Text(
                'Add New Shop',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (shopController.filteredShops.isEmpty) {
                  return Center(
                    child: Text(
                      'No shops found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: shopController.filteredShops.length,
                    itemBuilder: (context, index) {
                      final shop = shopController.filteredShops[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to ShopDetailsView and pass the selected shop
                          Get.to(() => ShopDetailsView(shop: shop));
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shop.shopName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Categories: ${shop.categories.join(", ")}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color
                                            ?.withOpacity(0.7),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
