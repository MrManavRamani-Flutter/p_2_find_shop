import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/controllers/shop_controller.dart';
import 'package:p_2_find_shop/models/product.dart';
import 'package:p_2_find_shop/models/shop.dart';
import 'package:p_2_find_shop/theme/font_size.dart';
import 'package:p_2_find_shop/views/add_product_view.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildShopDetailsCard(context),
            const SizedBox(height: 24),
            _buildProductsSectionTitle(context),
            const SizedBox(height: 24),
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
      title:
          Text(shop.shopName, style: Theme.of(context).textTheme.headlineLarge),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 0,
    );
  }

  // Shop Details Card
  Widget _buildShopDetailsCard(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                shop.shopName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            _buildShopDetailRow(context, 'Address: ${shop.address}',
                icon: Icons.location_on,
                iconColor: Theme.of(context).colorScheme.secondary),
            const SizedBox(height: 12),
            _buildShopDetailRow(context, 'Phone: ${shop.phoneNumber}',
                icon: Icons.phone,
                iconColor: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            _buildShopDetailRow(
                context, 'Categories: ${shop.categories.join(", ")}',
                icon: Icons.category,
                iconColor: Theme.of(context).colorScheme.secondary),
          ],
        ),
      ),
    );
  }

  // Shop Detail Row
  Widget _buildShopDetailRow(BuildContext context, String text,
      {IconData? icon, Color? iconColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Icon(icon,
              size: 20,
              color: iconColor ?? Theme.of(context).colorScheme.onSurface),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: FontSize.body,
                ),
          ),
        ),
      ],
    );
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
