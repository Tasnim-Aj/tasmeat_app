import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasmeat_app/model/profile_model.dart';
import 'package:tasmeat_app/model/wallet_model.dart';
import 'package:tasmeat_app/services/authentication_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationService authenticationService;
  ProfileBloc({required this.authenticationService}) : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await authenticationService.fetchUserProfile();
        final wallet = await authenticationService.fetchUserWallet();
        if (profile != null && wallet != null) {
          emit(ProfileLoaded(profile: profile, wallet: wallet));
        } else {
          emit(ProfileError(message: 'فشل جلب بيانات المستخدم'));
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });

    on<ActivatePackageEvent>((event, emit) {
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        final packages = List<Map<String, dynamic>>.from(currentState.packages);
        final package = packages[event.packageIndex];
        final int price = package['price'];
        final int balance = currentState.wallet.balance;

        if (balance >= price) {
          // خصم السعر من الرصيد
          final newBalance = balance - price;

          // تحديث الحزمة (مثلاً إضافة حقل isActive)
          packages[event.packageIndex] = {
            ...package,
            'isActive': true,
          };

          // تحديث المحفظة - لازم توفر طريقة copyWith في WalletModel
          final updatedWallet =
              currentState.wallet.copyWith(balance: newBalance);

          emit(currentState.copyWith(
            wallet: updatedWallet,
            packages: packages,
            message: 'تم تفعيل الباقة بنجاح',
            isSuccess: true,
          ));
        } else {
          emit(currentState.copyWith(
            message: 'عذراً لا يوجد نقاط كافية في حسابك',
            isSuccess: false,
          ));
        }
      }
    });

    //   on<FetchWalletEvent>((event, emit) async {
    //     emit(ProfileLoading());
    //     try {
    //       final wallet = await authenticationService.fetchUserWallet();
    //       if (wallet != null) {
    //         emit(WalletLoaded(wallet: wallet));
    //       } else {
    //         emit(ProfileError(message: 'فشل جلب بيانات المستخدم'));
    //       }
    //     } catch (e) {
    //       emit(ProfileError(message: e.toString()));
    //     }
    //   });
  }
}
