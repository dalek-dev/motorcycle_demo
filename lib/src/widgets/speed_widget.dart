import 'package:flutter/material.dart';
import 'package:motorcycle_demo/src/providers/description_provider.dart';
import 'package:motorcycle_demo/src/widgets/details_widget.dart';
import 'package:provider/provider.dart';

class SpeedWidget extends StatefulWidget {
  const SpeedWidget({super.key});

  @override
  State<SpeedWidget> createState() => _SpeedWidgetState();
}

class _SpeedWidgetState extends State<SpeedWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animation = Tween<double>(begin: 600, end: 250).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DescriptionProvider>(context);

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (provider.isTriggerDescription) {
            _controller.forward();
          }
          return provider.isTriggerDescription
              ? Transform.translate(
                  offset: Offset(_animation.value, 180),
                  child: const DetailsWidget(
                      title: '170', description: 'Top speed'),
                )
              : const SizedBox.shrink();
        });
  }
}
