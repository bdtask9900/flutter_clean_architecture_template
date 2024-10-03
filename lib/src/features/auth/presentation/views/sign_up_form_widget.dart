import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/sing_up.notifier.dart';

class SignUpFormWidget extends HookConsumerWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize TextEditingControllers with hooks
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    // Watch the signUp state
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    // Handle Form Submission
    void submitForm() {
      final email = emailController.text;
      final username = usernameController.text;
      final password = passwordController.text;

      // Trigger the sign-up process
      signUpNotifier.signUp(email, username, password);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            signUpState.isSubmitting
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: signUpState.isSubmitting ? null : submitForm,
                    child: Text('Sign Up'),
                  ),
            if (signUpState.errorMessage != null) ...[
              SizedBox(height: 20),
              Text(
                signUpState.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
