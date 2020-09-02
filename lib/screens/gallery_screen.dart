import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery';

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
