import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/view/style/app_colors.dart';

ThemeData themeData = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(312.w, 54.h),
      alignment: Alignment.center,
      textStyle: GoogleFonts.cairo(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.0,
      ),
      foregroundColor: AppColors.containerSecondary,
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
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        width: 1.r,
        color: AppColors.textSecondary,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: AppColors.textSecondary,
        width: 1.5.r,
      ),
    ),
    constraints: BoxConstraints(
      minHeight: 47.13.h,
      maxWidth: 300.w,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.cairo(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.primary,
    ),
    bodyMedium: GoogleFonts.cairo(
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      height: 1.0,
      letterSpacing: 0.0,
      color: Color(0xFF4D4D4D),
    ),
    bodySmall: GoogleFonts.cairo(
        fontWeight: FontWeight.w400,
        fontSize: 17.sp,
        height: 1.0,
        letterSpacing: 0.0,
        color: AppColors.red,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.red),
  ),
);

extension CustomTheme on ThemeData {
  Container authContainer({required Widget child}) => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: 20.r, right: 20.r,
          // top: 60.r,
        ),
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
        child: child,
      );
}
