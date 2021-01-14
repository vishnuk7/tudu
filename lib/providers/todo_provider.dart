import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  bool completed;
}

class TodoProvider with ChangeNotifier {
  var _todos = List<Todo>();

  List<Todo> get todos => _todos;

  void setTodos(String title) {
    var _todo = new Todo();
    _todo.id = Uuid().v4();
    _todo.title = title;
    _todo.completed = false;
    print(_todo.title);
    _todos.add(_todo);
    notifyListeners();
  }

  void toggleCompleted(var data) {
    data.completed = !data.completed;
    notifyListeners();
  }
}
