import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasmeat_app/model/login_request.dart';
import 'package:tasmeat_app/model/login_response.dart';
import 'package:tasmeat_app/model/profile_model.dart';
import 'package:tasmeat_app/model/signup_model.dart';
import 'package:tasmeat_app/model/wallet_model.dart';

class AuthenticationService {
  Dio dio = Dio();
  late Response response;
  String baseUrl = 'https://alhekmah-server-side.onrender.com';

  Future<void> register({required SignupModel user}) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/register',
        data: user.toMap(),
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  AuthenticationService() {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('access_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // محاولة تجديد التوكين
            final refreshed = await _refreshToken();
            if (refreshed) {
              // إعادة المحاولة بعد تحديث التوكين
              final prefs = await SharedPreferences.getInstance();
              final newToken = prefs.getString('access_token');
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';

              final retryResponse = await dio.fetch(e.requestOptions);
              return handler.resolve(retryResponse);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');

      if (refreshToken == null) return false;

      final response = await dio.post(
        '$baseUrl/auth/refresh',
        data: {"refresh_token": refreshToken},
      );

      final newTokens = LoginResponse.fromMap(response.data);
      await prefs.setString('access_token', newTokens.access_token);
      await prefs.setString('refresh_token', newTokens.refresh_token);

      return true;
    } catch (e) {
      print("فشل تحديث التوكين: $e");
      return false;
    }
  }

  Future<LoginResponse?> login(LoginRequest user) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: user.toMap(),
      );

      final loginResponse = LoginResponse.fromMap(response.data);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', loginResponse.access_token);
      await prefs.setString('refresh_token', loginResponse.refresh_token);

      return loginResponse;
    } on DioException catch (e) {
      if (e.response != null) {
        print("خطأ من السيرفر: ${e.response?.data}");
      } else {
        print("خطأ في الاتصال: ${e.message}");
      }
      return null;
    }
  }

  Future<ProfileModel?> fetchUserProfile() async {
    try {
      final response = await dio.get('$baseUrl/user/profile');
      if (response.statusCode == 200) {
        return ProfileModel.fromMap(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<WalletModel?> fetchUserWallet() async {
    try {
      final response = await dio.get('$baseUrl/user/wallet');
      if (response.statusCode == 200) {
        return WalletModel.fromMap(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Future<WalletModel?> fetchUserWallet() async {
  //   try {
  //     final response = await dio.get('$baseUrl/user/wallet');
  //     if (response.statusCode == 200) {
  //       return WalletModel.fromMap(response.data);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future<ProfileModel?> fetchUserProfile(String token) async {
  //   try {
  //     response = await dio.get('$baseUrl/user/profile',
  //         options: Options(headers: {
  //           'Authorization': 'Bearer $token',
  //         }));
  //     if (response.statusCode == 200) {
  //       return ProfileModel.fromMap(response.data);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
