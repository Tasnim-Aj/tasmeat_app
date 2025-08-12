part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class LoadAllBookEvent extends BookEvent {}
