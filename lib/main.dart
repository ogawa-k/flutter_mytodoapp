import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'auth/register_page.dart';
import 'auth/signin_page.dart';
import 'firestore_page.dart';
import 'chat/chat_login_page.dart';
import 'todo/todo_list_page.dart';
import 'ui/admin_mobile/admin_mobile_page.dart';
import 'ui/animation/animation.dart';
import 'ui/animation/transition.dart';
import 'ui/flight_booking/flight_booking_page.dart';
import 'ui/sign_up_in/welcome_page.dart';
import 'ui/battery_optimizer/battery_optimizer_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Sample App';

  @override
  Widget build(BuildContext context) {
    // ユーザー情報を渡す
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          create: (context) => UserState(),
        ),
        ChangeNotifierProvider<Todo>(
          create: (context) => Todo(),
        ),
      ],
      child: MaterialApp(
        // 右上に表示される"debug"ラベルを消す
        // debugShowCheckedModeBanner: false,
        title: _title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          MenuSelector.routeName: (context) => const MenuSelector(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          SignInPage.routeName: (context) => const SignInPage(),
          MyFirestorePage.routeName: (context) => const MyFirestorePage(),
          ChatLoginPage.routeName: (context) => const ChatLoginPage(),
          ToDoListPage.routeName: (context) => const ToDoListPage(),
          AdminMobilePage.routeName: (context) => const AdminMobilePage(),
          WelcomePage.routeName: (context) => const WelcomePage(),
          BatteryOptimizerPage.routeName: (context) => const BatteryOptimizerPage(),
          FlightBookingPage.routeName: (context) => const FlightBookingPage(),
        },
        initialRoute: MenuSelector.routeName,
      ),
    );
  }
}

/// Provides a UI to select a authentication type page
class MenuSelector extends StatelessWidget {
  const MenuSelector({ Key? key }) : super(key: key);
  static String routeName = '/';

  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterサンプルアプリ'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: const Text('Firebase Authentication'),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.person_add,
                    backgroundColor: Colors.indigo,
                    text: 'ユーザー登録テスト',
                    onPressed: () => _pushPage(context, const RegisterPage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.verified_user,
                    backgroundColor: Colors.orange,
                    text: 'ログインテスト',
                    onPressed: () => _pushPage(context, const SignInPage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: const Text('Firebase Cloud Firestore'),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.collections_rounded,
                    backgroundColor: Colors.blue,
                    text: 'CRUDテスト',
                    onPressed: () => _pushPage(context, const MyFirestorePage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: const Text('サンプルアプリ'),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.question_answer,
                    backgroundColor: Colors.blueGrey,
                    text: 'チャット',
                    onPressed: () => _pushPage(context, const ChatLoginPage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.list_alt_rounded,
                    backgroundColor: Colors.blue,
                    text: 'Todoリスト',
                    onPressed: () => _pushPage(context, const ToDoListPage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: const Text('UIサンプル'),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.design_services,
                    backgroundColor: Colors.blueGrey,
                    text: 'Admin Mobile',
                    onPressed: () => _pushPage(context, const AdminMobilePage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.login,
                    backgroundColor: Colors.blueGrey,
                    text: 'Sign In / Sign Up',
                    onPressed: () => _pushPage(context, const WelcomePage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.battery_alert,
                    backgroundColor: Colors.blueGrey,
                    text: 'Battery Optimizer',
                    onPressed: () => _pushPage(context, const BatteryOptimizerPage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.flight,
                    backgroundColor: Colors.blueGrey,
                    text: 'Flight Booking',
                    onPressed: () => _pushPage(context, const FlightBookingPage()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.animation,
                    backgroundColor: Colors.blueGrey,
                    text: 'Animation',
                    onPressed: () => _pushPage(context, const AnimationWidget()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.transform_outlined,
                    backgroundColor: Colors.blueGrey,
                    text: 'Transition',
                    onPressed: () => _pushPage(context, const TransitionWidget()),
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
