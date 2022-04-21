// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: HexColor('333739'),
      primarySwatch: Colors.cyan,
      // AppBar Theme
      appBarTheme: AppBarTheme(
          // Icon Theme
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: HexColor('333739'),
          elevation: 0.0,
          //Text theme
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily:
                AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
            fontWeight: FontWeight.bold,
          )),
      // bottomNavigationBar Theme
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
        backgroundColor: HexColor('333739'),
        unselectedItemColor: Colors.grey,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18,
          fontFamily:
              AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headline1: TextStyle(
          fontSize: 25,
          fontFamily:
              AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        headline4: TextStyle(
          fontSize: 16,
          fontFamily:
              AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
          color: Colors.grey,
        ),
        bodyText2: TextStyle(color: Colors.grey),
        // change style of done tasks
        headline6: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.white60,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily:
              AppCubit.get(context).isEn ? 'NotoSans' : 'Noto Kufi Arabic',
        ),
      ),
      // Theme of form TextField
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white10,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),

      // Theme of bottomSheetTheme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: HexColor('333739'),
      ),
      dividerTheme: DividerThemeData(color: Colors.grey),
      // color of task item frame
      shadowColor: Colors.white70);
}
