class Client {
  String _firstname;
  String _lastname;
  int _id;
  double _balance;
  String _phonenumber;

  Client(this._firstname,this._lastname,this._phonenumber,this._balance);
  Client.withid(this._id,this._firstname,this._lastname,this._phonenumber,this._balance);
  Client.frommap(Map<String, dynamic> map){
    this._firstname=map['firstname'];
    this._lastname=map['lastname'];
    this._id=map['id'];
    this._balance=map['balance'];
    this._phonenumber=map['phonenumber'];

  }


  Map<String, dynamic> tomap() => {
        "id": this.id,
        'balance': this.balance,
        'firstname': this.firstname,
        'lastname': this.lastname,
        'phonenumber': this.phonenumber
      };

  String get firstname => _firstname;

  String get lastname => _lastname;

  String get phonenumber => _phonenumber;

  double get balance => _balance;

  int get id => _id;
}
