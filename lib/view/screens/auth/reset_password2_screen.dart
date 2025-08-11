import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasmeat_app/view/screens/auth/reset_password3_screen.dart';
import 'package:tasmeat_app/view/style/app_theme.dart';

import '../../style/app_colors.dart';

class ResetPassword2Screen extends StatelessWidget {
  const ResetPassword2Screen({super.key});

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
                    padding:
                        EdgeInsets.only(right: 25.r, top: 111.r, bottom: 34.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'أدخل رمز التحقق الذي تم إرساله',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    decoration: TextDecoration.none,
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        Text(
                          'رمز التحقق',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  decoration: TextDecoration.none,
                                  color: AppColors.textSecondary,
                                  fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 42.86.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.textSecondary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text('7'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لم يصلك الرمز ؟ ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ResetPassword1Screen()));
                          },
                          child: Text(
                            ' إرسال مرة أخرى',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.r),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword3Screen()));
                      },
                      child: Text('تحقق'),
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
