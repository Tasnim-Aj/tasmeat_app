part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupDone extends SignupState {}

class SignupError extends SignupState {
  final String message;
  SignupError({required this.message});
}
