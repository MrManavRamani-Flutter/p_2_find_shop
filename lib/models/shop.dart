import 'package:p_2_find_shop/models/product.dart';

class Shop {
  int shopId;
  String shopName;
  String address;
  String phoneNumber;
  List<String> categories;
  List<Product> products; // List of products sold by this shop

  Shop({
    required this.shopId,
    required this.shopName,
    required this.address,
    required this.phoneNumber,
    required this.categories,
    required this.products,
  });

  // Optionally add methods to update shop details
  void setShopName(String newName) {
    shopName = newName;
  }

  void setAddress(String newAddress) {
    address = newAddress;
  }
}
