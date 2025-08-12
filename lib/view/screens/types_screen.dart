import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/bloc/book/book_bloc.dart';
import 'package:tasmeat_app/view/style/app_colors.dart';

import '../widgets/custom_drawer.dart';
import 'indexing_screen.dart';

class TypesScreen extends StatelessWidget {
  const TypesScreen({super.key});

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
              title: Text(
                'المقررات',
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
        drawer: Padding(
          padding: EdgeInsets.only(top: 47.r),
          child: Drawer(
            width: 298.w,
            backgroundColor: AppColors.containerSecondary,
            child: CustomDrawer(),
          ),
        ),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookLoaded) {
              return ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IndexingScreen(
                                  bookId: book.id,
                                )),
                      );
                    },
                    child: _buildBookItem(
                      book.title,
                      // book.hadiths.length.toString(),
                    ),
                  );
                },
              );
            } else if (state is BookError) {
              return Center(child: Text('خطأ: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Widget _buildBookItem(
  String title,
  // String number,
) {
  return Container(
    margin: EdgeInsets.all(16.r),
    width: 300.w,
    height: 160.h,
    decoration: BoxDecoration(
      color: Color(0xFFE9FCFF),
      border: Border.all(width: 1.w, color: Color(0xFF9FCAD7)),
    ),
    child: Stack(
      children: [
        // Padding(
        //   padding: EdgeInsets.only(right: 116.r, top: 47.r),
        //   child: Text(
        //     number,
        //     style: GoogleFonts.cairo(
        //         fontSize: 110.sp,
        //         fontWeight: FontWeight.w700,
        //         height: 0.47,
        //         color: AppColors.primary),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(right: 40.r, top: 53.61.r),
          child: Text(
            title,
            style: GoogleFonts.cairo(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                height: 42 / 20,
                color: AppColors.primary),
          ),
        ),
      ],
    ),
  );
}
