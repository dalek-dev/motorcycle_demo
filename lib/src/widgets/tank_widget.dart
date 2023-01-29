import 'package:flutter/material.dart';
import 'package:motorcycle_demo/src/providers/description_provider.dart';
import 'package:motorcycle_demo/src/widgets/full_widget.dart';
import 'package:provider/provider.dart';

class TankWidget extends StatefulWidget {
  const TankWidget({super.key});

  @override
  State<TankWidget> createState() => _TankWidgetState();
}

class _TankWidgetState extends State<TankWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    _animation = Tween<double>(begin: 900, end: 250).animate(_controller);
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
                  offset: Offset(_animation.value, 260),
                  child: const FullWidget(),
                )
              : const SizedBox.shrink();
        });
  }
}
