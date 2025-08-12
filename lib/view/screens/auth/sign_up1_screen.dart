import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasmeat_app/model/signup_model.dart';
import 'package:tasmeat_app/view/screens/auth/login_screen.dart';
import 'package:tasmeat_app/view/style/app_theme.dart';

import '../../../bloc/auth/signup/signup_bloc.dart';
import '../../style/app_colors.dart';

class SignUp1Screen extends StatelessWidget {
  SignUp1Screen({super.key});
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme.of(context).authContainer(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.r, bottom: 49.r),
                      child: Text(
                        'إنشاء حساب',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Column(
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
                              controller: usernameController,
                              keyboardType: TextInputType.name,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 17.87,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'البريد الإلكتروني',
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 17.87,
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
                              // keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 33.87,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'منتسب لمعهد ما ؟',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            width: 21.w,
                          ),
                          Text(
                            'إدخال الرمز الخاص',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.r),
                      child: BlocConsumer<SignupBloc, SignupState>(
                        listener: (context, state) {
                          if (state is SignupDone) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                          if (state is SignupError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SignupLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              final signupModel = SignupModel(
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              context.read<SignupBloc>().add(
                                  SignupRequested(signupModel: signupModel));
                            },
                            child: Text('انشاء حساب'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
