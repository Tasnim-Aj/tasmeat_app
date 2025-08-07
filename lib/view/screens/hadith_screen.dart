import 'package:flutter/material.dart';
import 'package:tasmeat_app/model/hadith_model.dart';

class HadithScreen extends StatelessWidget {
  final HadithModel hadith;
  HadithScreen({super.key, required this.hadith});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(hadith.text),
        ),
      ),
    );
  }
}
