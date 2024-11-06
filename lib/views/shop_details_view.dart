import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/theme/font_size.dart';
import 'package:p_2_find_shop/views/item_form_view.dart';

import '../controllers/shop_controller.dart';
import 'shop_form_view.dart'; // Assume ShopFormView is the page for adding/editing shops

class ShopDetailsView extends StatelessWidget {
  final int shopId;
  final ShopController shopController = Get.find();

  ShopDetailsView({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.blue,
        title: Obx(() {
          final shop = shopController.getShopById(shopId);
          return Text(
            shop.shopName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Get.to(() => ShopFormView(shopId: shopId));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final shop = shopController.getShopById(shopId);
          final items = shopController.getItemsByShopId(shopId);
          final hours = shopController.getShopHoursByShopId(shopId);

          return ListView(
            children: [
              // Shop Details Card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.storefront,
                              color: Colors.blue, size: 40),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              shop.shopName,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.blue, size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text("Address: ${shop.address}",
                                style: const TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.blue, size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text("Phone: ${shop.phoneNumber}",
                                style: const TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Available Items Section
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Available Items:",
                    style: TextStyle(
                        fontSize: FontSize.subtitle,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ItemFormView(shopId: shopId));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Add New Item"),
                  ),
                ],
              ),
              if (items.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("No items available.",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                      title: Text(
                        "${item.itemName} (${item.itemCategory})",
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Get.to(() => ItemFormView(
                                  itemId: item.itemId, shopId: shopId));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              shopController.deleteItem(item);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Opening Hours Section
              const Text(
                "Opening Hours:",
                style: TextStyle(
                    fontSize: FontSize.subtitle, fontWeight: FontWeight.bold),
              ),
              if (hours.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("No hours set.",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ...hours.map(
                (hour) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        "${hour.dayOfWeek}: ${hour.openTime} - ${hour.closeTime}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
