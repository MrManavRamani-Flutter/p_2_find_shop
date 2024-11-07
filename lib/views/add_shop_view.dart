import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/theme/font_size.dart';

import '../controllers/shop_controller.dart';
import '../models/shop.dart';

class AddShopView extends StatelessWidget {
  final ShopController shopController = Get.find();

  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController categoriesController = TextEditingController();

  AddShopView({super.key});

  // Validation Method
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (value.length != 10) {
      return 'Phone number must be 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  // Validation Method for other fields
  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Shop',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Shop Name
            TextField(
              controller: shopNameController,
              decoration: InputDecoration(
                labelText: 'Shop Name',
                hintText: 'Enter the name of the shop',
                prefixIcon: const Icon(Icons.store),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),

            // Address
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter shop address',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),

            // Phone Number
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter contact number',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),

            // Categories
            TextField(
              controller: categoriesController,
              decoration: InputDecoration(
                labelText: 'Categories',
                hintText: 'Separate categories with commas',
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 24),

            // Add Shop Button
            ElevatedButton.icon(
              onPressed: () {
                final shopName = shopNameController.text.trim();
                final address = addressController.text.trim();
                final phoneNumber = phoneNumberController.text.trim();
                final categories = categoriesController.text.trim();

                // Validate fields
                if (shopName.isEmpty) {
                  _showErrorMessage('Shop name cannot be empty');
                  return;
                }

                if (address.isEmpty) {
                  _showErrorMessage('Address cannot be empty');
                  return;
                }

                if (phoneNumber.isEmpty || phoneNumber.length != 10) {
                  _showErrorMessage('Phone number must be 10 digits');
                  return;
                }

                if (categories.isEmpty) {
                  _showErrorMessage('Categories cannot be empty');
                  return;
                }

                // Add shop if validation is passed
                final newShop = Shop(
                  shopId: shopController.shopList.length + 1,
                  shopName: shopName,
                  address: address,
                  phoneNumber: phoneNumber,
                  categories: categories.split(','),
                  products: [],
                );

                shopController.addShop(newShop);
                Get.back(); // Go back to the previous screen
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Shop'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Theme.of(context).colorScheme.secondary,
                textStyle: const TextStyle(
                  fontSize: FontSize.button,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}
