import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './todo_add_page.dart';

const int priorityHigh = 900;
const int priorityMedium = 500;
const int priorityLow = 100;

// 更新可能なデータ
class Todo extends ChangeNotifier {
  String? id;
  String? text;
  int? priority;

  void setTodo(String newId, String newText, int newPriority) {
    id = newId;
    text = newText;
    priority = newPriority;
    notifyListeners();
  }
}

// リスト一覧画面用Widget
class ToDoListPage extends StatefulWidget {
  const ToDoListPage({ Key? key }) : super(key: key);
  static String routeName = '/todo/list';

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {

  @override
  Widget build(BuildContext context) {
    final Todo toDo = Provider.of<Todo>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト一覧'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection('todos')
                .orderBy('created_at')
                .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents =
                    snapshot.data!.docs;
                  return Container(
                    padding: const EdgeInsets.only(top: 48),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView(
                            children: documents.map((document) {
                              Icon _leadingIcon;
                              switch (document['priority']) {
                                case 100:
                                  _leadingIcon = const Icon(Icons.low_priority);
                                  break;
                                case 500:
                                  _leadingIcon = const Icon(Icons.remove);
                                  break;
                                case 900:
                                  _leadingIcon = const Icon(Icons.priority_high);
                                  break;
                                default:
                                  _leadingIcon = const Icon(Icons.more_vert);
                              }
                              return InkWell(
                                onTap: () async {
                                  toDo.setTodo(document.id, document['text'], document['priority']);
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return const ToDoAddPage();
                                    }),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Card(
                                    elevation: 8,
                                    shadowColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          tileColor: Colors.orange[document['priority']],
                                          leading: _leadingIcon,
                                          title: Text(document['text']),
                                          subtitle: Text(document['created_at']),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete_rounded),
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                .collection('todos')
                                                .doc(document.id)
                                                .delete();
                                            },
                                          ),
                                        ),
                                    ],) 
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text('読込中...'),
                );
              },
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          toDo.setTodo("", "", priorityMedium);
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const ToDoAddPage();
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

