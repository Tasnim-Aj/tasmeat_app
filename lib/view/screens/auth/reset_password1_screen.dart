import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasmeat_app/view/screens/auth/reset_password2_screen.dart';
import 'package:tasmeat_app/view/style/app_theme.dart';

import '../../style/app_colors.dart';

class ResetPassword1Screen extends StatelessWidget {
  const ResetPassword1Screen({super.key});

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
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.r),
                    child: Text(
                      'إعادة تعيين كلمة المرور',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.r),
                    child: Image.asset(
                      'assets/images/forgot_password.gif',
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 38.0.r, right: 33.r, top: 16.r, bottom: 42.r),
                    child: Text(
                      'سنرسل لبريدك الإلكتروني رمز تحقق  من 6 خانات',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.none,
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'البريد الإلكتروني',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.none,
                            ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'youruser123@gmail.com',
                          hintStyle:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                    decoration: TextDecoration.none,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 144.87.r, bottom: 20.r),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword2Screen()));
                      },
                      child: Text('إرسال الرمز '),
                    ),
                  ),
                ],
              ),
            ),

            //
          ],
        ),
      ),
    );
  }
}
