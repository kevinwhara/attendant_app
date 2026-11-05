import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

class AttendantApp extends StatefulWidget {
  const AttendantApp({super.key});
  @override
  State<AttendantApp> createState() => _AttendantAppState();
}

class _AttendantAppState extends State<AttendantApp> {
  bool authenticated = false;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Attendant',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: authenticated
        ? Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => setState(() => authenticated = false),
                child: const Text('Log out'),
              ),
            ),
          )
        : LoginPage(onLogin: () => setState(() => authenticated = true)),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onLogin});
  final VoidCallback onLogin;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final id = TextEditingController(text: 'EMP-001');
  final password = TextEditingController();
  bool obscure = true;
  @override
  void dispose() {
    id.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.fact_check_outlined,
                    color: AppColors.primary,
                    size: 42,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to Attendant',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sign in to manage your attendance.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: id,
                    decoration: const InputDecoration(
                      labelText: 'Employee ID or email',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: password,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(() => obscure = !obscure),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: widget.onLogin,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Sign in'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Demo account: EMP-001 / attendant123',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
