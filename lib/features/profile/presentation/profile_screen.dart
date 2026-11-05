import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/database/database_provider.dart';
import '../../../shared/widgets/app_card.dart';
import '../../auth/presentation/auth_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employee = ref.watch(currentEmployeeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar & Basic Info Card
                AppCard(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl, horizontal: AppSpacing.lg),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.surfaceSecondary,
                        child: Text(
                          (employee?.name.isNotEmpty ?? false)
                              ? employee!.name.substring(0, 1).toUpperCase()
                              : 'E',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        employee?.name ?? 'Employee Name',
                        style: AppTypography.pageTitle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${employee?.employeeCode ?? "EMP001"} • ${employee?.email ?? ""}',
                        style: AppTypography.supporting,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Detailed Profile Fields (Neutral Line Icons)
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.badge_outlined, color: AppColors.textSecondary, size: 20),
                        title: const Text('Employee ID', style: AppTypography.caption),
                        subtitle: Text(
                          employee?.employeeCode ?? 'EMP001',
                          style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.corporate_fare_outlined, color: AppColors.textSecondary, size: 20),
                        title: const Text('Department', style: AppTypography.caption),
                        subtitle: Text(
                          employee?.department ?? 'Engineering',
                          style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.work_outline, color: AppColors.textSecondary, size: 20),
                        title: const Text('Position', style: AppTypography.caption),
                        subtitle: Text(
                          employee?.position ?? 'Staff',
                          style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.email_outlined, color: AppColors.textSecondary, size: 20),
                        title: const Text('Email', style: AppTypography.caption),
                        subtitle: Text(
                          employee?.email ?? 'employee@attendant.local',
                          style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Actions Card
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit_outlined, color: AppColors.textSecondary, size: 20),
                        title: const Text('Edit Information', style: AppTypography.cardTitle),
                        subtitle: const Text('Update your display name, department, or position', style: AppTypography.supporting),
                        trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textMuted),
                        onTap: () => _showEditProfileDialog(context, ref),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.lock_reset, color: AppColors.textSecondary, size: 20),
                        title: const Text('Change Password', style: AppTypography.cardTitle),
                        subtitle: const Text('Update demo login password locally', style: AppTypography.supporting),
                        trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textMuted),
                        onTap: () => _showChangePasswordDialog(context, ref),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Logout Button (Neutral Outlined with subtle red accent)
                OutlinedButton.icon(
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: const Text('Log Out'),
                ),
              ],
            ),
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
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusXl),
          title: const Text('Edit Profile', style: AppTypography.sectionTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: deptController,
                  decoration: const InputDecoration(labelText: 'Department'),
                ),
                const SizedBox(height: AppSpacing.md),
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
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: AppColors.success,
                    ),
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
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusXl),
          title: const Text('Change Password', style: AppTypography.sectionTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: oldPassController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Current Password'),
                ),
                const SizedBox(height: AppSpacing.md),
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
                    const SnackBar(
                      content: Text('New password must be at least 6 characters.'),
                      backgroundColor: AppColors.error,
                    ),
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
                      backgroundColor: success ? AppColors.success : AppColors.error,
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
