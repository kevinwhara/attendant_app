import 'package:drift/drift.dart';

@DataClassName('HolidayData')
class Holidays extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get holidayDate => text()(); // YYYY-MM-DD
  TextColumn get description => text().nullable()();
}

