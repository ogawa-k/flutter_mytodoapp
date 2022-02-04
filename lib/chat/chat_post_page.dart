import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_login_page.dart';

// 投稿画面用Widget
class ChatAddPostPage extends StatefulWidget {
  const ChatAddPostPage({ Key? key }) : super(key: key);
  static String routeName = '/chat/post';

  @override
  _ChatAddPostPageState createState() => _ChatAddPostPageState();
}

class _ChatAddPostPageState extends State<ChatAddPostPage> {
  // 入力した投稿メッセージ
  String messageText = '';

  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);
    final User? user = userState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット投稿'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 投稿メッセージ入力
              TextFormField(
                decoration: const InputDecoration(labelText: '投稿メッセージ'),
                // 複数行のテキスト入力
                keyboardType: TextInputType.multiline,
                // 最大3行
                maxLines: 3,
                onChanged: (String value) {
                  setState(() {
                    messageText = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.blue,
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('投稿'),
                  onPressed: () async {
                    final date =
                      DateTime.now().toLocal().toIso8601String(); // 現在の日時
                    final email = user!.email;  // ChatAddPostPageのデータを参照
                    // 投稿メッセージ用ドキュメント作成
                    await FirebaseFirestore.instance
                      .collection('posts')
                      .doc()
                      .set({
                        'text': messageText,
                        'email': email,
                        'date': date
                      });
                    // 1つ前の画面に戻る
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
