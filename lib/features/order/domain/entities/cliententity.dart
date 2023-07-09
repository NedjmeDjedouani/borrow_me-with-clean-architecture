// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String? firstname;
  final String? lastname;
  final String? id;
  final double? balance;
  final String? phonenumber;
  final DateTime? createdAt;

  const ClientEntity(
      {this.balance,
      this.createdAt,
      this.firstname,
      this.lastname,
      this.id,
      this.phonenumber});

  @override
  List<Object?> get props => [
        balance,
        createdAt,
        firstname,
        lastname,
        id,
        phonenumber
      ];

  ClientEntity copyWith({
    String? firstname,
    String? lastname,
    String? id,
    double? balance,
    String? phonenumber,
    DateTime? createdAt,
  }) {
    return ClientEntity(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      id: id ?? this.id,
      balance: balance ?? this.balance,
      phonenumber: phonenumber ?? this.phonenumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
