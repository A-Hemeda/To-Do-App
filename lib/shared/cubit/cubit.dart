// ignore_for_file: unused_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/setting_tasks/setting_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  int bottomNavigtionIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
    SettingScreen(),
  ];
  Database? database;
  List<String> titles = [
    'Todo Tasks',
    'Done Tasks',
    'Archived Tasks',
    'Setting'
  ];
  bool isBottomSheetShown = false;
  Icon floatingButtonIcon = Icon(Icons.edit);

  void changeIndex(int index) {
    bottomNavigtionIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void updateDatabase(String status, int id) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataBase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteFromDatabase(int id) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataBase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                //id integer
                //title string
                //data string
                //time string
                //status string
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) => print('Table Created'))
            .catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataBase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getDataBase(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      //print(value);
      value.forEach((element) {
        print(element['id']);
        if (element['status'] == 'New') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  inserToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES ("$title","$date","$time","New")')
          .then((value) {
        getDataBase(database);
        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());
      }).catchError((error) {
        print('Error When inserting Table ${error.toString()}');
      });
    });
  }

  void changeBottomSheetState(bool isShow, Icon icon) {
    isBottomSheetShown = isShow;
    floatingButtonIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  //Change Language
  bool isEn = true;

  Map<String, Object> textsAr = {
    "choose_lan": "اللغة",
    "ar": "عربي",
    "en": "إنجليزي",
    "setting": "الإعدادات",
    "tasks": "المهام",
    "done": "المهام المنتهية",
    "archived": "المهام المؤرشفة",
    "cancel": "إلغاء",
    "delete": "مسح",
    "add_to_task": "أضف إلى المهمات",
    "archive": "أرشـف",
    "done_tasks": "تمت",
    "add_task": "أضف مهمتك",
    "new_task": "مهمة جديدة",
    "task_time": "توقيت المهمة",
    "task_date": "تاريخ المهمة",
    "title_must_not_be_empty": "أضف إسـم المهمة",
    "time_must_not_be_empty": "أضف توقيت المهمة",
    "date_must_not_be_empty": "أضف تاريخ المهمة",
    "choose_theme": "السمة",
    "bright": "ساطع",
    "dark": "داكن",
    "there_is_no_tasks": "لا يوجد مهام لديك حاليا",
    "start_add_your_tasks": "إبدأ بإضافة مهاامك",
    "there_is_done_tasks": "لا توجد لديك مهام منتهية حاليا",
    "there_is_archived_tasks": "لا يوجد مهام مؤرشفة",
    
  };
  Map<String, Object> textsEn = {
    "choose_lan": "Language",
    "ar": "Arabic",
    "en": "ُEnglish",
    "setting": "Setting",
    "tasks": "Tasks",
    "done": "Done Tasks",
    "archived": "Archived Tasks",
    "cancel": "Cancel",
    "delete": "Delete",
    "add_to_task": "Add to tasks",
    "archive": "Archive",
    "done_tasks": "Done",
    "add_task": "Add Your Task",
    "new_task": "New Task",
    "task_time": "Task time",
    "task_date": "Task Date ",
    "title_must_not_be_empty": "Add title of task",
    "time_must_not_be_empty": "Add time of task",
    "date_must_not_be_empty": "Add date of task",
    "choose_theme": "Theme",
    "bright": "Bright",
    "dark": "Dark",
    "there_is_no_tasks": "Currently there is no any tasks",
    "start_add_your_tasks": "Start add your tasks",
    "there_is_done_tasks": "Currently there is no done tasks",
    "there_is_archived_tasks": "Currently there is no archived tasks",
  };

  /*  changeLan(bool lan) async {
    isEn = lan;
   
 emit(AppChangeLanguageState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isEn", isEn);

    /*  CacheHelper.putBoolean(key: 'isEn', value: isEn).then((value) {
      emit(AppChangeLanguageState());
    }); */
  }

  getLan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isEn = preferences.getBool("isEn") ?? true;
    isEn = CacheHelper.getBoolean(key: 'isEn') ?? true;
    
    emit(AppChangeLanguageState());
  } */

  /* Object getTexts(String txt) {
    if (isEn == true) return textsEn[txt]!;
    return textsAr[txt]!;
  } */

  ///Change Language to Arabic

  void changeLan({bool? fromShared}) {
    if (fromShared != null) {
      isEn = fromShared;
      emit(AppChangeLanguageState());
    } else
      isEn = !isEn;
    CacheHelper.putBoolean(key: 'isEn', value: isEn).then((value) {
      emit(ChangeModeState());
    });
  }

  Object getTexts(String txt) {
    if (isEn == true) return textsEn[txt]!;
    return textsAr[txt]!;
  }

  /////End of  //Change Language
  ///
  ///Change Theme Mode to Dark
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else
      isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(ChangeModeState());
    });
  }
}
