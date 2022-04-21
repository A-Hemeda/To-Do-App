// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/shared/constants/dark_theme.dart';
import 'package:todo_app/shared/constants/light_theme.dart';
import 'package:todo_app/shared/cubit/bloc_observer.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..createDatabase()
        ..changeAppMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo',
            home: HomeLayout(),

            ///Dark Theme
            darkTheme: darkTheme(context),
// The Default Theme
            theme: lightTheme(context),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
