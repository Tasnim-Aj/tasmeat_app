import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tasmeat_app/model/books_model.dart';

import '../../services/books_service.dart';

class BooksRepository {
  final BooksService remoteService;

  BooksRepository(this.remoteService);

  Future<List<BooksModel>> getRemoteBooks() async {
    return await remoteService.getAllBooks();
  }

  Future<List<BooksModel>> getLocalBooks() async {
    final String response =
        await rootBundle.loadString('assets/data/arbain_nawawi.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((e) => BooksModel.fromMap(e)).toList();
  }

  Future<List<BooksModel>> getAllBooks() async {
    final localBooks = await getLocalBooks();
    final remoteBooks = await getRemoteBooks();
    return [...localBooks, ...remoteBooks];
  }
}
