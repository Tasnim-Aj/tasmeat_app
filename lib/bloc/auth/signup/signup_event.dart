part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupRequested extends SignupEvent {
  final SignupModel signupModel;

  SignupRequested({required this.signupModel});
}
