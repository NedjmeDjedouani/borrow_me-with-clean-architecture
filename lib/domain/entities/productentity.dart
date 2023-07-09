// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? productname;
  final String? barcode;
  final String? id;
  final double? price;
  final DateTime? createdAt;
  const ProductEntity(
      {this.productname, this.barcode, this.id, this.price, this.createdAt});

  @override
  List<Object?> get props =>
      [productname, barcode, id, price, createdAt];

  ProductEntity copyWith({
    String? productname,
    String? barcode,
    String? id,
    double? price,
    DateTime? createdAt,
  }) {
    return ProductEntity(
     productname:  productname ?? this.productname,
    barcode:   barcode ?? this.barcode,
   id:   id ?? this.id,
   price:    price ?? this.price,
    createdAt:   createdAt ?? this.createdAt,
    );
  }
}
