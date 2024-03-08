// ignore_for_file: non_constant_identifier_names, file_names

class Todo {
  String? id;
  String? ToDotext;
  bool? isDone;

  Todo({
    required this.ToDotext,
    required this.id,
    this.isDone = false,
  });

  static List<Todo> ToDoList() {
    return [];
  }
}
