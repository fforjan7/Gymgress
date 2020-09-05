import 'dart:io' as io;

import 'package:Gymgress/screens/newvideoscreen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/exercisescreen.dart';
import 'screens/exerciseslist_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/mybody_screen.dart';
import 'screens/newphoto_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void _createImagesDir() async {
    final io.Directory _appDocDir = await getApplicationDocumentsDirectory();
    final io.Directory _appDocDirImages =
        io.Directory('${_appDocDir.path}/ImageGallery/');
    if (await _appDocDirImages.exists()) {
      return;
    } else {
      await _appDocDirImages.create(recursive: true);
    }
  }


  void _createVideosDir() async {
    final io.Directory _appDocDir = await getApplicationDocumentsDirectory();
    final io.Directory _appDocDirImages =
        io.Directory('${_appDocDir.path}/VideoGallery/');
    if (await _appDocDirImages.exists()) {
      return;
    } else {
      await _appDocDirImages.create(recursive: true);
    }
  }

  @override
  void initState() { 
    super.initState();
    _createImagesDir();
    _createVideosDir();
  }

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
        ExercisesListScreen.routeName: (ctx) => ExercisesListScreen(),
        NewPhotoScreen.nameRoute: (ctx) => NewPhotoScreen(),
        GalleryScreen.routeName: (ctx) => GalleryScreen(),
        ExerciseScreen.routeName: (ctx) => ExerciseScreen(),
        NewVideoScreen.nameRoute:(ctx) => NewVideoScreen(),
      },
    );
  }
}
