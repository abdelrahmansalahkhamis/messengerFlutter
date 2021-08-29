import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:messenger_app_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:messenger_app_flutter/modules/new_tasks/new_task_screen.dart';
import 'package:messenger_app_flutter/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = [
    'New Task',
    'Done Tasks',
    'Archived Tasks',
  ];

  int currentindex = 0;

  void changeIndex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('ERROR WHEN CREATING TABLE ${error.toString()}');
      });
    }, onOpen: (database) {
      print('getting data from database:');
      print('$database');
      getDataFromDatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
      return value;
    });
  }

  insertIntoDatabase(
    @required String title,
    @required String date,
    @required String time,
  ) async {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfuly');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error inserting to database');
      });
      //return null;
      return Future<Null>(() {});
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      //newTasks = value;
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
          print('added to new tasks');
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
          print('added to new tasks');
        } else {
          archivedTasks.add(element);
        }

        print(element['status']);
      });
      emit(AppGetDatabaseState());
    });
  }

  bool isBottomSheetOpen = false;

  IconData fabIcon = Icons.edit;

  void updateData(
    @required String status,
    @required int id,
  ) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData(
    @required int id,
  ) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeBottomSheetState(
    @required bool isShow,
    @required IconData icon,
  ) {
    isBottomSheetOpen = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
