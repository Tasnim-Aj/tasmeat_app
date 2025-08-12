import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tasmeat_app/model/hadiths_model.dart';

import '../../services/books_service.dart';

class HadithsRepository {
  final BooksService remoteService;

  HadithsRepository(this.remoteService);

  Future<List<HadithsModel>> getRemoteHadiths(int bookId) async {
    return await remoteService.getAllHadiths(bookId);
  }

  Future<List<HadithsModel>> getLocalHadiths(int bookId) async {
    final String response =
        await rootBundle.loadString('assets/data/arbain_nawawi.json');
    final List<dynamic> data = jsonDecode(response);

    final book = data.firstWhere(
      (book) => book['id'] == bookId,
      orElse: () => null,
    );

    if (book == null) return [];

    final List<dynamic> hadithsJson = book['hadiths'] ?? [];
    return hadithsJson.map((e) => HadithsModel.fromMap(e)).toList();
  }

  Future<List<HadithsModel>> getAllHadiths(int bookId) async {
    final localHadiths = await getLocalHadiths(bookId);
    final remoteHadiths = await getRemoteHadiths(bookId);
    return [...localHadiths, ...remoteHadiths];
  }
}
