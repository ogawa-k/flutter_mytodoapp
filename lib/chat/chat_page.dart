import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './chat_post_page.dart';
import './chat_login_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({ Key? key }) : super(key: key);
  static String routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);
    final User? user = userState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ログイン画面に遷移＋チャット画面を破棄
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return const ChatLoginPage();
                }),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text('ログイン情報：${user!.email}'),
          ),
          Expanded(
            // FutureBuilder
            // 非同期処理の結果を元にWidgetを作れる
            child: StreamBuilder<QuerySnapshot>(
              // 投稿メッセージ一覧を取得（非同期処理）
              // 投稿日時でソート
              stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('date')
                .snapshots(),
              builder: (context, snapshot) {
                // データが取得できた場合
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents =
                    snapshot.data!.docs;
                  // 取得した投稿メッセージ一覧を元にリスト表示
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                          title: Text(document['text']),
                          subtitle: Text(document['email']),
                          // 自分の投稿メッセージの場合は削除ボタンを表示
                          trailing: document['email'] == user.email
                            ? IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  // 投稿メッセージのドキュメントを削除
                                  await FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(document.id)
                                    .delete();
                                },
                              )
                            : null,
                        ),
                      );
                    }).toList(),
                  );
                }
                // データが読み込み中の場合
                return const Center(
                  child: Text('読込中...'),
                );
              },
            )
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // 投稿画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const ChatAddPostPage();
            }),
          );
        },
      ),
    );
  }
}