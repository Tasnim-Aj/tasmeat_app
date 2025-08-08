import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/app_colors.dart';

class AudioPlayerSection extends StatefulWidget {
  const AudioPlayerSection({super.key});

  @override
  State<AudioPlayerSection> createState() => _AudioPlayerSectionState();
}

class _AudioPlayerSectionState extends State<AudioPlayerSection> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      // إعداد مستمعين للتحديثات
      _audioPlayer.onPlayerStateChanged.listen((state) {
        if (!mounted) return;
        setState(() => _isPlaying = state == PlayerState.playing);
      });

      _audioPlayer.onDurationChanged.listen((duration) {
        if (!mounted) return;
        setState(() {
          _duration = duration;
          if (!_isInitialized) {
            _isLoading = false;
            _isInitialized = true;
          }
        });
      });

      _audioPlayer.onPositionChanged.listen((position) {
        if (!mounted) return;
        setState(() => _position = position);
      });

      // تحميل الملف الصوتي
      await _audioPlayer.setSource(AssetSource("sounds/hadith1.m4a"));
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      debugPrint("Error initializing audio player: $e");
    }
  }

  Future<void> _toggleAudio() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        if (_position.inSeconds == 0 || _position >= _duration) {
          await _audioPlayer.play(AssetSource("sounds/hadith1.m4a"));
        } else {
          await _audioPlayer.resume();
        }
      }
    } catch (e) {
      debugPrint("Error toggling audio: $e");
    }
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
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
            color: Colors.transparent,
          ),
          color:
              Color.lerp(AppColors.primary, AppColors.containerSecondary, 0.5),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.containerSecondary,
                    size: 20.sp,
                  ),
                  onPressed: _isLoading ? null : _toggleAudio,
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 2.h,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 7.r),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 16.r),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white.withOpacity(0.3),
                      thumbColor: Colors.white,
                    ),
                    child: Slider(
                      min: 0,
                      max: _duration.inSeconds.toDouble(),
                      value: _position.inSeconds
                          .clamp(0, _duration.inSeconds)
                          .toDouble(),
                      onChangeStart: (value) => _audioPlayer.pause(),
                      onChangeEnd: (value) => _audioPlayer.resume(),
                      onChanged: (value) async {
                        final newPosition = Duration(seconds: value.toInt());
                        setState(() => _position = newPosition);
                        await _audioPlayer.seek(newPosition);
                      },
                    ),
                  ),
                ),
                Text(
                  _formatTime(_duration - _position),
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    color: AppColors.containerSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // حالة التحميل
            if (_isLoading)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  'جاري تحميل الصوت...',
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
