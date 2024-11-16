import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';
import '../models/shop.dart';

class ShopController extends GetxController {
  var shopList = <Shop>[].obs; // List of all shops
  var filteredShops = <Shop>[].obs; // Filtered list of shops
  var filteredProducts = <Product>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs; // Search query state
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  @override
  void onInit() {
    super.onInit();
    loadShops();
  }

  // Load initial shop data
  void loadShops() {
    shopList.value = [
      // Dummy Shop Data - Uncomment and add shop/product details here
      Shop(
        shopId: 1,
        shopName: 'Palav Matching',
        address: 'palav matching, moti chock, jasdan - 360050',
        phoneNumber: '7096584269',
        categories: ['Blows', 'ashtar', 'dress cloth material', 'chaniya'],
        products: [
          // Product(productName: 'Product 1', price: 100.0, imageUrl: 'path/to/image'),
          // Product(productName: 'Product 2', price: 200.0, imageUrl: 'path/to/image'),
        ],
      ),
      Shop(
        shopId: 2,
        shopName: 'Dharti Computer',
        address: 'dharti computer, chitaliya Road, jasdan - 360050',
        phoneNumber: '7096584269',
        categories: ['Electronic', 'Laptop', 'repair'],
        products: [
          // Product(productName: 'Product 1', price: 100.0, imageUrl: 'path/to/image'),
          // Product(productName: 'Product 2', price: 200.0, imageUrl: 'path/to/image'),
        ],
      ),
      Shop(
        shopId: 3,
        shopName: 'Hari Om General Store',
        address: 'hari om general store, bhadwadi, jasdan - 360050',
        phoneNumber: '7096584269',
        categories: ['General Store', 'wafer', 'cake'],
        products: [
          // Product(productName: 'Product 1', price: 100.0, imageUrl: 'path/to/image'),
          // Product(productName: 'Product 2', price: 200.0, imageUrl: 'path/to/image'),
        ],
      ),
      Shop(
        shopId: 4,
        shopName: 'Shyam Kunj hall',
        address: 'shyam kunj hall, chitaliya road, jasdan - 360050',
        phoneNumber: '7096584269',
        categories: ['functions', 'wedding hall', 'book hall for functions'],
        products: [
          // Product(productName: 'Product 1', price: 100.0, imageUrl: 'path/to/image'),
          // Product(productName: 'Product 2', price: 200.0, imageUrl: 'path/to/image'),
        ],
      ),
      Shop(
        shopId: 5,
        shopName: 'Angel English Academy',
        address: 'Angel English Academy, new bus stand, jasdan - 360050',
        phoneNumber: '7096584269',
        categories: ['Spoken English', 'Classes'],
        products: [
          // Product(productName: 'Product 1', price: 100.0, imageUrl: 'path/to/image'),
          // Product(productName: 'Product 2', price: 200.0, imageUrl: 'path/to/image'),
        ],
      ),
    ];
    filteredShops.value = shopList; // Initialize with full shop list
  }

  // Filter shops based on search query (matching shop name or category)
  void filterShops(String query) {
    if (query.isEmpty) {
      filteredShops.value = shopList;
    } else {
      filteredShops.value = shopList.where((shop) {
        final matchesName =
            shop.shopName.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = shop.categories.any(
            (category) => category.toLowerCase().contains(query.toLowerCase()));
        return matchesName || matchesCategory;
      }).toList();
    }
  }

  // Add a new shop and update filtered shops
  void addShop(Shop shop) {
    shopList.add(shop);
    filteredShops.value = shopList;
  }

  // Filter products within a shop based on search query
  void filterProducts(String query, int shopId) {
    final shop = shopList.firstWhere((shop) => shop.shopId == shopId);
    if (query.isEmpty) {
      filteredProducts.value = shop.products;
    } else {
      filteredProducts.value = shop.products
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  // Reset product search filters
  void clearFilter(int shopId) {
    searchQuery.value = '';
    filterProducts(searchQuery.value, shopId);
  }

  // Image picking for product
  Future<void> pickImage(int shopId) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final product = Product(
        productName: 'New Product',
        price: 0.0,
        imageUrl: image.path,
      );
      addProductToShop(shopId, product);
    }
  }

  // Add a new product to a shop and update filtered products if applicable
  void addProductToShop(int shopId, Product product) {
    final shop = shopList.firstWhere((shop) => shop.shopId == shopId);
    shop.products.add(product);
    // if (filteredShops.contains(shop)) {
    filteredProducts.value = shop.products;
    // }
  }
}
