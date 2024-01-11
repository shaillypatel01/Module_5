import 'package:flutter/material.dart';

ThemeData appTheme(){
  return ThemeData(
    inputDecorationTheme: inputDecorationTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    floatingActionButtonTheme: floatingActionButtonTheme(),
    appBarTheme: appBarTheme(),
  );
}

floatingActionButtonTheme() {
  return FloatingActionButtonThemeData(
    backgroundColor: Colors.black
  );
}

appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),

  );
}

inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: Colors.black45),
    gapPadding: 10,
  );

  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30)),
        backgroundColor: MaterialStateProperty.all(Color(0xffFFDCDC)),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ));
}