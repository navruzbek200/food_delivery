abstract class AuthEvent {
  const AuthEvent();
}

class RegisterEvent extends AuthEvent{
  final String email;
  final String password;

  RegisterEvent({required this.email, required this.password});
}

class ConfirmEmailEvent extends AuthEvent{
  final int code;

  ConfirmEmailEvent({required this.code});
}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class ForgotPasswordEvent extends AuthEvent{
  final String email;

  ForgotPasswordEvent({required this.email});
}

class ResetPasswordEvent extends AuthEvent{
  final String email;
  final String password;

  ResetPasswordEvent({required this.email, required this.password});
}

class ResendCodeEvent extends AuthEvent{
  final String email;

  ResendCodeEvent({required this.email});
}

