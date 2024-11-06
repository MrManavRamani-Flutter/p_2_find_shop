class ShopHours {
  final int hoursId;
  final int shopId;
  final String dayOfWeek;
  final String openTime;
  final String closeTime;

  ShopHours(
      {required this.hoursId,
      required this.shopId,
      required this.dayOfWeek,
      required this.openTime,
      required this.closeTime});
}
