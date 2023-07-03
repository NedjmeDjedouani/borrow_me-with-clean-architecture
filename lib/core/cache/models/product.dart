import 'package:drift/drift.dart';

@DataClassName('Product')
class ProductLocalModel extends Table {
  TextColumn get name => text()();
  TextColumn get barcode => text()();
  TextColumn get remoteId => text().unique()();
  // IntColumn get id => integer().autoIncrement()();
  RealColumn get price => real()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {remoteId};
}
