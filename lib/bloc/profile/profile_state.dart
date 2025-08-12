part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  final WalletModel wallet;
  ProfileLoaded({required this.profile, required this.wallet});
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}

// final class WalletLoaded extends ProfileState {
//   final WalletModel wallet;
//   WalletLoaded({required this.wallet});
// }
