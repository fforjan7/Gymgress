import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery';

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String directory;
  List images = new List();

  @override
  void initState() {
    super.initState();
    _listOfImages();
  }

  void _listOfImages() async {
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      images = io.Directory('$directory/ImageGallery/').listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: images.length > 0
          ? GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: mediaQuery.size.height * 0.01,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Image.file(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            )
          : Center(
              child: Text(
                'Gallery is empty',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25.0,
                ),
              ),
            ),
    );
  }
}
