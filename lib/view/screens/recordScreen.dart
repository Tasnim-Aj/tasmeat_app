import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/hadith_model.dart';
import '../../services/record_service.dart';
import '../../services/upload_service.dart';
import '../../utils/permissions.dart';
import '../style/app_colors.dart';
import '../widgets/audio_waveform_Indicator.dart';

class RecordScreen extends StatefulWidget {
  final HadithModel hadith;
  RecordScreen({Key? key, required this.hadith})
      : super(
          key: key,
        );

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final RecordService _recordService = RecordService();
  final UploadService _uploadService = UploadService();

  HadithModel get hadith => widget.hadith;

  String? _recordedFilePath;
  String? _transcriptionText;
  bool _isRecording = false;
  bool _isUploading = false;

  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;
  bool _showPlayer = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  final TextEditingController _textEditingController = TextEditingController();
  bool _isTextChanged = false;
  String _correctionResult = '';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.h),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.25),
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 72.h,
              leading: Padding(
                padding: EdgeInsets.only(right: 15.r, top: 16.r),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/profile_user.png',
                      width: 40.w,
                      height: 40.h,
                      color: Colors.white,
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 11.w,
                        height: 11.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                ' hadith.title',
                style: GoogleFonts.cairo(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 0.47.sp,
                  letterSpacing: 0,
                  color: AppColors.title,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 31.r, right: 29.r),
              child: Row(
                children: [
                  Image.asset('assets/images/caution.png', width: 25.w),
                  SizedBox(width: 8.w),
                  Text(
                    'سمّع الحديث النبوي !',
                    style: GoogleFonts.almarai(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      height: 1,
                      letterSpacing: 0.0,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(width: 66.w),
                  Container(
                    alignment: Alignment.center,
                    width: 74.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.containerSecondary,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.12),
                          offset: const Offset(0, 3),
                          blurRadius: 7,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '150',
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0,
                            color: AppColors.orange,
                          ),
                        ),
                        Image.asset(
                          'assets/images/feathers.png',
                          width: 18.sp,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 23.r, left: 14.r, right: 14.r),
              width: 362.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.containerSecondary,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.15),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                'عَنْ أَمِيرِ المُؤمِنينَ أَبي حَفْصٍ عُمَرَ بْنِ الخَطَّابِ',
                style: GoogleFonts.aladin(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  height: 0.47.sp,
                  letterSpacing: 0,
                  color: AppColors.green,
                ),
              ),
            ),
            if (_transcriptionText != null) ...[
              Container(
                width: 362.w,
                // height: 324.h,
                height: 80.h,
                margin: EdgeInsets.only(
                    // top: 11.r,
                    left: 14.r,
                    right: 14.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextField(
                        controller: _textEditingController
                          ..text = _transcriptionText!,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.cairo(fontSize: 14.sp),
                        onChanged: (text) {
                          setState(() {
                            _transcriptionText = text;
                            _isTextChanged = true;
                          });
                          debugPrint('====== نص معدل ======');
                          debugPrint('المحتوى: $text');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (_transcriptionText != null &&
                        _transcriptionText!.isNotEmpty) {
                      _compareTexts();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        // top: 33.r,
                        right: 30.r),
                    width: 160.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _isTextChanged ? Color(0xFFBBBBBB) : Colors.red,
                    ),
                    child: Text(
                      'عرض النتيجة',
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        height: 0.47.sp,
                        letterSpacing: 0,
                        color: AppColors.title,
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: _toggleRecording,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor:
                //         _isRecording ? Colors.red : AppColors.primary,
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                //   ),
                //   child: Text(
                //     _isRecording ? 'إيقاف التسجيل' : 'بدء التسجيل',
                //     style: GoogleFonts.cairo(
                //       fontSize: 16.sp,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
            if (_correctionResult.isNotEmpty) ...[
              Container(
                width: 362.w,
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.r),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نتيجة المقارنة:',
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _buildColoredResult(_correctionResult),
                  ],
                ),
              ),
            ],
            // const Spacer(),
            if (_recordedFilePath != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'تم التسجيل: ${_recordedFilePath!.split('/').last}',
                  style: GoogleFonts.cairo(fontSize: 14.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadAndTranscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
                child: _isUploading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'رفع وتحويل إلى نص',
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
            // const SizedBox(height: 24),
            Spacer(),
            Container(
              padding: EdgeInsets.only(left: 43.r, right: 59.r),
              width: 400.w,
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  border: Border.all(
                    width: 1,
                    color: AppColors.containerSecondary,
                  ),
                  gradient: LinearGradient(colors: [
                    Color(0xFF96D5DE),
                    AppColors.containerSecondary,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                  // color: Color.lerp(
                  //     Color(0xFF96D5DE), AppColors.containerSecondary, 0.5),
                  ),
              child: Row(
                children: [
                  if (_isRecording)
                    Icon(Icons.fiber_manual_record, color: Colors.red),
                  SizedBox(width: 10.w),
                  Text(
                    _formatDuration(_recordingDuration),
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (_isRecording)
                    Expanded(
                      child: AudioWaveformIndicator(isRecording: _isRecording),
                    ),
                  Spacer(),
                  if (_recordedFilePath != null && !_isRecording)
                    IconButton(
                      icon: Icon(Icons.play_arrow, color: Colors.white),
                      onPressed: _togglePlayback,
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              width: 390.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.15),
                    offset: const Offset(2, 3),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.containerSecondary,
                          size: 16.sp,
                        ),
                        SizedBox(height: 11.h),
                        Text(
                          'التالي',
                          style: GoogleFonts.aladin(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.47.sp,
                            letterSpacing: 0,
                            color: AppColors.containerSecondary,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: _toggleRecording,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isRecording
                                ? Icon(
                                    Icons.mic_off,
                                    color: AppColors.containerSecondary,
                                    size: 16.sp,
                                  )
                                : Icon(
                                    Icons.mic,
                                    color: AppColors.containerSecondary,
                                    size: 16,
                                  ),
                            SizedBox(height: 11.h),
                            Text(
                              'تسميع',
                              style: GoogleFonts.aladin(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 0.47.sp,
                                letterSpacing: 0,
                                color: AppColors.containerSecondary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.headphones,
                          color: AppColors.containerSecondary,
                          size: 16.sp,
                        ),
                        SizedBox(height: 11.h),
                        Text(
                          'استماع',
                          style: GoogleFonts.aladin(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.47.sp,
                            letterSpacing: 0,
                            color: AppColors.containerSecondary,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.containerSecondary,
                          size: 16.sp,
                        ),
                        SizedBox(height: 11.h),
                        Text(
                          'السابق',
                          style: GoogleFonts.aladin(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.47.sp,
                            letterSpacing: 0,
                            color: AppColors.containerSecondary,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds % 60)}";
  }

  Future<void> _togglePlayback() async {
    if (_recordedFilePath == null) return;

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
      }
      setState(() => _isPlaying = !_isPlaying);
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

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
        _recordingDuration = Duration.zero;
        _transcriptionText = null;
        _recordedFilePath = null;
        _showPlayer = true;
      });

      // بدء المؤقت
      _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _recordingDuration += Duration(seconds: 1);
        });
      });
    } catch (e) {
      debugPrint('خطأ في بدء التسجيل: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _recordService.stopRecording();
      _recordingTimer?.cancel();
      setState(() {
        _isRecording = false;
        _recordedFilePath = path;
      });
    } catch (e) {
      debugPrint('خطأ في إيقاف التسجيل: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في إيقاف التسجيل: $e')),
      );
    }
  }

  Future<void> _uploadAndTranscribe() async {
    if (_recordedFilePath == null) return;

    setState(() {
      _isUploading = true;
      _transcriptionText = null;
    });

    try {
      final uploadUrl =
          await _uploadService.uploadAudioFile(_recordedFilePath!);
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
          break;
        }
      }

      setState(() {
        _isUploading = false;
        _transcriptionText = text ?? 'جارٍ المعالجة...';
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
        _transcriptionText = 'حدث خطأ أثناء الرفع: $e';
      });
    }
  }

  // دالة لإزالة التشكيل من النص العربي
  String _removeTashkeel(String text) {
    const tashkeel = ['َ', 'ُ', 'ِ', 'ّ', 'ً', 'ٌ', 'ٍ', 'ْ', 'ـ'];
    String result = text;
    for (var mark in tashkeel) {
      result = result.replaceAll(mark, '');
    }
    return result;
  }

