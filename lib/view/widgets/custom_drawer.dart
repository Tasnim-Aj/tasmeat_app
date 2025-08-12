import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/view/screens/auth/reset_password1_screen.dart';
import 'package:tasmeat_app/view/screens/baqa_screen.dart';
import 'package:tasmeat_app/view/style/app_colors.dart';

import '../../bloc/profile/profile_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        width: 280,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildHeader(context),
                  SizedBox(
                    height: 95,
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.notifications,
                    title: "الإشعارات",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.headphones,
                    title: "باقات التسميع",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BaqaScreen()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 23.r, right: 23.r, top: 40.r, bottom: 40.r),
                    child: Divider(
                      height: 0.5.h,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.key,
                    title: "إعادة تعيين كلمة المرور",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword1Screen()));
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.logout,
                    title: "تسجيل الخروج",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          Container(
            height: 270.h,
            color: AppColors.primary,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        if (state is ProfileError) {
          return Container(
            height: 270.h,
            color: AppColors.primary,
            child: Center(
              child: Text(
                "فشل تحميل البيانات",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        if (state is ProfileLoaded) {
          return Container(
            height: 270.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 53, right: 42),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 33.r,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      'assets/images/profile_user.png',
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.profile.username,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.containerSecondary),
                        ),
                        // SizedBox(
                        //   height: 4.h,
                        // ),
                        Text(
                          state.profile.email,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              letterSpacing: 0.0,
                              height: 1.0,
                              color: Color(0xFFF4F4F4)),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 29.86.h),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 18.r, bottom: 16),
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
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton.icon(
        icon: Icon(Icons.exit_to_app),
        label: Text("تسجيل الخروج"),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
        ),
      ),
    );
  }
}
