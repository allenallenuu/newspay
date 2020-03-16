import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wpay_app/tools/wave_loading/delay_tween.dart';

enum SpinKitWaveTypeLoading { start, end, center }

class SpinKitWaveLoading extends StatefulWidget {
  const SpinKitWaveLoading({
    Key key,
    this.type = SpinKitWaveTypeLoading.start,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 800),
    this.controller
  })  :
        assert(type != null),
        assert(size != null),
        super(key: key);

  final double size;
  final SpinKitWaveTypeLoading type;
  final Duration duration;
  final AnimationController controller;

  @override
  _SpinKitWaveState createState() => _SpinKitWaveState();
}

class _SpinKitWaveState extends State<SpinKitWaveLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> _bars = getAnimationDelay();
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 1.35, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_bars.length, (i) {
            return ScaleYWidget(
              scaleY: DelayTween(begin: .5, end: 1.0, delay: _bars[i])
                  .animate(_controller),
              child: SizedBox.fromSize(
                  size: Size(widget.size * 0.2, widget.size),
                  child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  List<double> getAnimationDelay() {
    switch (widget.type) {
      case SpinKitWaveTypeLoading.start:
        return [-1.2, -1.0, -.8, -.6, -.4];
      case SpinKitWaveTypeLoading.end:
        return [-.8, -.9, -1.0, -1.1, -1.2];
      case SpinKitWaveTypeLoading.center:
      default:
        return [-0.75, -0.95, -1.2, -0.95, -0.75];
    }
  }

  Widget _itemBuilder(int index) =>  DecoratedBox(decoration: BoxDecoration(color: itemColor(index)));
}

Color itemColor(int i) {
  if (i == 0) {
    return Colors.blueAccent;
  } else if (i == 1) {
    return Colors.green;
  } else if (i == 2) {
    return Colors.red;
  } else if (i == 3) {
    return Colors.orangeAccent;
  } else if (i == 4) {
    return Colors.brown;
  }
}

class ScaleYWidget extends AnimatedWidget {
  const ScaleYWidget({
    Key key,
    @required Animation<double> scaleY,
    @required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key, listenable: scaleY);

  final Widget child;
  final Alignment alignment;

  Animation<double> get scale => listenable;

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()..scale(1.0, scale.value, 1.0),
        alignment: alignment,
        child: child);
  }
}
