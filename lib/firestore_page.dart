import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFirestorePage extends StatefulWidget {
  const MyFirestorePage({Key? key}) : super(key: key);
  static String routeName = '/firestore';

  @override
  _MyFirestorePageState createState() => _MyFirestorePageState();
}

class _MyFirestorePageState extends State<MyFirestorePage> {
  // 作成したドキュメント一覧
  List<DocumentSnapshot> documentList = [];
  // 指定したドキュメントの情報
  String orderDocumentInfo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestoreテスト'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: const Text('コレクション＋ドキュメント作成'),
                onPressed: () async {
                  // ドキュメント作成
                  await FirebaseFirestore.instance
                      .collection('users') // コレクションID
                      .doc('id_abc') // ドキュメントID
                      .set({'name': '鈴木', 'age': 40}); // データ
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: const Text('サブコレクション＋ドキュメント作成'),
                onPressed: () async {
                  // サブコレクション内にドキュメント作成
                  await FirebaseFirestore.instance
                      .collection('users') // コレクションID
                      .doc('id_abc') // ドキュメントID << usersコレクション内のドキュメント
                      .collection('orders') // サブコレクションID
                      .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
                      .set({'price': 600, 'date': '9/13'}); // データ
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: const Text('ドキュメント一覧取得'),
                onPressed: () async {
                  // コレクション内のドキュメント一覧を取得
                  final snapshot =
                      await FirebaseFirestore.instance.collection('users').get();
                  // 取得したドキュメント一覧をUIに反映
                  setState(() {
                    documentList = snapshot.docs;
                  });
                },
              ),
            ),
            Container(
              // コレクション内のドキュメント一覧を表示
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: documentList.map((document) {
                  return ListTile(
                    title: Text('${document['name']}さん'),
                    subtitle: Text('${document['age']}歳'),
                  );
                }).toList(),
              ),
            ),
            Container(
              // コレクション内のドキュメント一覧を表示
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: const Text('ドキュメントを指定して取得'),
                onPressed: () async {
                  // コレクションIDとドキュメントIDを指定して取得
                  final document = await FirebaseFirestore.instance
                      .collection('users')
                      .doc('id_abc')
                      .collection('orders')
                      .doc('id_123')
                      .get();
                  // 取得したドキュメントの情報をUIに反映
                  setState(() {
                    orderDocumentInfo =
                        '${document['date']} ${document['price']}円';
                  });
                },
              ),
            ),
            Container(
              // ドキュメントの情報を表示
              margin: const EdgeInsets.only(top: 10.0),
              child: ListTile(title: Text(orderDocumentInfo)),
            ),
            Container(
              // ドキュメント更新
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: const Text('ドキュメント更新'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('id_abc')
                      .update({'age': 41});
                },
              ),
            ),
            Container(
              // ドキュメント削除
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: const Text('ドキュメント削除'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('id_abc')
                      .collection('orders')
                      .doc('id_123')
                      .delete();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}