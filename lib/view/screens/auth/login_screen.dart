import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasmeat_app/bloc/auth/login/login_bloc.dart';
import 'package:tasmeat_app/model/login_request.dart';
import 'package:tasmeat_app/view/screens/auth/reset_password1_screen.dart';
import 'package:tasmeat_app/view/style/app_theme.dart';

import '../../style/app_colors.dart';
import '../types_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(52.h),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.25),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Theme.of(context).authContainer(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.r, bottom: 138.r),
                    child: Text(
                      'تسجيل الدخول',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    height: 209.13.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الاسم',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    decoration: TextDecoration.none,
                                  ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            TextField(
                              keyboardType: TextInputType.text,
                              controller: usernameController,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'كلمة المرور',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    decoration: TextDecoration.none,
                                  ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              // keyboardType: Tex,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 129.87, bottom: 44),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'نسيت كلمة المرور ؟',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResetPassword1Screen()));
                          },
                          child: Text(
                            'إعادة تعيين كلمة المرور',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.r),
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TypesScreen()));
                        }
                        if (state is LoginError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        bool isLoading = state is LoginLoading;
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => onLoginButtonPressed(context),
                          child: isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text('تسجيل الدخول'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLoginButtonPressed(BuildContext context) {
    final loginRequest = LoginRequest(
      username: usernameController.text,
      password: passwordController.text,
    );
    context.read<LoginBloc>().add(LoginRequested(loginRequest: loginRequest));
  }
}
