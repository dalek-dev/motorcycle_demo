import 'package:flutter/material.dart';
import 'package:motorcycle_demo/src/providers/description_provider.dart';
import 'package:motorcycle_demo/src/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationTextController;
  late Animation _animationText;

  late AnimationController _animationFirstArrowController;
  late Animation _animationFirstArrow;

  late AnimationController _animationSecondArrowController;
  late Animation _animationSecondArrow;

  late AnimationController _animationThirdArrowController;
  late Animation _animationThirdArrow;

  double posX = 0.0;
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    _animationTextController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animationText =
        Tween<double>(begin: 0.4, end: 1).animate(_animationTextController);

    _animationFirstArrowController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animationFirstArrow = Tween<double>(begin: 0.4, end: 1)
        .animate(_animationFirstArrowController);

    _animationSecondArrowController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animationSecondArrow = Tween<double>(begin: 0.4, end: 1)
        .animate(_animationSecondArrowController);

    _animationThirdArrowController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animationThirdArrow = Tween<double>(begin: 0.4, end: 1)
        .animate(_animationThirdArrowController);

    _animationTextController.repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 1200), () {
      _animationFirstArrowController.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 2400), () {
      _animationSecondArrowController.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 3600), () {
      _animationThirdArrowController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _animationTextController.dispose();
    _animationFirstArrowController.dispose();
    _animationSecondArrowController.dispose();
    _animationThirdArrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final descProvider = Provider.of<DescriptionProvider>(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Center(
              child: AnimatedBuilder(
                  animation: _animationTextController,
                  builder: (context, child) {
                    return Text(
                      'Start riding',
                      style: TextStyle(
                          color:
                              Colors.white.withOpacity(_animationText.value)),
                    );
                  })),
        ),
        Positioned(
          right: 30,
          top: 22,
          child: Row(
            children: [
              AnimatedBuilder(
                  animation: _animationFirstArrowController,
                  builder: (context, child) {
                    return Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white.withOpacity(_animationFirstArrow
                          .drive(CurveTween(curve: Curves.easeOut))
                          .value),
                      size: 10,
                    );
                  }),
              AnimatedBuilder(
                  animation: _animationSecondArrowController,
                  builder: (context, child) {
                    return Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white.withOpacity(_animationSecondArrow
                          .drive(CurveTween(curve: Curves.easeOut))
                          .value),
                      size: 10,
                    );
                  }),
              AnimatedBuilder(
                  animation: _animationThirdArrowController,
                  builder: (context, child) {
                    return Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white.withOpacity(_animationThirdArrow
                          .drive(CurveTween(curve: Curves.easeOut))
                          .value),
                      size: 10,
                    );
                  }),
            ],
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            left: posX,
            onEnd: () {},
            child: GestureDetector(
              onPanCancel: () {},
              onPanEnd: (details) async {
                setState(() {
                  posX = 0;
                  if (isSuccess) {
                    posX = 290;
                    provider.startAnimationHome();
                    descProvider.startAnimationDescription();
                  }
                });
              },
              onPanUpdate: (update) {
                setState(() {
                  posX = update.localPosition.dx;
                });
                if (posX > 290.0) {
                  isSuccess = true;
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ))
      ],
    );
  }
}
