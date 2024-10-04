// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/screens/archived_tasks_screen.dart';
import 'package:todo_app/screens/done_tasks_screen.dart';
import 'package:todo_app/screens/new_tasks_screen.dart';

import '../widgets/default_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen()
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  late Database database;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  DatabaseHelper? databaseHelper;
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    databaseHelper?.createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        centerTitle: true,
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              databaseHelper?.insertToDatabase(
                  title: titleController.text,
                  date: dateController.text,
                  time: timeController.text);
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
              print('tamm aledgkhal');
            }
          } else {
            scaffoldKey.currentState!.showBottomSheet(
              (context) => Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultFormField(
                        controller: titleController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Title must not be empty';
                          }
                          return null;
                        },
                        label: 'Task Title',
                        prefix: Icons.title,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DefaultFormField(
                        controller: timeController,
                        type: TextInputType.datetime,
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeController.text =
                                value!.format(context).toString();
                            print(value.format(context));
                          });
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Time must not be empty';
                          }
                          return null;
                        },
                        label: 'Task Time',
                        prefix: Icons.timer_outlined,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DefaultFormField(
                        controller: dateController,
                        type: TextInputType.datetime,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("2050-09-30"),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!).toString();
                          });
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Date must not be empty';
                          }
                          return null;
                        },
                        label: 'Task Date',
                        prefix: Icons.calendar_today_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            );
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: 'Done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'Archived'),
          ]),
    );
  }
}
