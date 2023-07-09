// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? _name;
  final double? _price;
  final String? _id;
  final String? _clientid;
  final int? _quantity;
  final DateTime? _createdAt;

  const OrderEntity(
      {String? name,
      double? price,
      String? id,
      String? clientId,
      int? quantity,
      DateTime? createdAt})
      : _clientid = clientId,
        _createdAt = createdAt,
        _price = price,
        _id = id,
        _quantity = quantity,
        _name = name;

  int? get quantity => _quantity;

  double? get price => _price;
  String? get clientId => _clientid;
  String? get name => _name;
  String? get id => _id;

  DateTime? get createdAt => _createdAt;

  @override
  List<Object?> get props =>  [
        _clientid,
        _createdAt,
        _id,
        _name,
        _price,
        _quantity,
      ];

  OrderEntity copyWith({
    String? name,
    double? price,
    String? id,
    String? clientid,
    int? quantity,
    DateTime? createdAt,
  }) {
    return OrderEntity(
    name:   name ?? _name,
    price:   price ?? _price,
     id:  id ?? _id,
   clientId:    clientid ?? _clientid,
    quantity:   quantity ?? _quantity,
     createdAt:  createdAt ?? _createdAt,
    );
  }
}
