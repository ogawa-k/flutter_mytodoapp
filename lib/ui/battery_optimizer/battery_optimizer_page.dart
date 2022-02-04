import 'package:flutter/material.dart';

import '_apps_drainage.dart';
import '_battery_level_indicator.dart';
import '_optimize_now.dart';
import '_optimizer_buttons.dart';

const kColorPurple = Color(0xFF8337EC);
const kColorPink = Color(0xFFFF006F);
const kColorIndicatorBegin = kColorPink;
const kColorIndicatorEnd = kColorPurple;
const kColorTitle = Color(0xFF616161);
const kColorText = Color(0xFF9E9E9E);
const kElevation = 4.0;

/* BatteryOptimizer画面 */
class BatteryOptimizerPage extends StatelessWidget {
  const BatteryOptimizerPage({Key? key}) : super(key: key);
  static String routeName = '/ui/battery_optimizer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Battery Optimizer'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            OptimizerButtons(),
            BatteryLevelIndicator(),
            AppsDrainage(),
            OptimizeNow(),
          ],
        ),
      ),
    );
  }
}
