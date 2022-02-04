import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);
  static String routeName = '/signup';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー登録テスト'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: const InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: "パスワード（６文字以上）"),
                // パスワードが見えないようにする
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword
                    );
                    // 登録したユーザー情報
                    final User user = userCredential.user!;
                    setState(() {
                      infoText = "登録OK：${user.email}";
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      setState(() {
                        infoText = '登録NG：The password provided is too weak.';
                      });
                    } else if (e.code == 'email-already-in-use') {
                      setState(() {
                        infoText = '登録NG：The account already exists for that email.';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      infoText = '登録NG：${e.toString()}';
                    });
                  }
                },
                child: const Text("ユーザー登録"),
              ),
              const SizedBox(height: 8),
              Text(infoText)
            ],
          ),
        ),
      ),
    );
  }
}
