import 'package:sqflite/sqflite.dart';

class Product {
  String _productname;
  String _barcode;
  int _id;
  double _price;
  DateTime _createdAt;
  Product(this._productname, this._barcode, this._price,this._createdAt);
  Product.withid(this._id, this._productname, this._barcode, this._price,this._createdAt);
  Map<String, dynamic> tomap() => {
        "id": this._id,
        "productname": this._productname,
        "barcode": this._barcode,
        "price": this._price,
    "created_at":this._createdAt.millisecondsSinceEpoch,
      };

  Product.frommap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._barcode = map['barcode'];
    this._productname = map['productname'];
    this._price = map['price'];
    this._createdAt=DateTime.fromMillisecondsSinceEpoch(map['created_at']);
  }

  String get barcode => _barcode;
  String get productname => _productname;
  int get id => _id;
  double get price => _price;
  DateTime get createdAt => _createdAt;
}
