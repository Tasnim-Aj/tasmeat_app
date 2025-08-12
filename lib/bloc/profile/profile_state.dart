part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  final WalletModel wallet;
  final List<Map<String, dynamic>> packages;
  final String? message;
  final bool? isSuccess;

  ProfileLoaded({
    required this.profile,
    required this.wallet,
    this.packages = const [
      {'bookName': 'كتاب رياض الصالحين', 'sessionsCount': 80, 'price': 500},
      {'bookName': 'كتاب صحيح البخاري', 'sessionsCount': 120, 'price': 800},
      {'bookName': 'كتاب رياض الصالحين', 'sessionsCount': 80, 'price': 1300},
    ],
    this.message,
    this.isSuccess,
  });

  ProfileLoaded copyWith({
    String? message,
    bool? isSuccess,
    WalletModel? wallet,
    List<Map<String, dynamic>>? packages,
    ProfileModel? profile,
  }) {
    return ProfileLoaded(
      wallet: wallet ?? this.wallet,
      packages: packages ?? this.packages,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
      profile: profile ?? this.profile,
    );
  }
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}
