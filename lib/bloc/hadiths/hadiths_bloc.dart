import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasmeat_app/model/hadiths_model.dart';
import 'package:tasmeat_app/repo/hadiths_repository.dart';

part 'hadiths_event.dart';
part 'hadiths_state.dart';

class HadithsBloc extends Bloc<HadithsEvent, HadithsState> {
  final HadithsRepository hadithsRepository;
  HadithsBloc({required this.hadithsRepository}) : super(HadithsInitial()) {
    on<LoadedAllHadiths>((event, emit) async {
      emit(HadithsLoading());
      try {
        final hadiths = await hadithsRepository.getAllHadiths(event.bookId);
        emit(HadithsLoaded(hadiths: hadiths));
      } catch (e) {
        print('Error : $e');
        emit(HadithsError(message: e.toString()));
      }
    });
  }
}
