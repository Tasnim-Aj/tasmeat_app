import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../style/app_colors.dart';
import '../widgets/custom_drawer.dart';

class BaqaScreen extends StatelessWidget {
  const BaqaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(FetchProfileEvent());
    });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.h),
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
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 72.h,
              leading: Builder(builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(right: 15.r, top: 16.r),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Image.asset(
                          'assets/images/profile_user.png',
                          width: 40.w,
                          height: 40.h,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 11.w,
                          height: 11.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              actions: [
                Padding(
                  padding: EdgeInsets.only(left: 18.r),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            '80',
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: AppColors.containerSecondary,
                            ),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Image.asset(
                            'assets/images/headphones.png',
                            width: 28.w,
                            height: 28.h,
                          ),
                        ],
                      ),
                      Transform.rotate(
                        angle: 90 * (pi / 180),
                        child: Container(
                          width: 30.w,
                          height: 0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Color(0xFF9FCAD7))),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '150',
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: AppColors.containerSecondary,
                            ),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Image.asset(
                            'assets/images/feathers.png',
                            width: 22.17.w,
                            height: 30.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: Padding(
          padding: EdgeInsets.only(top: 47.r),
          child: Drawer(
            width: 298.w,
            backgroundColor: AppColors.containerSecondary,
            child: CustomDrawer(),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20.r, right: 20.r, top: 40.r),
          padding: EdgeInsets.only(
            right: 29.r,
            left: 10.3.r,
          ),
          width: 350.w,
          height: 198.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xFF9FCAD7), width: 2),
              color: Color(0xFFE9FCFF),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 7,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.12),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '80',
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.0,
                          height: 30 / 18,
                          decoration: TextDecoration.underline,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '  تسميعة  ب ',
                        style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.0,
                            height: 30 / 18,
                            color: AppColors.primary),
                      ),
                      Text(
                        '500',
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.0,
                          height: 30 / 18,
                          color: AppColors.orange,
                        ),
                      ),
                      Image.asset(
                        'assets/images/feathers.png',
                        width: 27.02.w,
                        height: 30.h,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/book.png',
                        width: 18.w,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        'كتاب رياض الصالحين',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          letterSpacing: 0.0,
                          height: 30 / 16,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 24.r,
                        ),
                        alignment: Alignment.center,
                        width: 160.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color(0xFF34B2C4),
                              Color(0xFF088A9D),
                            ]),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF000000).withOpacity(0.15),
                                  offset: Offset(0, 4),
                                  blurRadius: 7,
                                  spreadRadius: 0),
                            ]),
                        child: Text(
                          'تفعيل الباقة',
                          style: GoogleFonts.cairo(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.0,
                              // height: 47 / 15,
                              color: AppColors.containerSecondary),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: 29.19.r,
                      left: 25.19.r,
                      child: Transform.rotate(
                        angle: 23.11 * (pi / 180),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Blob.random(
                            //   size: 80,
                            //   styles: BlobStyles(
                            //     color: Colors.red,
                            //     strokeWidth: 3,
                            //   ),
                            // ),

                            Positioned(
                              bottom: -2.r,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 4.r,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 4.r,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/images/headphones.png',
                              width: 50.r,
                              height: 50.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 99.r,
                      left: 24.r,
                      child: Image.asset('assets/images/stack_of_book.png',
                          width: 80),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
