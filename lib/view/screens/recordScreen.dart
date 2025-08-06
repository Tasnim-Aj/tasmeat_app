import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/record_service.dart';
import '../../services/upload_service.dart';
import '../../utils/permissions.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final RecordService _recordService = RecordService();
  final UploadService _uploadService = UploadService();

  String? _recordedFilePath;
  String? _transcriptionText;
  bool _isRecording = false;
  bool _isUploading = false;

  Future<void> _startRecording() async {
    final granted = await PermissionHelper.requestPermissions();
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى السماح بالأذونات المطلوبة')),
      );
      return;
    }

    try {
      await _recordService.startRecording();
      setState(() {
        _isRecording = true;
        _transcriptionText = null;
        _recordedFilePath = null;
      });
    } catch (e) {
      debugPrint('خطأ في بدء التسجيل: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _recordService.stopRecording();
      setState(() {
        _isRecording = false;
        _recordedFilePath = path;
      });
    } catch (e) {
      debugPrint('خطأ في إيقاف التسجيل: $e');
    }
  }

  Future<void> _uploadAndTranscribe() async {
    if (_recordedFilePath == null) return;

    setState(() {
      _isUploading = true;
      _transcriptionText = null;
    });

    final uploadUrl = await _uploadService.uploadAudioFile(_recordedFilePath!);
    if (uploadUrl == null) {
      setState(() {
        _isUploading = false;
        _transcriptionText = 'فشل رفع الملف';
      });
      return;
    }

    final transcriptId = await _uploadService.requestTranscription(uploadUrl);
    if (transcriptId == null) {
      setState(() {
        _isUploading = false;
        _transcriptionText = 'فشل طلب التفريغ';
      });
      return;
    }

    // الانتظار للانتهاء من التفريغ
    String? text;
    while (text == null) {
      await Future.delayed(const Duration(seconds: 3));
      text = await _uploadService.getTranscriptionResult(transcriptId);
      if (text != null && text.startsWith('❌')) {
        // رسالة خطأ
        break;
      }
    }

    setState(() {
      _isUploading = false;
      _transcriptionText = text ?? 'جارٍ المعالجة...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل وتحويل الصوت إلى نص'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isRecording ? null : _startRecording,
              child: const Text('بدء التسجيل'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : null,
              child: const Text('إيقاف التسجيل'),
            ),
            const SizedBox(height: 16),
            if (_recordedFilePath != null) ...[
              Text('تم التسجيل: $_recordedFilePath'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadAndTranscribe,
                child: _isUploading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('رفع وتحويل إلى نص'),
              ),
            ],
            const SizedBox(height: 24),
            if (_transcriptionText != null) ...[
              const Text(
                'النص المستخرج:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_transcriptionText!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
