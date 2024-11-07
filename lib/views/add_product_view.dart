import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/shop_controller.dart';
import '../models/product.dart';
import '../models/shop.dart';
import '../theme/font_size.dart';

class AddProductView extends StatefulWidget {
  final Shop shop;

  const AddProductView({super.key, required this.shop});

  @override
  AddProductViewState createState() => AddProductViewState();
}

class AddProductViewState extends State<AddProductView> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();
  final ShopController shopController = Get.find();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _addProduct() {
    final productName = productNameController.text.trim();
    final priceText = priceController.text.trim();

    if (productName.isEmpty) {
      _showErrorMessage('Please enter the product name.');
      return;
    }

    if (priceText.isEmpty) {
      _showErrorMessage('Please enter the product price.');
      return;
    }

    if (_selectedImage == null) {
      _showErrorMessage('Please select an image for the product.');
      return;
    }

    double? price;
    try {
      price = double.parse(priceText);
    } catch (e) {
      _showErrorMessage('Please enter a valid number for the price.');
      return;
    }

    final newProduct = Product(
      productName: productName,
      price: price,
      imageUrl: _selectedImage?.path ?? "",
    );

    shopController.addProductToShop(widget.shop.shopId, newProduct);
    Get.back();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Product to ${widget.shop.shopName}',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: _selectedImage == null
                  ? Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.add_a_photo),
                    )
                  : Image.file(
                      _selectedImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
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
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
