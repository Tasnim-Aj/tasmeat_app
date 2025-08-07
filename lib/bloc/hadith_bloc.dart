import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasmeat_app/model/hadith_model.dart';
import 'package:tasmeat_app/services/hadith_service.dart';

part 'hadith_event.dart';
part 'hadith_state.dart';

class HadithBloc extends Bloc<HadithEvent, HadithState> {
  final HadithService hadithService;
  HadithBloc({required this.hadithService}) : super(HadithInitial()) {
    on<ViewHadithEvent>((event, emit) async {
      emit(HadithLoading());
      try {
        final hadithList = await hadithService.getHadith();
        emit(HadithLoaded(hadith: hadithList));
      } catch (e) {
        emit(HadithError(message: e.toString()));
      }
    });
  }
}
