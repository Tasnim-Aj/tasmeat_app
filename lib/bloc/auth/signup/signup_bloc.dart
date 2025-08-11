import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasmeat_app/model/signup_model.dart';
import 'package:tasmeat_app/services/authentication_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationService authenticationService;
  SignupBloc({required this.authenticationService}) : super(SignupInitial()) {
    on<SignupRequested>((event, emit) async {
      emit(SignupLoading());
      try {
        final register =
            await authenticationService.register(user: event.signupModel);
        emit(SignupDone());
      } catch (e) {
        emit(SignupError(message: 'Error : $e'));
      }
    });
  }
}
