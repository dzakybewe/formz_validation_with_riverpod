import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:riverpod_with_formz_authentication/state/login_state.dart';
import 'package:riverpod_with_formz_authentication/validation/email_validation.dart';
import 'package:riverpod_with_formz_authentication/validation/password_validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      status: Formz.validate([email, state.password])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      status: Formz.validate([state.email, password])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    );
  }

  Future<void> login() async {
    if (state.status.isSuccess) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', state.email.value);

      state = state.copyWith(isLoggedIn: true);
      debugPrint('Login Success: ${state.email.value} ${state.password.value}');
    }
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final email = prefs.getString('email') ?? '';
    state = state.copyWith(
      isLoggedIn: isLoggedIn,
      email: email.isNotEmpty ? Email.dirty(email) : null,
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');

    state = state.copyWith(
      isLoggedIn: false,
      email: const Email.pure(),
      password: const Password.pure(),
      status: FormzSubmissionStatus.initial,
    );
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
