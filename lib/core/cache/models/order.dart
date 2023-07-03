import 'package:drift/drift.dart';




@DataClassName('Order')
class OrderLocalModel extends Table {
 // IntColumn get id => integer().autoIncrement()();
  TextColumn get remoteId => text().unique()();

  TextColumn get name => text().withLength(min: 2, max: 32)();
  RealColumn get price => real().named('body')();
  IntColumn get quantity => integer()();
  IntColumn get clientId => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
    Set<Column> get primaryKey => {remoteId};

}
