import 'package:flutter/material.dart';

import 'battery_optimizer_page.dart';

class _OptimizerButton extends StatelessWidget {
  final String text;

  const _OptimizerButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(color: kColorTitle, fontSize: 12),
      ),
    );
  }
}

class OptimizerButtons extends StatelessWidget {
  const OptimizerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: const [
            SizedBox(width: 16),
            _OptimizerButton(text: 'Battery Optimizer'),
            SizedBox(width: 16),
            _OptimizerButton(text: 'Connection Optimizer'),
            SizedBox(width: 16),
            _OptimizerButton(text: 'Memory Optimizer'),
            SizedBox(width: 16),
            _OptimizerButton(text: 'Storage Optimizer'),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
