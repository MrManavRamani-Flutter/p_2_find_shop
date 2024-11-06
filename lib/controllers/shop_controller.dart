import 'package:get/get.dart';

import '../models/city.dart';
import '../models/item.dart';
import '../models/shop.dart';
import '../models/shop_hours.dart';

class ShopController extends GetxController {
  // Observables for managing cities, shops, items, and shop hours
  var cities = <City>[].obs;
  var shops = <Shop>[].obs;
  var items = <Item>[].obs;
  var shopHours = <ShopHours>[].obs;

  // Filtered cities for search functionality
  var filteredCities = <City>[].obs;

  // Filtered shops for search functionality
  var filteredShops = <Shop>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize mock data
    _initializeMockData();

    // Initially, load all cities and shops into their respective filtered lists
    filteredCities.addAll(cities);
    filteredShops.addAll(shops);
  }

  // Method to initialize mock data for cities, shops, items, and shop hours
  void _initializeMockData() {
    cities.addAll([
      City(cityId: 1, cityName: "Rajkot"), // Rajkot city added
    ]);

    shops.addAll([
      Shop(
        shopId: 1,
        shopName: "Rajkot Grocers",
        cityId: 1,
        phoneNumber: "0281-123-4567",
        address: "123 Rajkot Road, Rajkot",
      ),
      Shop(
        shopId: 2,
        shopName: "Tech World",
        cityId: 1,
        phoneNumber: "0281-234-5678",
        address: "45 Technology Park, Rajkot",
      ),
      Shop(
        shopId: 3,
        shopName: "Fashion Hub",
        cityId: 1,
        phoneNumber: "0281-345-6789",
        address: "88 Fashion Street, Rajkot",
      ),
      Shop(
        shopId: 4,
        shopName: "Super Mart Rajkot",
        cityId: 1,
        phoneNumber: "0281-456-7890",
        address: "7 Main Market, Rajkot",
      ),
    ]);

    items.addAll([
      Item(
          itemId: 1,
          shopId: 1,
          itemName: "Tomatoes",
          itemCategory: "Vegetables"),
      Item(itemId: 2, shopId: 1, itemName: "Rice", itemCategory: "Grains"),
      Item(
          itemId: 3,
          shopId: 2,
          itemName: "Smartphone",
          itemCategory: "Electronics"),
      Item(
          itemId: 4,
          shopId: 2,
          itemName: "Laptop",
          itemCategory: "Electronics"),
      Item(itemId: 5, shopId: 3, itemName: "Shirt", itemCategory: "Apparel"),
      Item(itemId: 6, shopId: 3, itemName: "Jeans", itemCategory: "Apparel"),
      Item(
          itemId: 7,
          shopId: 4,
          itemName: "Wheat Flour",
          itemCategory: "Groceries"),
      Item(
          itemId: 8,
          shopId: 4,
          itemName: "Cooking Oil",
          itemCategory: "Groceries"),
    ]);

    shopHours.addAll([
      ShopHours(
          hoursId: 1,
          shopId: 1,
          dayOfWeek: "Monday",
          openTime: "08:00",
          closeTime: "20:00"),
      ShopHours(
          hoursId: 2,
          shopId: 1,
          dayOfWeek: "Tuesday",
          openTime: "08:00",
          closeTime: "20:00"),
      ShopHours(
          hoursId: 3,
          shopId: 2,
          dayOfWeek: "Wednesday",
          openTime: "10:00",
          closeTime: "22:00"),
      ShopHours(
          hoursId: 4,
          shopId: 3,
          dayOfWeek: "Thursday",
          openTime: "09:00",
          closeTime: "21:00"),
      ShopHours(
          hoursId: 5,
          shopId: 4,
          dayOfWeek: "Friday",
          openTime: "07:00",
          closeTime: "20:00"),
    ]);
  }

  // Method to filter cities based on search query
  void searchCity(String query) {
    if (query.isEmpty) {
      filteredCities.assignAll(cities);
    } else {
      filteredCities.assignAll(
        cities.where((city) =>
            city.cityName.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void searchShop(String query, int cityId) {
    if (query.isEmpty) {
      filteredShops.assignAll(
        shops.where((shop) => shop.cityId == cityId).toList(),
      );
    } else {
      filteredShops.assignAll(
        shops.where((shop) =>
            shop.cityId == cityId &&
            (shop.shopName.toLowerCase().contains(query.toLowerCase()) ||
                shop.address.toLowerCase().contains(query.toLowerCase()))),
      );
    }
  }

  // Retrieve shops for a given cityId
  List<Shop> getShopsByCity(int cityId) {
    return shops.where((shop) => shop.cityId == cityId).toList();
  }

  // Retrieve items for a given shopId
  List<Item> getItemsByShop(int shopId) {
    return items.where((item) => item.shopId == shopId).toList();
  }

  // Retrieve shop hours for a given shopId
  List<ShopHours> getShopHoursByShop(int shopId) {
    return shopHours.where((hours) => hours.shopId == shopId).toList();
  }

  // Get shop by ID
  Shop getShopById(int shopId) {
    return shops.firstWhere((shop) => shop.shopId == shopId);
  }

  // Get items by shop ID
  List<Item> getItemsByShopId(int shopId) {
    return items.where((item) => item.shopId == shopId).toList();
  }

  // Get shop hours by shop ID
  List<ShopHours> getShopHoursByShopId(int shopId) {
    return shopHours.where((hour) => hour.shopId == shopId).toList();
  }

  void addShop(String shopName, String address, String phoneNumber) {
    final newShop = Shop(
      shopId: DateTime.now().millisecondsSinceEpoch, // Unique shop ID
      shopName: shopName,
      address: address,
      phoneNumber: phoneNumber, // Add this field
      cityId: 1, // Assuming you have a default cityId
    );
    shops.add(newShop);
    filteredShops.assignAll(shops); // Refresh the filtered list
  }

  // Update existing shop
  void updateShop(int shopId, String shopName, String address) {
    final shop = shops.firstWhere((shop) => shop.shopId == shopId);
    shop.shopName = shopName;
    shop.address = address;
    filteredShops.assignAll(shops); // Refresh the filtered list
  }

  // Function to add an item
  void addItem(int shopId, String itemName, String itemCategory) {
    var newItem = Item(
      itemId: items.length + 1, // simple logic to generate unique itemId
      shopId: shopId,
      itemName: itemName,
      itemCategory: itemCategory,
    );
    items.add(newItem);
  }

  // Function to update an item
  void updateItem(int itemId, String itemName, String itemCategory) {
    var index = items.indexWhere((item) => item.itemId == itemId);
    if (index != -1) {
      items[index] = Item(
        itemId: itemId,
        shopId: items[index].shopId,
        itemName: itemName,
        itemCategory: itemCategory,
      );
    }
  }

  // Delete item
  void deleteItem(Item item) {
    items.remove(item);
  }
}
