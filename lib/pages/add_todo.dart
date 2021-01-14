import 'package:flutter/material.dart';
import 'package:todo/utils/constants.dart';

class AddTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(40.0),
                child: TextFormField(
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
              ),
            ],
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: kBlue,
        label: Text('New Task'),
        tooltip: 'Increment',
        icon: Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}
