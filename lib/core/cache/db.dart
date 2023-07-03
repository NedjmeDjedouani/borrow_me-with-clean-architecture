import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:test_app/core/cache/models/client.dart';
import 'package:test_app/core/cache/models/order.dart';
import 'package:test_app/core/cache/models/product.dart';


part 'db.g.dart';


@DriftDatabase(tables: [OrderLocalModel,ProductLocalModel,ClientLocalModel])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());


  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}