import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:riverpod_with_formz_authentication/state/login_notifier.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: loginNotifier.emailChanged,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText:
                    loginState.email.isNotValid && !loginState.email.isPure
                        ? 'Invalid email'
                        : null,
              ),
            ),
            TextField(
              onChanged: loginNotifier.passwordChanged,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: loginState.password.isNotValid &&
                        !loginState.password.isPure
                    ? 'Password too short'
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  loginState.status.isSuccess ? loginNotifier.login : null,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
