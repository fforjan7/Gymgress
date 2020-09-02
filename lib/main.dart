import 'dart:io';

import 'package:Gymgress/screens/gallery_screen.dart';
import 'package:flutter/material.dart';

import 'screens/exercises_screen.dart';
import 'screens/mybody_screen.dart';
import 'screens/newphoto_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  new Directory('Gallery').create()
    .then((Directory directory) {
      print(directory.path);
  });

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gymgress',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfff2f2f2),
        primaryColor: Color(0xffcccccc),
        accentColor: Color(0xff404040),
        errorColor: Color(0xffff0000),
        primarySwatch: Colors.blue,
        textSelectionColor: Color(0xff1919ff),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff1919ff),
          ),
        ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(),
        MyBodyScreen.routeName: (ctx) => MyBodyScreen(),
        ExercisesScreen.routeName: (ctx) => ExercisesScreen(),
        NewPhotoScreen.nameRoute: (ctx) => NewPhotoScreen(),
        GalleryScreen.routeName: (ctx) => GalleryScreen(),
      },
    );
  }
}
