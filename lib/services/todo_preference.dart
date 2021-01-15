import 'package:shared_preferences/shared_preferences.dart';

class TodoPreferences {
  Future<String> getTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("todos") ?? "";
  }

  setTodo(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("todos", data);
  }
}
