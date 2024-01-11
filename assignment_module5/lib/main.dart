import 'package:assignment_module5/screens/display_list_screen.dart';
import 'package:assignment_module5/theme.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: DisplayListScreen()
    );
  }
}
