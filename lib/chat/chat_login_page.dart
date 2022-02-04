import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './chat_page.dart';

// 更新可能なデータ
class UserState extends ChangeNotifier {
  User? user;
  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}

class ChatLoginPage extends StatefulWidget {
  static String routeName = '/chat/login';
  const ChatLoginPage({ Key? key }) : super(key: key);

  @override
  _ChatLoginPageState createState() => _ChatLoginPageState();
}

class _ChatLoginPageState extends State<ChatLoginPage> {
  // 入力されたメールアドレス（ログイン）
  String loginId = "";
  // 入力されたパスワード（ログイン）
  String loginPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('チャットにログイン'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: const InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    loginId = value;
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
                    loginPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: loginId,
                      password: loginPassword
                    );
                    // 登録したユーザー情報
                    final User user = userCredential.user!;
                    userState.setUser(user);
                    setState(() {
                      infoText = "登録OK：${user.email}";
                    });
                    // チャット画面に遷移＋ログイン画面を破棄
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const ChatPage();
                      }),
                    );
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
                  } finally {
                    SnackBar snackBar = SnackBar(
                      content: Text(infoText),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text("ユーザー登録"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: const InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    loginId = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: "パスワード"),
                // パスワードが見えないようにする
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: loginId,
                      password: loginPassword
                    );
                    // 登録したユーザー情報
                    final User user = userCredential.user!;
                    userState.setUser(user);
                    setState(() {
                      infoText = "ログインOK：${user.email}";
                    });
                    // チャット画面に遷移＋ログイン画面を破棄
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const ChatPage();
                      }),
                    );
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
                  } finally {
                    SnackBar snackBar = SnackBar(
                      content: Text(infoText),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}