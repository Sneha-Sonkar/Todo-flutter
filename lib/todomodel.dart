// lib/todo.dart
class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false, required String, required String  ,
  });

  // Convert a Todo into a Map.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  // Convert a Map into a Todo.
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}
