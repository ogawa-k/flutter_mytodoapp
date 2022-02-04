import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_list_page.dart';

// リスト追加画面用Widget
class ToDoAddPage extends StatelessWidget {
  const ToDoAddPage({ Key? key }) : super(key: key);
  static String routeName = '/todo/add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト追加・更新'),
      ),
      body: const ToDoAddForm(),
    );
  }
}

class ToDoAddForm extends StatefulWidget {
  const ToDoAddForm({ Key? key }) : super(key: key);

  @override
  _ToDoAddFormState createState() => _ToDoAddFormState();
}

class _ToDoAddFormState extends State<ToDoAddForm> {
  final _formKey = GlobalKey<FormState>();
  String _text = '';
  int _priority = priorityMedium;

  @override
  Widget build(BuildContext context) {
    final Todo toDo = Provider.of<Todo>(context);
    String _documentId = toDo.id!;
    String _initialText = toDo.text!;
    int _initialPriority = toDo.priority!;

    String _buttonText = _documentId == ""? '追加': '更新';
    setState(() {
      _text = _initialText;
      _priority = _initialPriority;
    });

    return Container(
      padding: const EdgeInsets.all(64),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text, style: const TextStyle(color: Colors.blue)),
            TextFormField(
              initialValue: _initialText,
              decoration: const InputDecoration(
                labelText: 'ToDo *必須',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
                ),
                hintText: 'ToDoを入力してください。', // 未入力時に表示されるテキスト
              ),
              autofocus: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return '必須項目です！';
                }
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
                toDo.setTodo(_documentId, _text, _priority);
              },
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: '優先度'),
              value: _initialPriority.toString(),
              items: [
                DropdownMenuItem(child: const Text('高'), value: priorityHigh.toString(),),
                DropdownMenuItem(child: const Text('中'), value: priorityMedium.toString(),),
                DropdownMenuItem(child: const Text('低'), value: priorityLow.toString(),),
              ],
              onChanged: (String? value) {
                setState(() {
                  _priority = int.parse(value!);
                });
                toDo.setTodo(_documentId, _text, _priority);
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 64),
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_documentId == "") {
                      final createdAt =
                        DateTime.now().toLocal().toIso8601String();
                      await FirebaseFirestore.instance
                        .collection('todos')
                        .doc()
                        .set({
                          'text': _text,
                          'priority': _priority,
                          'created_at': createdAt,
                        });
                    } else {
                      final updatedAt =
                        DateTime.now().toLocal().toIso8601String();
                      await FirebaseFirestore.instance
                        .collection('todos')
                        .doc(_documentId)
                        .update({
                          'text': _text,
                          'priority': _priority,
                          'updated_at': updatedAt,
                        });
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(_buttonText, style: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 64),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('キャンセル'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
