import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String inputString = "";
  List<String> todos = [];

 void _addItem() {
   setState(() {
      todos.add(inputString); 
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
        child: Column(
          children: [
            TextField(
              onChanged:(text){
                setState(() {
                inputString = text;                  
                });

              } ,
            ),
            TextButton(
              
              onPressed: _addItem,
              child: Text('Add'),
              ),
             Expanded(  
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index]),
                  );
                },
              ),
            ),              
        ]
        ),
        
      ),
      
    );
  }
}
