import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:motorcycle_demo/src/providers/description_provider.dart';
import 'package:motorcycle_demo/src/providers/home_provider.dart';
import 'package:motorcycle_demo/src/widgets/charging_widget.dart';
import 'package:motorcycle_demo/src/widgets/slider.dart';
import 'package:motorcycle_demo/src/widgets/speed_widget.dart';
import 'package:motorcycle_demo/src/widgets/tank_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Scene _scene;
  Object? _motorbike;
  late AnimationController _controller;
  late Animation _animation;

  late AnimationController _motorbikeController;
  late Animation _animationMotorbike;

  late AnimationController _descriptionController;
  late Animation _animationDescription;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

    _motorbikeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animationMotorbike =
        Tween<double>(begin: 0, end: 1).animate(_motorbikeController);

    _descriptionController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animationDescription =
        Tween<double>(begin: 0, end: 1).animate(_descriptionController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _descriptionController.dispose();
    _motorbikeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => DescriptionProvider())
      ],
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: SweepGradient(
            colors: [
              Colors.red,
              Colors.white,
              const Color(0xFF4c2882).withOpacity(0.9),
              const Color(0xFF3b83bd).withOpacity(0.4),
              const Color(0xFF4c2882).withOpacity(0.7),
            ],
            startAngle: -4,
            endAngle: 2,
            center: Alignment.topLeft,
          )),
          child: Stack(
            children: [
              Positioned(
                left: -10,
                bottom: 120,
                child: Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: AnimatedBuilder(
                        animation: _motorbikeController,
                        builder: (context, child) {
                          if (context.watch<HomeProvider>().isTriggerHome) {
                            if (_motorbike != null) {
                              _motorbike!.rotation.y =
                                  _animationMotorbike.value * 90;
                              _motorbike!.rotation.z =
                                  _animationMotorbike.value * 30;
                              _motorbike!.rotation.x =
                                  _animationMotorbike.value * 0;
                              _motorbike!.updateTransform();
                              _scene.update();
                              context
                                  .watch<DescriptionProvider>()
                                  .startAnimationDescription();
                            }
                          }
                          return Transform.scale(
                              scale: 5,
                              child: Cube(onSceneCreated: (Scene scene) async {
                                _scene = scene;
                                scene.camera.position.z = 10;

                                _motorbike = Object(
                                    rotation: Vector3(10, -60, 0),
                                    position: Vector3(0, 0.0, 0),
                                    scale: Vector3(7.0, 7.0, 7.0),
                                    fileName: 'assets/3d/Motorcycle.obj');
                                scene.world.add(_motorbike!);
                              }));
                        }),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      ChargingWidget(),
                      SpeedWidget(),
                      TankWidget()
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          if (context.watch<HomeProvider>().isTriggerHome) {
                            _controller.forward();
                            _motorbikeController.forward();
                            _descriptionController.forward();
                          }
                          return Opacity(
                            opacity: _animation.value,
                            child: const Text(
                              'Enjoy your \nriding',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.translate(
                              offset: Offset(0, -_animation.value * 100 + 100),
                              child: const SliderWidget());
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
