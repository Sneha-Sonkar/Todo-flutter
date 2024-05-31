import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todos = [];
  TextEditingController textController = TextEditingController();

  void _addItem() {
    setState(() {
      todos.add(textController.text);
      textController.clear();
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(labelText: "Your Todos"),
          ),
          TextButton(
            onPressed: _addItem,
            child: const Text('Add'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
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
