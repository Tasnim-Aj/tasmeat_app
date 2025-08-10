import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/view/style/app_colors.dart';

ThemeData themeData = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        textStyle: GoogleFonts.cairo(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.containerSecondary,
          letterSpacing: 0.0,
          height: 1.0,
        ),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.containerSecondary,
      labelStyle: GoogleFonts.cairo(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        letterSpacing: 0.0,
        height: 0.35,
        color: AppColors.textSecondary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.textSecondary,
        ),
      ),
      contentPadding: EdgeInsets.only(left: 25.r, right: 25.r, top: 59.87.r),
    ),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.cairo(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.primary,
    )));

extension CustomTheme on ThemeData {
  Container get authContainerDecoration => Container(
        margin: EdgeInsets.only(left: 20.r, right: 20.r, top: 60.r),
        width: 350.w,
        height: 700.h,
        decoration: BoxDecoration(
          color: AppColors.containerSecondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.12),
            ),
          ],
        ),
      );
  // BoxDecoration(
  //   color: AppColors.primary,
  //   borderRadius: BorderRadius.circular(10),
  //   boxShadow: [
  //     BoxShadow(
  //       offset: const Offset(0, 4),
  //       blurRadius: 10,
  //       color: Colors.black.withOpacity(0.12),
  //     ),
  //   ],
  // );
}