// دالة لحساب المسافة بين الكلمات (Levenshtein Distance)
  int _levenshteinDistance(String a, String b) {
    a = a.toLowerCase();
    b = b.toLowerCase();

    List<List<int>> matrix = List.generate(
      a.length + 1,
      (i) => List.filled(b.length + 1, 0),
    );

    for (var i = 0; i <= a.length; i++) {
      matrix[i][0] = i;
    }
    for (var j = 0; j <= b.length; j++) {
      matrix[0][j] = j;
    }

    for (var i = 1; i <= a.length; i++) {
      for (var j = 1; j <= b.length; j++) {
        int cost = a[i - 1] == b[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1, // deletion
          matrix[i][j - 1] + 1, // insertion
          matrix[i - 1][j - 1] + cost // substitution
        ].reduce((value, element) => value < element ? value : element);
      }
    }

    return matrix[a.length][b.length];
  }

// دالة لتقدير التشابه بين الكلمات
  double _wordSimilarity(String word1, String word2) {
    word1 = _removeTashkeel(word1);
    word2 = _removeTashkeel(word2);

    if (word1 == word2) return 1.0;

    int maxLength = word1.length > word2.length ? word1.length : word2.length;
    if (maxLength == 0) return 1.0;

    int distance = _levenshteinDistance(word1, word2);
    return 1.0 - (distance / maxLength);
  }

  void _compareTexts() {
    final userText = _transcriptionText ?? '';

    if (userText.isEmpty) {
      setState(() {
        _correctionResult = 'الرجاء إدخال النص أولاً';
      });
      return;
    }

    final originalText = hadith.text;

    if (userText == originalText) {
      setState(() {
        _correctionResult = 'النص صحيح 100% 👏';
        _isTextChanged = false;
      });
      return;
    }

    // تقسيم النص إلى كلمات مع تجاهل التشكيل
    final originalWords = originalText.split(' ').map(_removeTashkeel).toList();
    final userWords = userText.split(' ').map(_removeTashkeel).toList();

    final resultBuffer = StringBuffer();
    int correctCount = 0;
    int totalWords = originalWords.length;
    double totalSimilarity = 0.0;
    List<String> corrections = [];

    for (int i = 0; i < totalWords; i++) {
      String originalWord = originalWords[i];
      String userWord = i < userWords.length ? userWords[i] : '';

      double similarity = _wordSimilarity(originalWord, userWord);
      totalSimilarity += similarity;

      if (similarity > 0.8) {
        // إذا كان التشابه أكثر من 80%
        correctCount++;
        resultBuffer.write('$originalWord ');
        corrections.add(originalWord);
      } else {
        if (userWord.isNotEmpty) {
          // البحث عن أقرب كلمة مقترحة
          String suggestion = _findClosestWord(userWord, originalWords);
          resultBuffer.write('❌$userWord❌ (→ $suggestion) ');
          corrections.add('❌$userWord❌ (→ $suggestion)');
        } else {
          resultBuffer.write('❌[مفقود]❌ (→ $originalWord) ');
          corrections.add('❌[مفقود]❌ (→ $originalWord)');
        }
      }
    }

    double accuracy = correctCount / totalWords;
    double avgSimilarity = totalSimilarity / totalWords;

    setState(() {
      _correctionResult = '''
الدقة: ${(accuracy * 100).toStringAsFixed(1)}%
التشابه: ${(avgSimilarity * 100).toStringAsFixed(1)}%
التصحيح:
${corrections.join(' ')}
''';
      _isTextChanged = false;
    });
  }

