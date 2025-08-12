import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasmeat_app/model/profile_model.dart';
import 'package:tasmeat_app/services/authentication_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationService authenticationService;
  ProfileBloc({required this.authenticationService}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await authenticationService.fetchUserProfile();
        if (profile != null) {
          emit(ProfileLoaded(profile: profile));
        } else {
          emit(ProfileError(message: 'فشل جلب بيانات المستخدم'));
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });
  }
}
