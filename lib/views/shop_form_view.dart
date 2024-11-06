import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/shop_controller.dart';

class ShopFormView extends StatefulWidget {
  final int? shopId; // For editing, shopId will be passed
  const ShopFormView({super.key, this.shopId});

  @override
  ShopFormViewState createState() => ShopFormViewState();
}

class ShopFormViewState extends State<ShopFormView> {
  final ShopController shopController = Get.find();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController =
      TextEditingController(); // New controller

  @override
  void initState() {
    super.initState();

    if (widget.shopId != null) {
      // If shopId is passed, fetch the shop details for editing
      var shop = shopController.shops
          .firstWhere((shop) => shop.shopId == widget.shopId);
      _shopNameController.text = shop.shopName;
      _addressController.text = shop.address;
      _phoneNumberController.text =
          shop.phoneNumber; // Set phone number if editing
    }
  }

  void _saveShop() {
    if (widget.shopId == null) {
      // Add new shop
      shopController.addShop(
        _shopNameController.text,
        _addressController.text,
        _phoneNumberController.text, // Include phone number
      );
    } else {
      // Edit existing shop
      shopController.updateShop(
        widget.shopId!,
        _shopNameController.text,
        _addressController.text,
      );
    }
    Get.back(); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shopId == null ? "Add Shop" : "Edit Shop"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _shopNameController,
              decoration: const InputDecoration(
                labelText: 'Shop Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController, // New input for phone number
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType:
                  TextInputType.phone, // Ensure it handles phone number input
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveShop,
              child: Text(widget.shopId == null ? "Add Shop" : "Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
