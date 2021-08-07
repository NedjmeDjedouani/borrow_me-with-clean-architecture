class Order {
  String _ordername;
  double _price;
  int _quantity, _id, _clientid;
  DateTime _createdAt;
  Order(this._ordername, this._price, this._clientid, {int quantity = 1,createdTime})
      : _quantity = quantity,_createdAt=createdTime;
  Order.withid(this._id, this._ordername, this._price, {int quantity = 1,createdTime})
      : _quantity = quantity,_createdAt=createdTime;
  Order.frommap(Map<String, dynamic> map) {
    _ordername = map['name'];
    _price = map['price'];
    _quantity = map['quantity'];
    _id = map['id'];
    _clientid = map['clientid'];
    _createdAt=DateTime.fromMillisecondsSinceEpoch(map['created_at']) ;
  }
  Map<String, dynamic> tomap() => {
        'id': _id,
        "name": _ordername,
        "price": _price,
        "quantity": _quantity,
        "clientid": _clientid,
        "created_at":_createdAt.millisecondsSinceEpoch,
      };

  int get quantity => _quantity;

  double get price => _price;

  String get ordername => _ordername;

  int get id => _id;

  DateTime get createdAt => _createdAt;
}
