import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database database;

  Future<void> createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        print('Database Created');
        await db.execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date INTEGER, time TEXT, status TEXT)');
        print('Table created');
      },
      onOpen: (db) {
        print('Database opened');
      },
    );
  }

  Future<void> insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((action) {
      action.rawInsert(
          'INSERT INTO Tasks(title,time , date, status) VALUES("$title", $time, "$date", "done")');
      print('added successfully');
      return Future.value();
    });
  }
}




  // void createDatabase() async {
  //   //var databasesPath = await getDatabasesPath();
  //   // String path = join(databasesPath, 'todo.db');
  //   var database = await openDatabase(
  //     'todoo.db',
  //     version: 1,
  //     onCreate: (db, version) async {
  //       print('Database Created');
  //       await db.execute(
  //           'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date INTEGER, time TEXT, status TEXT)');
  //       print('table created');
  //     },
  //     onOpen: (db) {
  //       print('Database opened');
  //     },
  //   );
  // }