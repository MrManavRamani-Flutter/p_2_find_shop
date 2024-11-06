class Shop {
  final int shopId;
  String shopName; // Keep as mutable
  String address; // Keep as mutable
  final String phoneNumber;
  final int cityId;

  Shop({
    required this.shopId,
    required this.shopName,
    required this.address,
    required this.phoneNumber,
    required this.cityId,
  });

  // Setter methods to update properties
  void setShopName(String newName) {
    shopName = newName;
  }

  void setAddress(String newAddress) {
    address = newAddress;
  }
}
