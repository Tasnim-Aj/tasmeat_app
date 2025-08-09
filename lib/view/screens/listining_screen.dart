import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/view/screens/recordScreen.dart';
import 'package:tasmeat_app/view/widgets/audio_player.dart';

import '../../model/hadith_model.dart';
import '../style/app_colors.dart';

class ListiningScreen extends StatelessWidget {
  ListiningScreen({super.key, required this.hadith});
  final HadithModel hadith;

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
                hadith.title,
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 31.r, right: 29.r),
              child: Row(
                children: [
                  Image.asset('assets/images/caution.png', width: 25.w),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'سمّع الحديث النبوي !',
                    style: GoogleFonts.almarai(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      height: 1,
                      letterSpacing: 0.0,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(
                    width: 66.w,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 74.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.containerSecondary,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.12),
                            offset: Offset(
                              0,
                              3,
                            ),
                            blurRadius: 7,
                            spreadRadius: 0,
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '150',
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            // height: 0.47.sp,
                            letterSpacing: 0,
                            color: AppColors.orange,
                          ),
                        ),
                        Image.asset(
                          'assets/images/feathers.png',
                          width: 18.sp,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 23.r, left: 14.r, right: 14.r),
              width: 362.w,
              height: 60.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.containerSecondary,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.15),
                      offset: Offset(
                        0,
                        4,
                      ),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ]),
              child: Text(
                'عَنْ أَمِيرِ المُؤمِنينَ أَبي حَفْصٍ عُمَرَ بْنِ الخَطَّابِ',
                style: GoogleFonts.aladin(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  height: 0.47.sp,
                  letterSpacing: 0,
                  color: AppColors.green,
                ),
              ),
            ),
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(top: 11.r, left: 14.r, right: 14.r),
              padding: EdgeInsets.only(top: 19.r, left: 20.r, right: 20.r),
              width: 362.w,
              height: 324.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.containerSecondary,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.15),
                      offset: Offset(
                        0,
                        4,
                      ),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ]),
              child: Text(
                '''
                 قَالَ : سَمِعْتُ رَسُولَ اللهِ ﷺ يَقُولُ : " إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ ، وَإنَّمَا لِكُلِّ امْرِىءٍ مَا نَوَى ، فَمَنْ كَانَتْ هِجْرَتُهُ إِلى اللهِ وَرَسُوله فَهِجْرتُهُ إلى اللهِ وَرَسُوُله ، وَمَنْ كَانَتْ هِجْرَتُهُ لِدُنْيَا يُصِيْبُهَا  أو مرأة  ينكحها فهجرته إلى ما هاجر إليه
                ''',
                style: GoogleFonts.aladin(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  height: 47 / 18,
                  letterSpacing: 0,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 33.r, right: 30.r),
                  width: 160.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFBBBBBB),
                  ),
                  child: Text(
                    'عرض النتيجة',
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      height: 0.47.sp,
                      letterSpacing: 0,
                      color: AppColors.title,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            AudioPlayerSection(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: 390.w,
              height: 64.h,
              decoration: BoxDecoration(color: AppColors.primary, boxShadow: [
                BoxShadow(
                  color: Color(0xFF000000).withOpacity(0.15),
                  offset: Offset(
                    2,
                    3,
                  ),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ]),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.containerSecondary,
                          size: 16.sp,
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        Text(
                          'التالي',
                          style: GoogleFonts.aladin(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.47.sp,
                            letterSpacing: 0,
                            color: AppColors.containerSecondary,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecordScreen(
                                      hadith: hadith,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mic,
                            color: AppColors.containerSecondary,
                            size: 16.sp,
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Text(
                            'تسميع',
                            style: GoogleFonts.aladin(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 0.47.sp,
                              letterSpacing: 0,
                              color: AppColors.containerSecondary,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 75.w,
                      color: Color(0xFF076A78),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.headphones,
                            color: AppColors.containerSecondary,
                            size: 16.sp,
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Text(
                            'استماع',
                            style: GoogleFonts.aladin(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 0.47.sp,
                              letterSpacing: 0,
                              color: AppColors.containerSecondary,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.containerSecondary,
                          size: 16.sp,
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        Text(
                          'السابق',
                          style: GoogleFonts.aladin(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.47.sp,
                            letterSpacing: 0,
                            color: AppColors.containerSecondary,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
