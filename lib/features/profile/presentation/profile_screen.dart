import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/database/database_provider.dart';
import '../../auth/presentation/auth_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employee = ref.watch(currentEmployeeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar & Basic Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primaryLight,
                        child: Text(
                          (employee?.name.isNotEmpty ?? false)
                              ? employee!.name.substring(0, 1).toUpperCase()
                              : 'E',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        employee?.name ?? 'Employee Name',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${employee?.employeeCode ?? "EMP001"} • ${employee?.email ?? ""}',
                        style: const TextStyle(color: AppColors.muted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Detailed Profile Fields
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.badge_outlined, color: AppColors.primary),
                      title: const Text('Employee ID', style: TextStyle(fontSize: 13, color: AppColors.muted)),
                      subtitle: Text(employee?.employeeCode ?? 'EMP001', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.corporate_fare_outlined, color: AppColors.primary),
                      title: const Text('Department', style: TextStyle(fontSize: 13, color: AppColors.muted)),
                      subtitle: Text(employee?.department ?? 'Engineering', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.work_outline, color: AppColors.primary),
                      title: const Text('Position', style: TextStyle(fontSize: 13, color: AppColors.muted)),
                      subtitle: Text(employee?.position ?? 'Staff', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.email_outlined, color: AppColors.primary),
                      title: const Text('Email', style: TextStyle(fontSize: 13, color: AppColors.muted)),
                      subtitle: Text(employee?.email ?? 'employee@attendant.local', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Actions Card
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit_outlined, color: Colors.blueAccent),
                      title: const Text('Edit Information', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: const Text('Update your display name, department, or position'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showEditProfileDialog(context, ref),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.lock_reset, color: Colors.orange),
                      title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: const Text('Update demo login password locally'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showChangePasswordDialog(context, ref),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Logout Button
              FilledButton.icon(
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: AppColors.primaryDark,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.logout, color: AppColors.primaryDark),
                label: const Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref) {
    final employee = ref.read(currentEmployeeProvider);
    if (employee == null) return;

    final nameController = TextEditingController(text: employee.name);
    final deptController = TextEditingController(text: employee.department ?? '');
    final posController = TextEditingController(text: employee.position ?? '');

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: deptController,
                  decoration: const InputDecoration(labelText: 'Department'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: posController,
                  decoration: const InputDecoration(labelText: 'Position'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final db = ref.read(appDatabaseProvider);
                final now = DateTime.now().toUtc().millisecondsSinceEpoch;
                await db.employeesDao.updateEmployeeProfile(
                  id: employee.id,
                  name: nameController.text.trim(),
                  department: deptController.text.trim(),
                  position: posController.text.trim(),
                  updatedAt: now,
                );
                // Refresh session employee
                final updated = await db.employeesDao.getEmployeeById(employee.id);
                if (updated != null) {
                  ref.read(authProvider.notifier).updateEmployee(updated);
                }
                if (dialogCtx.mounted) Navigator.pop(dialogCtx);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context, WidgetRef ref) {
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: oldPassController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Current Password'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: newPassController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'New Password'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (newPassController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('New password must be at least 6 characters.')),
                  );
                  return;
                }
                final success = await ref.read(authProvider.notifier).changePassword(
                      oldPassController.text,
                      newPassController.text,
                    );
                if (dialogCtx.mounted) Navigator.pop(dialogCtx);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? 'Password changed successfully!'
                            : 'Incorrect current password. Please try again.',
                      ),
                      backgroundColor: success ? AppColors.success : AppColors.primaryDark,
                    ),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
