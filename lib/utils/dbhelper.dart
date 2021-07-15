import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/models/client.dart';
import 'package:test_app/models/order.dart';
import 'package:test_app/models/product.dart';
import 'dart:async';

class DbHelper {
  static final DbHelper dbhelper = DbHelper.Internal();
  factory DbHelper() => dbhelper;
  DbHelper.Internal();
  static Database db;

  Future<Database> createdatabase() async {
    if (db == null) {
      String path = join(await getDatabasesPath(), "gestion.db");
      db = await openDatabase(path, version: 1, onCreate: (db, int v) {
        db.execute(
            "Create Table clients (id integer primary key autoincrement,firstname varchar[30],lastname varchar[30],balance double,phonenumber varchar[15],created_at datetime)");
        db.execute(
            "create Table products (id integer primary key autoincrement,price Double,barcode varchar[20],productname varchar[30],created_at datetime)");
        db.execute(
            "create Table orders (id integer primary key,clientid integer,name varchar[50],price double,quantity integer ,created_at datetime ,updated_at datetime,foreign key (clientid) references clients (id) on delete cascade)");
        db.execute(
            "create table stock (id integer,quantity integer,updated_at datetime,foreign key (id) references products (id))");
      }, onUpgrade: (db, ov, nv) {
        if (ov < 2) {
          //  db.execute("Alter table clients add column created_at datetime not null");
          // db.execute("Alter table products add column created_at datetime not null");
        }
      });
      return db;
    } else {
      return db;
    }
  }

  Future<int> createclient(Client client) async {
    db = await createdatabase();
    Future<int> nrow = db.insert('clients', client.tomap());
    return nrow;
  }

  Future<int> createproduct(Product product) async {
    db = await createdatabase();
    Future<int> nrow = db.insert('products', product.tomap());
    return nrow;
  }

  Future<List<Map<String, dynamic>>> getallclients() async {
    db = await createdatabase();
    return db.query('clients');
  }

  Future<List<Map<String, dynamic>>> getallproducts() async {
    db = await createdatabase();
    return db.query('products');
  }

  Future<List<Product>> getallproductslist() async {
    var maps = await getallproducts();
    List<Product> productlist = <Product>[];
    int count = maps.length;
    print(count);
    if (count > 0) {
      for (int i = 0; i < count; i++) {
        productlist.add(new Product.frommap(maps.elementAt(i)));
      }
    }
    return productlist;
  }

  Future<List<Client>> getallclientslist() async {
    var maps = await getallclients();
    List<Client> clientslist = <Client>[];
    int count = maps.length;
    print(count);
    if (count > 0) {
      for (int i = 0; i < count; i++) {
        clientslist.add(new Client.frommap(maps.elementAt(i)));
      }
    }
    return clientslist;
  }

  Future<int> removeclient(Client client) async {
    db = await createdatabase();
    var nrows = db.delete("clients", where: "id = ?", whereArgs: [client.id]);
    return nrows;
  }

  Future<int> removeproduct(Product product) async {
    db = await createdatabase();
    var nrows = db.delete("products", where: "id = ?", whereArgs: [product.id]);
    return nrows;
  }

  Future<List<Map<String, dynamic>>> searchproduct(String val) async {
    db = await createdatabase();
    return db
        .query('products', where: "productname like ?", whereArgs: ['%$val%']);
  }

  Future<List<Map<String, dynamic>>> searchorderslist(Client client) async {
    db = await (createdatabase());
    var maps =
        await db.query("orders", where: "clientid = ?", whereArgs: [client.id]);
    return maps;
  }

  Future<int> updateproduct(Product product) async {
    db = await createdatabase();
    var nrows = db.update('products', product.tomap(),
        where: "id = ?", whereArgs: [product.id]);
    return nrows;
  }

  Future<int> updateclient(Client client) async {
    db = await createdatabase();
    var nrows = db.update('clients', client.tomap(),
        where: "id = ?", whereArgs: [client.id]);
    return nrows;
  }

  Future<int> createorderitem(Client client, Order order) async {
    db = await createdatabase();
    var nrows = db.insert('orders', order.tomap());
    return nrows;
  }

  Future<int> deleteorderslist(Client client) async {
    db = await createdatabase();
    var nrows =
        db.delete("orders", where: "clientid = ?", whereArgs: [client.id]);
    return nrows;
  }

  Future<int> deleteorder(Order order, Client client) async {
    db = await createdatabase();
    var nrows = db.delete("orders",
        where: "clientid = ? and id = ?", whereArgs: [client.id, order.id]);
    return nrows;
  }
}
