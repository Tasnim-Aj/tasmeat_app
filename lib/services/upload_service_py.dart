// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// class UploadService {
//   static Future<String?> uploadAndTranscribe(File file) async {
//     const url = 'http://192.168.1.104:5000/transcribe';
//     try {
//       FormData formData = FormData.fromMap({
//         'audio': await MultipartFile.fromFile(file.path, filename: 'audio.m4a'),
//       });
//
//       final dio = Dio(BaseOptions(
//         connectTimeout: Duration(minutes: 2),
//         receiveTimeout: Duration(minutes: 2),
//       ));
//
//       Response res = await Dio().post(url, data: formData);
//       if (res.statusCode == 200) {
//         return res.data['text'] ?? 'لم يتم استخراج نص';
//       } else {
//         return 'خطأ في الاستجابة: ${res.statusCode}';
//       }
//     } catch (e) {
//       print('Error : $e');
//       return 'فشل الاتصال: $e';
//     }
//   }
// }
