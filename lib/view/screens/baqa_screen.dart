import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../style/app_colors.dart';
import '../widgets/custom_drawer.dart';

class BaqaScreen extends StatelessWidget {
  const BaqaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // أول ما الشاشة تبنى، طلب تحميل البروفايل
    context.read<ProfileBloc>().add(FetchProfileEvent());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.h),
          child: Container(
            color: AppColors.primary,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 72.h,
                    leading: Builder(builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(right: 15.r, top: 16.r),
                        child: InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Image.asset(
                            'assets/images/profile_user.png',
                            width: 40.w,
                            height: 40.h,
                            color: Colors.white,
                          ),
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
                                SizedBox(width: 9.w),
                                Image.asset(
                                  'assets/images/headphones.png',
                                  width: 28.w,
                                  height: 28.h,
                                ),
                              ],
                            ),
                            SizedBox(width: 10.w),
                            Row(
                              children: [
                                Text(
                                  state.wallet.balance.toString(),
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                    color: AppColors.containerSecondary,
                                  ),
                                ),
                                SizedBox(width: 9.w),
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
                  );
                }
                return SizedBox();
              },
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
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    if (state.message != null)
                      Container(
                        width: 350.w,
                        height: 220.h,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Color(0xFFE9FCFF),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: state.isSuccess == true
                                ? Colors.green
                                : AppColors.containerPrimary,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 7,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/cloud.png',
                                  width: 150.w,
                                  height: 97.h,
                                ),
                                Image.asset(
                                  state.isSuccess == true
                                      ? 'assets/images/happy.png'
                                      : 'assets/images/sad.png',
                                  width: 60.w,
                                  height: 60.h,
                                ),
                              ],
                            ),
                            Text(
                              state.message!,
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: state.isSuccess == true
                                    ? Colors.green
                                    : AppColors.primary,
                              ),
                            ),
                            if (state.isSuccess != true)
                              Container(
                                alignment: Alignment.center,
                                width: 160.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF34B2C4),
                                      Color(0xFF088A9D),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      offset: const Offset(0, 4),
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'شراء نقاط',
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.containerSecondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    SizedBox(height: 20.h),
                    ...state.packages.asMap().entries.map((entry) {
                      final index = entry.key;
                      final pkg = entry.value;
                      return packageCard(
                        bookName: pkg['bookName'],
                        sessionsCount: pkg['sessionsCount'],
                        price: pkg['price'],
                        onActivate: () {
                          context
                              .read<ProfileBloc>()
                              .add(ActivatePackageEvent(index));
                        },
                      );
                    }),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Widget packageCard({
  required String bookName,
  required int sessionsCount,
  required int price,
  required void Function() onActivate,
}) {
  return Container(
    margin: EdgeInsets.only(left: 20.r, right: 20.r, bottom: 15.r),
    padding: EdgeInsets.only(right: 29.r, left: 10.3.r),
    width: 350.w,
    height: 198.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFF9FCAD7), width: 2),
      color: const Color(0xFFE9FCFF),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 7,
          color: Colors.black.withOpacity(0.12),
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.h),
            Row(
              children: [
                Text(
                  '$sessionsCount',
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '  تسميعة  ب ',
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '$price',
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
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
            SizedBox(height: 20.h),
            Row(
              children: [
                Image.asset(
                  'assets/images/book.png',
                  width: 18.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  bookName,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.primary,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: onActivate,
              child: Container(
                margin: EdgeInsets.only(top: 24.r),
                alignment: Alignment.center,
                width: 160.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF34B2C4),
                      Color(0xFF088A9D),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Text(
                  'تفعيل الباقة',
                  style: GoogleFonts.cairo(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.containerSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                child: Image.asset(
                  'assets/images/frame.png',
                  width: 128.97.w,
                  height: 171.24.h,
                ),
              ),
              Positioned(
                top: 29.19.r,
                left: 25.19.r,
                child: Transform.rotate(
                  angle: 23.11 * (pi / 180),
                  child: Image.asset(
                    'assets/images/headphones.png',
                    width: 50.w,
                    height: 50.h,
                  ),
                ),
              ),
              Positioned(
                bottom: 19.r,
                left: 24.r,
                child: Image.asset(
                  'assets/images/stack_of_book.png',
                  width: 80,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
