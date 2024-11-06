import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/shop_controller.dart';

class ItemFormView extends StatefulWidget {
  final int shopId;
  final int? itemId; // To edit an existing item

  const ItemFormView({super.key, required this.shopId, this.itemId});

  @override
  ItemFormViewState createState() => ItemFormViewState();
}

class ItemFormViewState extends State<ItemFormView> {
  final ShopController shopController = Get.find();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _itemNameController;
  late TextEditingController _itemCategoryController;
  late String itemName;
  late String itemCategory;

  @override
  void initState() {
    super.initState();

    // Initialize controllers and load existing item if editing
    _itemNameController = TextEditingController();
    _itemCategoryController = TextEditingController();

    if (widget.itemId != null) {
      var item = shopController.items
          .firstWhere((item) => item.itemId == widget.itemId);
      _itemNameController.text = item.itemName;
      _itemCategoryController.text = item.itemCategory;
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemCategoryController.dispose();
    super.dispose();
  }

  // Function to handle form submission (Add/Edit Item)
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Gather values from controllers
      itemName = _itemNameController.text;
      itemCategory = _itemCategoryController.text;

      if (widget.itemId == null) {
        // Add new item
        shopController.addItem(
          widget.shopId,
          itemName,
          itemCategory,
        );
      } else {
        // Edit existing item
        shopController.updateItem(
          widget.itemId!,
          itemName,
          itemCategory,
        );
      }

      // Navigate back to the previous screen after saving the item
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemId == null ? 'Add New Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Item Name TextField
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Item name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Item Category TextField
              TextFormField(
                controller: _itemCategoryController,
                decoration: const InputDecoration(labelText: 'Item Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Item category is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(widget.itemId == null ? 'Add Item' : 'Update Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
