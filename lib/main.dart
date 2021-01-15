import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/pages/add_todo.dart';
import 'package:todo/providers/dark_theme_provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/styles/styles.dart';
import 'package:todo/utils/constants.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DarkThemeProvider>(
          create: (_) => DarkThemeProvider()),
      ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider darkThemeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getTheme();
    // getTodos();
  }

  // getTodos() async{
  //   var data =
  // }

  Future<Null> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    darkThemeProvider.darkTheme = prefs.getBool("THEMESTATUS");
    print(darkThemeProvider.darkTheme);
  }

  @override
  Widget build(BuildContext context) {
    final themeChangeProvider = Provider.of<DarkThemeProvider>(context);
    print("build");
    return MaterialApp(
        title: 'Flutter Demo',
        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatelessWidget {
  // final List<String> data = [
  //   "utli",
  //   "consequuntur repellat quos",
  //   "consectetur dolorem voluptas",
  //   "est-voluptas-autem"
  // ];

  @override
  Widget build(BuildContext context) {
    final themeChangeProvider = Provider.of<DarkThemeProvider>(context);

    final todoProvider = Provider.of<TodoProvider>(context);
    int _progress = 0;
    int total = todoProvider.todos.length;

    for (int i = 0; i < todoProvider.todos.length; i++) {
      if (todoProvider.todos[i].completed) {
        _progress++;
      }
    }
    int precentageInt = 0;
    if (total != 0) {
      double precentage = (_progress / total) * 100;
      precentageInt = precentage.round();
    }
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String day = date.day.toString();
    int monthNum = date.month;
    String year = date.year.toString();
    int weekNum = date.weekday;

    var monthArry = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];

    var weekArray = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    String month = monthArry[monthNum - 1];
    String week = weekArray[weekNum - 1].toUpperCase();

    Container emptyPage() {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hey You!",
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600),
            ),
            Divider(),
            Text(
              "Are you free today",
              style: TextStyle(
                color: kDarkGrey,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
            Text("then add some new task",
                style: TextStyle(
                  color: kDarkGrey,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                )),
            Container(
              padding: EdgeInsets.only(top: 50.0),
              child: themeChangeProvider.darkTheme
                  ? SvgPicture.asset(
                      'assets/bgDark.svg',
                      height: 200.0,
                      // width: 20,
                    )
                  : SvgPicture.asset(
                      'assets/bg.svg',
                      height: 200.0,
                    ),
            ),
          ],
        ),
      );
    }

    Expanded page() {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$day",
                          style: TextStyle(
                              fontSize: 45.0, fontWeight: FontWeight.w500),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "$month",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              "$year",
                              style: TextStyle(
                                  // fontSize: .0,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      "$week",
                      style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 5.0,
                          fontWeight: FontWeight.w500,
                          color: kDarkGrey),
                    )
                  ],
                ),
              ),
            ),
            //progress bar
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progress",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "$_progress/$total",
                        style: TextStyle(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 16.0,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2500,
                    percent: _progress / total,
                    center: Text("$precentageInt%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Color(0xFF34D399),
                  ),
                ),
              ],
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
                itemCount: todoProvider.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(todoProvider.todos[index].id),
                    onDismissed: (direction) {
                      todoProvider.deleteTodo(todoProvider.todos[index].id);

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("The task was deleted")));
                    },
                    child: InkWell(
                      onTap: () {
                        todoProvider.toggleCompleted(todoProvider.todos[index]);
                      },
                      child: Container(
                          height: 80,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: CircularCheckBox(
                                    value: todoProvider.todos[index].completed,
                                    checkColor: themeChangeProvider.darkTheme
                                        ? kBlackColor1
                                        : kWhiteColor1,
                                    activeColor: kGrey,
                                    inactiveColor: Colors.blue,
                                    disabledColor: Colors.blue,
                                    onChanged: (bool value) {
                                      todoProvider.toggleCompleted(
                                          todoProvider.todos[index]);
                                    },
                                  ),
                                ),
                                Text(
                                  todoProvider.todos[index].title,
                                  style: TextStyle(
                                    // decoration:
                                    //     todoProvider.todos[index].completed
                                    //         ? TextDecoration.lineThrough
                                    //         : TextDecoration.none,
                                    decorationColor:
                                        themeChangeProvider.darkTheme
                                            ? kBlackColor1
                                            : kBlackColor1,
                                    decorationThickness: 4.0,
                                    fontSize: 18.0,
                                    // color: todoProvider.todos[index].completed
                                    //     ? kGrey
                                    //     : '',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: themeChangeProvider.darkTheme
                                ? kBlackColor2
                                : kWhiteColor2,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [kBoxShadowLightTheme],
                          )),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
          ],
        ),
      );
    }

    var renderPage = todoProvider.todos.length == 0 ? emptyPage() : page();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0),
              child: InkWell(
                onTap: () {
                  themeChangeProvider.darkTheme =
                      !themeChangeProvider.darkTheme;
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: themeChangeProvider.darkTheme
                      ? SvgPicture.asset('assets/sun.svg')
                      : SvgPicture.asset('assets/moon.svg'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
              child: Text(
                "What's Up Vishnu!",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
              ),
            ),
            renderPage
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTodo(),
            ),
          );
        },
        backgroundColor: kBlue,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
