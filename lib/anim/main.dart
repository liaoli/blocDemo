import 'package:blocdemo/anim/scale_animator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<ScaleAnimatorState> _animKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('按钮触发缩放动画')),
        body: Center(
          child: ScaleAnimator(
            key: _animKey,
            beginScale: 1.0,
            endScale: 1.5,
            duration: Duration(milliseconds: 300),
            child: ElevatedButton(
              onPressed: () {
                _animKey.currentState?.playOnce();
              },
              child: Text("点我缩放"),
            ),
          ),
        ),
      ),
    );
  }
}
