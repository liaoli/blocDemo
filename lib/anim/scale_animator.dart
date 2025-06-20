import 'package:flutter/material.dart';

class ScaleAnimator extends StatefulWidget {
  final Widget child;
  final double beginScale;
  final double endScale;
  final Duration duration;

  const ScaleAnimator({
    super.key,
    required this.child,
    this.beginScale = 1.0,
    this.endScale = 1.5,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  ScaleAnimatorState createState() => ScaleAnimatorState();
}

class ScaleAnimatorState extends State<ScaleAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.beginScale,
      end: widget.endScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      // 播放完成后自动反向回到原始状态
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  /// 播放一次（支持连续点击立即重播）
  void playOnce() {
    _controller
      ..stop()
      ..reset()
      ..forward();
  }

  void repeat() {
    _controller
      ..reset()
      ..repeat(reverse: true);
  }

  void stop() {
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
