import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasmeat_app/services/hadith_service.dart';
import 'package:tasmeat_app/view/screens/hadith_screen.dart';

import '../../bloc/hadith_bloc.dart';

class IndexingScreen extends StatelessWidget {
  IndexingScreen({super.key});

  HadithService hadithService = HadithService();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                      child: ListTile(
                        // leading: Text(state.hadith[index].id),
                        title: Text(
                          'الحديث ${index + 1}',
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
