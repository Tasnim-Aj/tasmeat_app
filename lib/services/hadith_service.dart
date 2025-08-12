// import 'package:dio/dio.dart';
// import 'package:tasmeat_app/model/hadith_model.dart';
//
// class HadithService {
//   Dio dio = Dio();
//   String baseUel = 'https://6894cf05be3700414e14968a.mockapi.io/hadith';
//   late Response response;
//
//   Future<List<HadithModel>> getHadith() async {
//     try {
//       response = await dio.get(baseUel);
//       List<HadithModel> hadith = [];
//       for (int i = 0; i < response.data.length; i++) {
//         hadith.add(HadithModel.fromMap(response.data[i]));
//       }
//       return hadith;
//     } catch (e) {
//       return [];
//     }
//   }
// }
