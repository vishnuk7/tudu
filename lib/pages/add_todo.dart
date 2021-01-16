import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/dark_theme_provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/utils/constants.dart';

class AddTodo extends StatelessWidget {
  // final TodoProvider todoProvider;

  // AddTodo({Key key, @required this.todoProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController todoController = new TextEditingController();

    final todoProvider = Provider.of<TodoProvider>(context);

    final themeChangeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 50.0,
                width: 50.0,
                child: Icon(
                  Icons.close,
                  color: themeChangeProvider.darkTheme
                      ? kWhiteColor1
                      : kBlackColor1,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey, width: 1.0),
                  borderRadius: BorderRadius.circular(50.0),
                  color: themeChangeProvider.darkTheme
                      ? kBlackColor2
                      : kWhiteColor1,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(40.0),
            child: TextFormField(
              controller: todoController,
              autofocus: true,
              cursorHeight: 40,
              cursorWidth: 3,
              cursorColor: kBlue,
              style: TextStyle(fontSize: 25.0),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter new Task',
                  hintStyle: TextStyle(
                    fontSize: 25.0,
                    color: kLightGrey,
                  )),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (todoController.text != "") {
            todoProvider.setTodos(todoController.text);
            Navigator.of(context).pop();
          }
        },
        backgroundColor: kBlue,
        label: Text('New Task'),
        tooltip: 'Increment',
        icon: Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}
