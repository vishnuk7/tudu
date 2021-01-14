import 'package:flutter/material.dart';
import 'package:todo/pages/add_todo.dart';
import 'package:todo/providers/dark_theme_provider.dart';
import 'package:todo/styles/styles.dart';
import 'package:todo/utils/constants.dart';
import 'package:circular_check_box/circular_check_box.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  MyApp() {
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Styles.themeData(false, context),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> data = [
    "ut",
    "consequuntur repellat quos",
    "consectetur dolorem voluptas",
    "est-voluptas-autem"
  ];

// Container(
//           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: _value
//                 ? Icon(
//                     Icons.check,
//                     size: 30.0,
//                     color: Colors.white,
//                   )
//                 : Icon(
//                     Icons.check_box_outline_blank,
//                     size: 30.0,
//                     color: Colors.blue,
//                   ),
//           ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
              child: Text(
                "What's Up Vishnu!",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kBlackColor1,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "TODAY'S TASKS",
                style: TextStyle(color: kDarkGrey, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 80,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              child: CircularCheckBox(
                                value: true,
                                checkColor: Colors.white,
                                activeColor: kGrey,
                                inactiveColor: Colors.blue,
                                disabledColor: Colors.blue,
                                onChanged: (bool value) {},
                              ),
                            ),
                            Text(
                              data[index],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: kWhiteColor2,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [kBoxShadowLightTheme],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
        backgroundColor: kBlue,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
