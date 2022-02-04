import 'package:flutter/material.dart';

import 'battery_optimizer_page.dart';

class OptimizeNow extends StatelessWidget {
  const OptimizeNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kColorPurple,
          padding: const EdgeInsets.symmetric(horizontal: 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () {},
        child: const Text('Optimize Now', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
