import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasmeat_app/bloc/auth/signup/signup_bloc.dart';
import 'package:tasmeat_app/bloc/hadith_bloc.dart';
import 'package:tasmeat_app/services/authentication_service.dart';
import 'package:tasmeat_app/services/hadith_service.dart';
import 'package:tasmeat_app/view/style/app_theme.dart';

import 'config/config.dart';
import 'view/screens/auth/auth_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await GoogleFonts.pendingFonts([GoogleFonts()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => HadithBloc(hadithService: HadithService())
                  ..add(ViewHadithEvent())),
            BlocProvider(
                create: (context) =>
                    SignupBloc(authenticationService: AuthenticationService()))
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            home: AuthScreen(),
          ),
        );
      },
    );
  }
}
