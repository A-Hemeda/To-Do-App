import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.cyan[900],
      selectedLabelStyle: TextStyle(
          fontSize: AppCubit.get(context).isEn ? 13 : 11,
          fontFamily:
              AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic'),
      unselectedLabelStyle: TextStyle(
          fontSize: AppCubit.get(context).isEn ? 12 : 10,
          fontFamily:
              AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic'),
      elevation: 90.0,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily:
            AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
        color: Colors.black54,
      ),
      headline1: TextStyle(
        fontSize: 25,
        fontFamily:
            AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
        color: Colors.cyan[900],
        fontWeight: FontWeight.w600,
      ),
      headline4: TextStyle(
        fontSize: 16,
        fontFamily:
            AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
        color: Colors.black54,
      ),
      bodyText2: TextStyle(color: Colors.grey),
      // change style of done tasks
      headline6: TextStyle(
        decoration: TextDecoration.lineThrough,
        color: Colors.grey,
        fontSize: 18,
        fontFamily:
            AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
        fontWeight: FontWeight.w600,
      ),
    ),

    // Theme of form TextField
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black12),
      labelStyle: TextStyle(color: Colors.black54),
      fillColor: Colors.black12,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black26, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),

    //Theme of BottomSheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    dividerTheme: DividerThemeData(color: Colors.black54),

    // color of task item frame
    shadowColor: Colors.grey,
  );
}
