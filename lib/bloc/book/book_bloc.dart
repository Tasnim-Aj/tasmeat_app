import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasmeat_app/model/books_model.dart';
import 'package:tasmeat_app/repo/books_repository/books_repository.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BooksRepository booksRepository;
  BookBloc({required this.booksRepository}) : super(BookInitial()) {
    on<LoadAllBookEvent>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await booksRepository.getAllBooks();
        emit(BookLoaded(books: books));
      } catch (e) {
        print('Error : $e');
        emit(BookError(message: e.toString()));
      }
    });
  }
}
