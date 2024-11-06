import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/views/shop_details_view.dart';
import 'package:p_2_find_shop/views/shop_form_view.dart'; // Import the ShopFormView for Add/Edit

import '../controllers/shop_controller.dart';

class ShopListView extends StatelessWidget {
  final int cityId;
  final ShopController shopController = Get.find();
  final TextEditingController _searchController = TextEditingController();

  ShopListView({super.key, required this.cityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shops"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            // Search bar for filtering shops by name or address
            _buildSearchBar(),

            const SizedBox(height: 16),

            // List of shops
            Expanded(
              child: Obx(() {
                var filteredShops = shopController.filteredShops
                    .where((shop) => shop.cityId == cityId)
                    .toList();

                // Display message if no shops are found
                if (filteredShops.isEmpty) {
                  return _buildNoShopsFoundMessage();
                }

                return _buildShopsList(filteredShops);
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() =>
              const ShopFormView()); // Navigate to the ShopFormView to add a new shop
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => shopController.searchShop(value, cityId),
      decoration: InputDecoration(
        hintText: "Search shop by name or address...",
        prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Message to show when no shops are found
  Widget _buildNoShopsFoundMessage() {
    return Center(
      child: Text(
        "No shops found",
        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
      ),
    );
  }

  // List of Shops Widget
  Widget _buildShopsList(List shops) {
    return ListView.builder(
      itemCount: shops.length,
      itemBuilder: (context, index) {
        var shop = shops[index];
        return _buildShopCard(shop);
      },
    );
  }

  // Shop Card Widget
  Widget _buildShopCard(shop) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: Icon(
          Icons.storefront,
          color: Colors.blue[700],
          size: 30,
        ),
        title: Text(
          shop.shopName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          shop.address,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Get.to(() => ShopFormView(shopId: shop.shopId));
                },
                icon: const Icon(Icons.edit)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[600],
              size: 20,
            ),
          ],
        ),
        onTap: () {
          // Navigate to the ShopFormView with the existing shop details for editing
          Get.to(() => ShopDetailsView(shopId: shop.shopId));
        },
      ),
    );
  }
}
