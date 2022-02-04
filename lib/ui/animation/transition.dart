import 'package:flutter/material.dart';

class TransitionWidget extends StatefulWidget {
  const TransitionWidget({Key? key}) : super(key: key);

  @override
  _TransitionWidgetState createState() => _TransitionWidgetState();
}

class _TransitionWidgetState extends State<TransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this, // with SingleTickerProviderStateMixin を忘れずに
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(
      begin: 1.0, // アニメーション開始時のスケール
      end: 2.0, // アニメーション終了時のスケール
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transition'),
        centerTitle: false,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // アニメーション再生
                controller.forward();
              },
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                // アニメーション停止
                controller.stop();
              },
              icon: const Icon(Icons.stop),
            ),
            IconButton(
              onPressed: () {
                // アニメーション繰り返し
                controller.repeat();
              },
              icon: const Icon(Icons.loop),
            ),
          ],
        ),
      ),
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
