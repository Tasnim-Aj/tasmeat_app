part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class ActivatePackageEvent extends ProfileEvent {
  final int packageIndex;
  ActivatePackageEvent(this.packageIndex);
}

// class FetchWalletEvent extends ProfileEvent {}
