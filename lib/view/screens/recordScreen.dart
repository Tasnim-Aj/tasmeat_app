import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/record_service.dart';
import '../../services/upload_service.dart';
import '../../utils/permissions.dart';
import '../style/app_colors.dart';
import '../widgets/audio_waveform_Indicator.dart';

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

  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;
  bool _showPlayer = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                height: 324.h,
                margin: EdgeInsets.only(top: 11.r, left: 14.r, right: 14.r),
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
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SingleChildScrollView(
                          child: Text(
                            _transcriptionText!,
                            style: GoogleFonts.cairo(fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      // top: 33.r,
                      right: 30.r),
                  width: 160.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFBBBBBB),
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
}

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds % 60)}";
}
