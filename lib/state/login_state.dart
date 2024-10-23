import 'package:formz/formz.dart';
import 'package:riverpod_with_formz_authentication/validation/email_validation.dart';
import 'package:riverpod_with_formz_authentication/validation/password_validation.dart';

class LoginState {
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isLoggedIn;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isLoggedIn = false,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isLoggedIn,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

