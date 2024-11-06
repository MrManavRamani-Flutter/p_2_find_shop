import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p_2_find_shop/models/city.dart';
import 'package:p_2_find_shop/views/shop_list_view.dart';

import '../controllers/shop_controller.dart';

class HomeView extends StatelessWidget {
  final ShopController shopController = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Shop"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            // Search bar for filtering cities
            TextField(
              onChanged: (value) => shopController.searchCity(value),
              decoration: InputDecoration(
                hintText: "Search city...",
                prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // List of cities
            Expanded(
              child: Obx(() {
                if (shopController.filteredCities.isEmpty) {
                  return Center(
                    child: Text(
                      "No cities found",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: shopController.filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = shopController.filteredCities[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ShopListView(cityId: city.cityId));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          leading: Icon(
                            Icons.location_city,
                            color: Colors.blue[700],
                            size: 30,
                          ),
                          title: Text(
                            city.cityName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit button
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditCityDialog(context, city);
                                },
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      // Add Floating Action Button for adding a city
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCityDialog(context);
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to show the Add City dialog
  void _showAddCityDialog(BuildContext context) {
    final TextEditingController cityNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New City"),
          content: TextField(
            controller: cityNameController,
            decoration: const InputDecoration(
              hintText: "Enter city name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String cityName = cityNameController.text.trim();
                if (cityName.isNotEmpty) {
                  // Add the new city to the shopController's list
                  shopController.cities.add(City(
                    cityId: shopController.cities.length + 1,
                    cityName: cityName,
                  ));
                  shopController.filteredCities.add(City(
                    cityId: shopController.cities.length,
                    cityName: cityName,
                  ));

                  // Close the dialog
                  Get.back();
                } else {
                  // Show error message if no city name entered
                  Get.snackbar("Error", "City name cannot be empty");
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

// Function to show the Edit City dialog
  void _showEditCityDialog(BuildContext context, City city) {
    final TextEditingController cityNameController =
        TextEditingController(text: city.cityName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit City"),
          content: TextField(
            controller: cityNameController,
            decoration: const InputDecoration(
              hintText: "Edit city name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String newCityName = cityNameController.text.trim();
                if (newCityName.isNotEmpty && newCityName != city.cityName) {
                  // Update the city name using the method
                  city.updateCityName(newCityName);
                  shopController.filteredCities.refresh();
                  Get.back();
                } else {
                  // Show error message if no name entered or name is the same
                  Get.snackbar(
                      "Error", "City name cannot be empty or the same");
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
