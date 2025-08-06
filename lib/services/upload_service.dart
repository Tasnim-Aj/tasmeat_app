import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UploadService {
  static String apiKey = dotenv.env['ASSEMBLYAI_API_KEY']!;
  static const String uploadUrl = "https://api.assemblyai.com/v2/upload";
  static const String transcriptUrl =
      "https://api.assemblyai.com/v2/transcript";

  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'authorization': apiKey,
      },
    ),
  );

  /// 1. رفع الملف الصوتي
  Future<String?> uploadAudioFile(String filePath) async {
    try {
      final file = File(filePath);
      final fileBytes = await file.readAsBytes();

      final response = await _dio.post(
        uploadUrl,
        data: Stream.fromIterable(fileBytes.map((e) => [e])),
        options: Options(
          headers: {
            'authorization': apiKey,
            'Transfer-Encoding': 'chunked',
            'Content-Type': 'application/octet-stream',
          },
        ),
      );

      return response.data['upload_url'];
    } catch (e) {
      print('❌ فشل رفع الملف: $e');
      return null;
    }
  }

  /// 2. طلب التفريغ النصي
  Future<String?> requestTranscription(String audioUrl) async {
    try {
      final response = await _dio.post(
        transcriptUrl,
        data: jsonEncode({
          'audio_url': audioUrl,
          'language_code': 'ar',
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response);
      return response.data['id'];
    } catch (e) {
      print('❌ فشل طلب التفريغ: $e');
      return null;
    }
  }

  /// 3. متابعة حالة التفريغ
  Future<String?> getTranscriptionResult(String transcriptId) async {
    try {
      final response = await _dio.get('$transcriptUrl/$transcriptId');

      final status = response.data['status'];
      if (status == 'completed') {
        return response.data['text'];
      } else if (status == 'failed') {
        return '❌ فشل في التفريغ';
      } else {
        return null; // ما زال قيد التنفيذ
      }
    } catch (e) {
      print('❌ فشل في جلب النتيجة: $e');
      return null;
    }
  }
}
