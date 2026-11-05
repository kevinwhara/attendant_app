import 'package:drift/drift.dart';

@DataClassName('AppSettingData')
class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get settingKey => text().unique()();
  TextColumn get settingValue => text()();
}
