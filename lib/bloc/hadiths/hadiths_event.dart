part of 'hadiths_bloc.dart';

@immutable
sealed class HadithsEvent {}

class LoadedAllHadiths extends HadithsEvent {
  final int bookId;

  LoadedAllHadiths({required this.bookId});
}
