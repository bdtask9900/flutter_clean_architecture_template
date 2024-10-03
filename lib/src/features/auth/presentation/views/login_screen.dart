import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/login.notifier.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize TextEditingControllers with hooks
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // Watch login state
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    // Handle Form Submission
    void submitForm() {
      final email = emailController.text;
      final password = passwordController.text;

      // Trigger the login process
      loginNotifier.login(email, password);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: loginState.errorMessage != null &&
                        loginState.errorMessage!.contains('email')
                    ? 'Invalid email'
                    : null,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: loginState.errorMessage != null &&
                        loginState.errorMessage!.contains('password')
                    ? 'Invalid password'
                    : null,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            loginState.isSubmitting
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: loginState.isSubmitting ? null : submitForm,
                    child: Text('Login'),
                  ),
            if (loginState.errorMessage != null) ...[
              SizedBox(height: 20),
              Text(
                loginState.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
