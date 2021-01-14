import 'package:shared_preferences/shared_preferences.dart';

class TodoPreferences {
  setTodo(string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
