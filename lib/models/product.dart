class Product {
  String _productname;
  String _barcode;
  int _id;
  double _price;
  Product(this._productname, this._barcode, this._price);
  Product.withid(this._id, this._productname, this._barcode, this._price);

  Map<String, dynamic> tomap() => {
        "id": this._id,
        "productname": this._productname,
        "barcode": this._barcode,
        "price": this._price
      };

  Product.frommap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._barcode = map['barcode'];
    this._productname = map['productname'];
    this._price = map['price'];
  }

  String get barcode => _barcode;
  String get productname => _productname;
  int get id => _id;
  double get price => _price;
}
