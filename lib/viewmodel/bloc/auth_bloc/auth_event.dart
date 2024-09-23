abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String displayName;
  final String phoneNumber;
  final String email;
  final String password;

  SignUpEvent(
    this.displayName,
    this.phoneNumber,
    this.email,
    this.password,
  );
}
