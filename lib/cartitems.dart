
class CartItems {
  CartItems(
      {this.veg,
      this.imgPath,
      this.name,
      this.price,
      this.oprice,
      this.count,
      this.canteenid,
      this.canteenname});
  final bool veg;
  int count;
  int price;
  int oprice;

  bool on = true;
  final String name, imgPath, canteenid, canteenname;
}
