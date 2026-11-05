import 'package:drift/drift.dart';

@DataClassName('Employee')
class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get employeeCode => text().unique()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get department => text().nullable()();
  TextColumn get position => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

