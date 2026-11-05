import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/employees_table.dart';

part 'employees_dao.g.dart';

@DriftAccessor(tables: [Employees])
class EmployeesDao extends DatabaseAccessor<AppDatabase> with _$EmployeesDaoMixin {
  EmployeesDao(super.db);

  Future<Employee?> getEmployeeById(int id) {
    return (select(employees)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<Employee?> watchEmployeeById(int id) {
    return (select(employees)..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  Future<Employee?> getEmployeeByCodeOrEmail(String identifier) {
    final lower = identifier.trim().toLowerCase();
    return (select(employees)
          ..where((tbl) =>
              tbl.employeeCode.lower().equals(lower) |
              tbl.email.lower().equals(lower)))
        .getSingleOrNull();
  }

  Future<int> insertEmployee(EmployeesCompanion entry) {
    return into(employees).insert(entry);
  }

  Future<bool> updateEmployee(EmployeesCompanion entry) {
    return update(employees).replace(entry);
  }

  Future<int> updateEmployeeProfile({
    required int id,
    required String name,
    required String? department,
    required String? position,
    required int updatedAt,
  }) {
    return (update(employees)..where((tbl) => tbl.id.equals(id))).write(
      EmployeesCompanion(
        name: Value(name),
        department: Value(department),
        position: Value(position),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  Future<int> updatePassword({
    required int id,
    required String passwordHash,
    required int updatedAt,
  }) {
    return (update(employees)..where((tbl) => tbl.id.equals(id))).write(
      EmployeesCompanion(
        passwordHash: Value(passwordHash),
        updatedAt: Value(updatedAt),
      ),
    );
  }
}
