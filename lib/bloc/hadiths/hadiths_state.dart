part of 'hadiths_bloc.dart';

@immutable
sealed class HadithsState {}

final class HadithsInitial extends HadithsState {}

final class HadithsLoading extends HadithsState {}

final class HadithsLoaded extends HadithsState {
  final List<HadithsModel> hadiths;

  HadithsLoaded({required this.hadiths});
}

final class HadithsError extends HadithsState {
  final String message;

  HadithsError({required this.message});
}
