import 'package:flutter/material.dart';
import '../../pointer.dart';
import 'Target.dart';

class TargetPaint extends CustomPaint {
    final CustomPainter painter;
    TargetPaint({this.painter}) : super(painter: painter);
}

class PointingTaskBuilder {
  final Size imageSize;
  final Pointer pointer;
  Size canvasSize = Size(640, 360);
  List<Target> targets = List<Target>();

  PointingTaskBuilder(this.imageSize, this.pointer);

  void addTargetGrid(Canvas canvas) {
      targets.forEach((t) => (t.draw(canvas, pointer)));
  }

  void paint(Canvas canvas, Size size) {
   addTargetGrid(canvas);
   pointer.draw(canvas, targets: targets);
  }

  bool shouldRepaint(PointingTaskBuilder oldDelegate) {
   return imageSize != oldDelegate.imageSize || pointer != oldDelegate.pointer;
  }

  TargetPainter getPainter() {
   return TargetPainter(this);
  }
}

class TargetPainter extends CustomPainter {
  PointingTaskBuilder _targetBuilder;

  TargetPainter(this._targetBuilder);

  @override
  void paint(Canvas canvas, Size size) {
   _targetBuilder.paint(canvas, size);
  }

  @override
  bool shouldRepaint(TargetPainter oldDelegate) {
   return _targetBuilder.shouldRepaint(oldDelegate.getTargetBuilder());
  }

  PointingTaskBuilder getTargetBuilder() {
   return _targetBuilder;
  }
}