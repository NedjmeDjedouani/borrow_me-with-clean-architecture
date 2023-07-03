import 'package:drift/drift.dart';

@DataClassName('Client')
class ClientLocalModel extends Table {
  TextColumn get firstName => text().withLength(min: 2, max: 50)();
  TextColumn get lastName => text().nullable().withLength(min: 2, max: 50)();
    TextColumn get remoteId => text().unique()();

 // IntColumn get id =>  integer().customConstraint('IDENTITY(1,1)')();
  RealColumn get balance => real()();
  TextColumn get phoneNumber => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

@override
  Set<Column> get primaryKey => {remoteId};

}
