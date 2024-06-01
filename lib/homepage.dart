import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> todos = [];
  TextEditingController textController = TextEditingController();
  bool _isChecked = false;

  void _addItem() {
    if (textController.text != "") {
      setState(() {
        todos.add({'title': textController.text, 'checked': false});
        textController.clear();
      });
    }
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
                    value: todos[index]['checked'],
                    onChanged: (bool? value) {
                      setState(() {
                        todos[index] = ({
                          'title': todos[index]['title'],
                          'checked': value!
                        });
                      });
                    },
                  ),
                  title: Text(
                    todos[index]['title'],
                    style: TextStyle(
                      decoration: todos[index]['checked'] == true
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
