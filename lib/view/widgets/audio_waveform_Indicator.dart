import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioWaveformIndicator extends StatefulWidget {
  final bool isRecording;

  const AudioWaveformIndicator({super.key, required this.isRecording});

  @override
  State<AudioWaveformIndicator> createState() => _AudioWaveformIndicatorState();
}

class _AudioWaveformIndicatorState extends State<AudioWaveformIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<double> _waveHeights = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..repeat(reverse: true);

    // تهيئة ارتفاعات عشوائية للذبذبات
    _generateRandomWaveHeights();
  }

  void _generateRandomWaveHeights() {
    final random = Random();
    _waveHeights = List.generate(15, (index) {
      return 5 + random.nextDouble() * 20; // ارتفاعات بين 5 و25
    });
  }

  @override
  void didUpdateWidget(AudioWaveformIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // تحديث الارتفاعات بشكل عشوائي أثناء التسجيل
        if (widget.isRecording && _controller.value > 0.9) {
          _generateRandomWaveHeights();
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _waveHeights.map((height) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              width: 3.w,
              height: height * _controller.value,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.r),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
