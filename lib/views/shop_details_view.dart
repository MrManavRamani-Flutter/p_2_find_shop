import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/controllers/shop_controller.dart';
import 'package:p_2_find_shop/models/product.dart';
import 'package:p_2_find_shop/models/shop.dart';
import 'package:p_2_find_shop/theme/font_size.dart';
import 'package:p_2_find_shop/views/add_product_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailsView extends StatelessWidget {
  final Shop shop;

  const ShopDetailsView({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.put(ShopController());
    shopController.filteredProducts.value = shop.products;

    return Scaffold(
      appBar: _buildAppBar(context, shopController),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shop Details Section with Header
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Shop Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildShopDetails(context),
                          // Add detailed rows for address, category, and contact
                        ],
                      ),
                    ),

                    // Divider separating details and action buttons
                    Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2)),

                    // Action Buttons Section
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _makePhoneCall(shop.phoneNumber),
                              icon:
                                  const Icon(Icons.phone, color: Colors.white),
                              label: const Text(
                                'Call',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showLocation(shop.address),
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Location',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
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
            ),
            const SizedBox(height: 24),
            _buildProductsSectionTitle(context),
            const SizedBox(height: 16),
            _buildSearchBar(shopController, context),
            const SizedBox(height: 16),
            _buildProductList(shopController, context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddProductView, passing the shop as argument
          Get.to(() => AddProductView(shop: shop));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  // AppBar with Reload Button
  AppBar _buildAppBar(BuildContext context, ShopController shopController) {
    return AppBar(
      title: Text(
        shop.shopName,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 0,
    );
  }

// Shop details section with address, categories, and contact number
  Widget _buildShopDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          context,
          label: 'Address:',
          value: shop.address,
          icon: Icons.location_on,
          iconColor: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        _buildDetailRow(
          context,
          label: 'Categories:',
          value: shop.categories.join(", "),
          icon: Icons.category,
          iconColor: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        _buildDetailRow(
          context,
          label: 'Phone:',
          value: shop.phoneNumber,
          icon: Icons.phone,
          iconColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  // Shop detail row for individual details
  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label ',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              children: [
                TextSpan(
                  text: value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Make phone call with url_launcher
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // print('Could not launch $phoneNumber');
      throw 'Could not launch $phoneNumber';
    }
  }

  // Show location (this method is a placeholder for actual map functionality)
  Future<void> _showLocation(String address) async {
    final Uri googleMapsUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$address');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      // print('Could not open Google Maps');
      throw 'Could not open Google Maps';
    }
  }

  // Search Bar
  Widget _buildSearchBar(ShopController shopController, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) =>
                shopController.filterProducts(value, shop.shopId),
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon:
                  Icon(Icons.search, color: Theme.of(context).iconTheme.color),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon:
                    Icon(Icons.clear, color: Theme.of(context).iconTheme.color),
                onPressed: () => shopController.clearFilter(shop.shopId),
              ),
              filled: true,
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            ),
          ),
        ),
      ],
    );
  }

  // Products Section Title
  Widget _buildProductsSectionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        'Products Available',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  // Product List
  Widget _buildProductList(
      ShopController shopController, BuildContext context) {
    return Obx(() {
      // Check if loading, show a circular progress indicator if true
      if (shopController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
          ),
        );
      }

      final filteredProducts = shopController.filteredProducts;
      if (filteredProducts.isEmpty) {
        return Center(
          child: Text(
            'No products available in this shop.',
            style: TextStyle(color: Colors.grey[600], fontSize: FontSize.body),
          ),
        );
      }

      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return _buildProductCard(product, context);
          },
        ),
      );
    });
  }

  // Product Card
  Widget _buildProductCard(Product product, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.file(
              File(product.imageUrl),
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.productName,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('₹ ${product.price}',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
