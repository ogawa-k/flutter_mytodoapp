import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({Key? key}) : super(key: key);
  static String routeName = 'ui/animation/intro';

  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {
  double size = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
        centerTitle: false,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            size = 200;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: size,
          height: size,
          color: Colors.blue,
        ),
      ),
    );
  }
}
