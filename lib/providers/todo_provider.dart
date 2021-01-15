import 'package:flutter/cupertino.dart';
import 'package:todo/services/todo_preference.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class Todo {
  String id;
  String title;
  bool completed;

  Map toJson() => {'id': id, 'title': title, 'completed': completed};
}

class TodoProvider with ChangeNotifier {
  TodoProvider() {}

  var _todos = List<Todo>();

  List<Todo> get todos => _todos;

  TodoPreferences todoPreferences = new TodoPreferences();

  void setTodos(String title) {
    var _todo = new Todo();
    _todo.id = Uuid().v4();
    _todo.title = title;
    _todo.completed = false;
    print(_todo.title);
    _todos.add(_todo);
    todoPreferences.setTodo(jsonEncode(_todos));
    notifyListeners();
  }

  void toggleCompleted(var data) {
    data.completed = !data.completed;
    notifyListeners();
  }

  void deleteTodo(String id) {
    for (int i = 0; i < this._todos.length; i++) {
      if (this._todos[i].id == id) {
        this._todos.removeAt(i);
        break;
      }
    }

    notifyListeners();
  }
}
