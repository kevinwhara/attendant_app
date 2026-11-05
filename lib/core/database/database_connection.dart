import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

DatabaseConnection openAppDatabaseConnection({String name = 'attendant_app'}) {
  return driftDatabase(
    name: name,
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}

