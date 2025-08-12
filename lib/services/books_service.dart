import 'package:dio/dio.dart';
import 'package:tasmeat_app/model/books_model.dart';

import '../model/hadiths_model.dart';

class BooksService {
  Dio dio = Dio();
  late Response response;
  String baseUrl = 'https://alhekmah-server-side.onrender.com/books';

  Future<List<BooksModel>> getAllBooks() async {
    try {
      response = await dio.get(baseUrl);
      return (response.data as List).map((e) => BooksModel.fromMap(e)).toList();
      // }
      // return book;
    }
    // try {
    //   response = await dio.get(baseUrl);
    //   List<BooksModel> books = [];
    //   for (int i = 0; i < response.data['hadiths'].length; i++) {
    //     books.add(BooksModel.fromMap(response.data['hadiths'][i]));
    //   }
    //   return books;
    // }
    catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  Future<List<HadithsModel>> getAllHadiths(int bookId) async {
    try {
      final url = '$baseUrl/$bookId/hadiths';
      response = await dio.get(url);
      return (response.data as List)
          .map((e) => HadithsModel.fromMap(e))
          .toList();
    } catch (e) {
      print('Error fetching hadiths: $e');
      return [];
    }
  }

  // Future<List<HadithsModel>> getAllHadiths(int bookId) async {
  //   try {
  //     response = await dio.get('$baseUrl/bookId/hadiths');
  //     List<HadithsModel> hadiths = [];
  //     for (int i = 0; i < response.data['hadiths'].length; i++) {
  //       hadiths.add(HadithsModel.fromMap(response.data['hadiths'][i]));
  //     }
  //     return hadiths;
  //   } catch (e) {
  //     print('Error fetching books: $e');
  //     return [];
  //   }
  // }
}
