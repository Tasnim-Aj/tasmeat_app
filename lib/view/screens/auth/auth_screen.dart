import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/view/screens/auth/authentication_screen.dart';
import 'package:tasmeat_app/view/style/app_colors.dart';
import 'package:tasmeat_app/view/style/app_theme.dart';

import '../types_screen.dart';
import 'login_screen.dart';
import 'sign_up1_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
                      'جاهز لتعلم المزيد ؟',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.r),
                    child: Image.asset(
                      'assets/images/login.gif',
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 62.r, bottom: 26.r),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp1Screen()));
                      },
                      child: Text('إنشاء حساب'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب بالفعل؟',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: 21.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'تسجيل دخول',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.93.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 0.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: Color(0xFFAAAAAA),
                          )),
                        ),
                        Text(
                          'أو ',
                          style: GoogleFonts.cairo(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: 0.0),
                        ),
                        Container(
                          width: 100.w,
                          height: 0.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: Color(0xFFAAAAAA),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.r, bottom: 26.r),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.containerSecondary,
                            foregroundColor: AppColors.primary,
                            side: BorderSide(
                              color: AppColors.primary,
                              width: 1.w,
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TypesScreen()));
                        },
                        child: Text(
                          'تصفح التطبيق',
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'منتسب لمعهد ما ؟',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: 21.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AuthenticationScreen()));
                        },
                        child: Text(
                          'إدخال الرمز الخاص',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
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
