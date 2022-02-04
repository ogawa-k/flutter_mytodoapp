import 'package:flutter/material.dart';

import './_header.dart';
import './_form.dart';
import './_footer.dart';

const Color kAccentColor = Color(0xFFFE7C64);
const Color kBackgroundColor = Color(0xFF19283D);
const Color kTextColorPrimary = Color(0xFFECEFF1);
const Color kTextColorSecondary = Color(0xFFB0BEC5);
const Color kButtonColorPrimary = Color(0xFFECEFF1);
const Color kButtonTextColorPrimary = Color(0xFF455A64);
const Color kIconColor = Color(0xFF455A64);


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static String routeName = '/ui/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Header(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: SignInForm(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 64),
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
