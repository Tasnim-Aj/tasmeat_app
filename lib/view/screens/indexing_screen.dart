import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/services/hadith_service.dart';
import 'package:tasmeat_app/view/screens/hadith_screen.dart';
import 'package:tasmeat_app/view/style/app_colors.dart';

import '../../bloc/hadith_bloc.dart';

class IndexingScreen extends StatelessWidget {
  IndexingScreen({super.key});

  HadithService hadithService = HadithService();

  @override
  Widget build(BuildContext context) {
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
              leading: Padding(
                padding: EdgeInsets.only(right: 15.r, top: 16.r),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/profile_user.png',
                      width: 40.w,
                      height: 40.h,
                      color: Colors.white,
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
              ),
              title: Text(
                'الأربعون النووية',
                style: GoogleFonts.cairo(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 0.47.sp,
                  letterSpacing: 0,
                  color: AppColors.title,
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<HadithBloc, HadithState>(
          builder: (context, state) {
            if (state is HadithError) {
              return Center(child: Text(state.message));
            }
            if (state is HadithLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is HadithLoaded) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 38),
                  itemCount: state.hadith.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HadithScreen(
                                      hadith: state.hadith[index],
                                    )));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.only(top: 14.r, left: 10.r, right: 10.r),
                        width: 370.w,
                        height: 59.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9FCFF),
                          border: Border.all(
                            width: 1,
                            color: AppColors.containerPrimary,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'الحديث ${index + 1}',
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              height: 1,
                              letterSpacing: 0.0,
                              color: AppColors.primary),
                        ),
                      ),
                    );
                  });
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
