part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginRequested extends LoginEvent {
  final LoginRequest loginRequest;
  LoginRequested({required this.loginRequest});
}

class LogoutRequested extends LoginEvent {}
