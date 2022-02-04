import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({ Key? key }) : super(key: key);
  static String routeName = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // 入力されたメールアドレス（ログイン）
  String loginUserEmail = "";
  // 入力されたパスワード（ログイン）
  String loginUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サインインテスト'),
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
                    loginUserEmail = value;
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
                    loginUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: loginUserEmail,
                      password: loginUserPassword
                    );
                    // 登録したユーザー情報
                    final User user = userCredential.user!;
                    setState(() {
                      infoText = "ログインOK：${user.email}";
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      setState(() {
                        infoText = 'ログインNG：No user found for that email.';
                      });
                    } else if (e.code == 'wrong-password') {
                      setState(() {
                        infoText = 'ログインNG：Wrong password provided for that user.';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      infoText = 'ログインNG：${e.toString()}';
                    });
                  }
                },
                child: const Text("ログイン"),
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
