import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasmeat_app/model/login_response.dart';
import 'package:tasmeat_app/services/authentication_service.dart';

import '../../../model/login_request.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;
  LoginBloc({required this.authenticationService}) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await authenticationService.login(event.loginRequest);

        if (response != null) {
          emit(LoginSuccess(loginResponse: response));
        } else {
          emit(LoginError(error: "فشل تسجيل الدخول"));
        }
      } catch (e) {
        emit(LoginError(error: e.toString()));
      }
    });
  }
}
