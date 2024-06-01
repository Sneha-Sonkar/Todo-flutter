import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todomodel.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _addItem() {
    if (textController.text != "") {
      setState(() {
        todos.add({Todo('title': textController.text, 'isDone': false)});
        textController.clear();
      });
    }
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

 void _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');
    if (todosString != null) {
      final List<dynamic> todosJson = json.decode(todosString);
      setState(() {
        todos = todosJson.map((json) => Todo.fromMap(json)).toList();
      });
    }
  }

  void _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String todosString = json.encode(todos.map((todo) => todo.toMap()).toList());
    prefs.setString('todos', todosString);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(labelText: "Your Todos"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addItem,
            child: const Text('Add'),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: todos[index]['isDone'],
                    onChanged: (bool? value) {
                      setState(() {
                        todos[index] = ({
                          'title': todos[index]['title'],
                          'isDone': value!
                        });
                      });
                    },
                  ),
                  title: Text(
                    todos[index]['title'],
                    style: TextStyle(
                      decoration: todos[index]['isDone']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeTodo(index),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
