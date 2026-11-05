import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/app_settings_table.dart';

part 'app_settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase> with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  Future<String?> getSetting(String key) async {
    final row = await (select(appSettings)..where((tbl) => tbl.settingKey.equals(key))).getSingleOrNull();
    return row?.settingValue;
  }

  Future<void> setSetting(String key, String value) {
    return into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(
        settingKey: key,
        settingValue: value,
      ),
    );
  }
}