// دالة للعثور على أقرب كلمة مقترحة
  String _findClosestWord(String input, List<String> dictionary) {
    input = _removeTashkeel(input);

    String closestWord = '';
    int minDistance = 999;

    for (String word in dictionary) {
      String cleanWord = _removeTashkeel(word);
      int distance = _levenshteinDistance(input, cleanWord);

      if (distance < minDistance) {
        minDistance = distance;
        closestWord = word;
      }
    }

    return closestWord;
  }

  Widget _buildColoredResult(String result) {
    List<TextSpan> spans = [];
    List<String> lines = result.split('\n');

    for (String line in lines) {
      if (line.startsWith('الدقة') || line.startsWith('التشابه')) {
        spans.add(TextSpan(
          text: '$line\n',
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.blue[700],
          ),
        ));
      } else if (line.contains('❌')) {
        // تلوين الأجزاء الخاطئة
        List<String> parts = line.split('❌');
        for (int i = 0; i < parts.length; i++) {
          if (parts[i].isEmpty) continue;

          if (i % 2 == 1) {
            // الجزء الخاطئ
            spans.add(TextSpan(
              text: parts[i],
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
              ),
            ));

            // إضافة الاقتراح إن وجد
            if (parts[i].contains('(→')) {
              List<String> suggestionParts = parts[i].split('(→');
              spans.add(TextSpan(
                text: ' → ${suggestionParts[1]}',
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ));
            }
          } else {
            // الجزء الصحيح
            spans.add(TextSpan(
              text: parts[i],
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ));
          }
        }
        spans.add(const TextSpan(text: '\n'));
      } else {
        spans.add(TextSpan(
          text: '$line\n',
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
