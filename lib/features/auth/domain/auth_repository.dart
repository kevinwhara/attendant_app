import '../../../core/database/app_database.dart';

abstract class AuthRepository {
  Future<Employee?> login(String identifier, String password);
  Future<void> logout();
  Future<Employee?> getCurrentEmployee();
  Future<bool> changePassword(int employeeId, String oldPassword, String newPassword);
  Stream<Employee?> watchCurrentEmployee();
}

