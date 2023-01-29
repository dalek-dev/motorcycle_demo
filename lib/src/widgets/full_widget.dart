import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motorcycle_demo/src/utils/wave_painter.dart';

class FullWidget extends StatefulWidget {
  const FullWidget({super.key});

  @override
  State<FullWidget> createState() => _FullWidgetState();
}

class _FullWidgetState extends State<FullWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerTwo;
  late AnimationController _controllerThree;
  late Animation<double> _animation;
  late Animation<double> _animationTwo;
  late Animation<double> _animationThree;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controllerTwo = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controllerThree = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = Tween<double>(begin: 0, end: 40).animate(_controller);
    _animationTwo = Tween<double>(begin: 0, end: 50).animate(_controllerTwo);
    _animationThree =
        Tween<double>(begin: 0, end: 40).animate(_controllerThree);
    _controller.repeat(reverse: true);
    Future.delayed(const Duration(milliseconds: 300), () {
      _controllerTwo.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _controllerThree.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
                animation: _controllerThree,
                builder: (context, child) {
                  return Positioned(
                    bottom: 20,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Transform.rotate(
                        angle: 180 * pi / 180,
                        child: CustomPaint(
                          painter: WavePainter(_animationThree,
                              const Color(0xFF00ffde).withOpacity(0.3),
                              hasBlur: true),
                        ),
                      ),
                    ),
                  );
                }),
            AnimatedBuilder(
                animation: _controllerTwo,
                builder: (context, child) {
                  return Positioned(
                    bottom: 20,
                    child: SizedBox(
                      height: 110,
                      width: 100,
                      child: Transform.rotate(
                        angle: 180 * pi / 180,
                        child: CustomPaint(
                          painter: WavePainter(_animationTwo,
                              const Color(0xFF00ffde).withOpacity(0.5)),
                        ),
                      ),
                    ),
                  );
                }),
            Positioned(
              bottom: 0,
              child: Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF00ffde).withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
              ),
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    bottom: 10,
                    child: SizedBox(
                      height: 120,
                      width: 100,
                      child: Transform.rotate(
                        angle: 180 * pi / 180,
                        child: CustomPaint(
                          painter: WavePainter(_animation,
                              const Color(0xFF00ffde).withOpacity(0.7),
                              hasBlur: true),
                        ),
                      ),
                    ),
                  );
                }),
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '78%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Charging',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
