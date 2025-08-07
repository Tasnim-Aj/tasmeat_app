import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tasmeat_app/bloc/hadith_bloc.dart';
import 'package:tasmeat_app/services/hadith_service.dart';

import 'view/screens/indexing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HadithBloc(hadithService: HadithService())
              ..add(ViewHadithEvent())),
      ],
      child: MaterialApp(
        home: IndexingScreen(),
      ),
    );
  }
}
