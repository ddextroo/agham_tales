import 'dart:math';
import 'package:flutter/material.dart';

class CloudAnimation extends StatefulWidget {
  final double startTop;
  final double startLeft;
  final double size;
  final Duration duration;

  const CloudAnimation({
    Key? key,
    required this.startTop,
    required this.startLeft,
    required this.size,
    required this.duration,
  }) : super(key: key);

  @override
  _CloudAnimationState createState() => _CloudAnimationState();
}

class _CloudAnimationState extends State<CloudAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    // Generate random movement direction
    double dx = (_random.nextDouble() * 2 - 1) * 30; // -30 to +30 px range
    double dy = (_random.nextDouble() * 2 - 1) * 30;

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(dx, dy),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: widget.startTop + _animation.value.dy,
          left: widget.startLeft + _animation.value.dx,
          child: Opacity(
            opacity: 0.7,
            child: Container(
              width: widget.size,
              height: widget.size / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(widget.size / 2),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CloudsOverlay extends StatelessWidget {
  final int cloudCount;

  const CloudsOverlay({Key? key, this.cloudCount = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final List<Widget> clouds = List.generate(cloudCount, (index) {
      return CloudAnimation(
        startTop: random.nextDouble() * MediaQuery.of(context).size.height,
        startLeft: random.nextDouble() * MediaQuery.of(context).size.width,
        size: random.nextDouble() * 100 + 50, // Size between 50 to 150
        duration: Duration(seconds: random.nextInt(20) + 10), // 10 to 30 secs
      );
    });

    return Stack(children: clouds);
  }
}
