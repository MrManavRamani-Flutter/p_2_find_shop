class Item {
  int itemId;
  int shopId;
  String itemName;
  String itemCategory;

  Item({
    required this.itemId,
    required this.shopId,
    required this.itemName,
    required this.itemCategory,
  });

  // Setter for itemName
  void setItemName(String name) {
    itemName = name;
  }

  // Setter for itemCategory
  void setItemCategory(String category) {
    itemCategory = category;
  }
}
