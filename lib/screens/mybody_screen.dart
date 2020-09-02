import 'package:flutter/material.dart';

import 'gallery_screen.dart';
import 'newphoto_screen.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

class MyBodyScreen extends StatelessWidget {
  static const routeName = '/myBody';

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(mediaQuery.size.height * 0.02),
          child: Text(
            'Your bodyweight progress:',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 25.0,
            ),
          ),
        ),
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: mediaQuery.size.height * 0.02),
          color: Theme.of(context).accentColor,
          height: mediaQuery.size.height * 0.4,
          width: mediaQuery.size.width * 1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.height * 0.02,
            vertical: mediaQuery.size.height * 0.04,
          ),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(
              vertical: mediaQuery.size.height * 0.01,
              horizontal: mediaQuery.size.height * 0.04,
            ),
            child: Text(
              'Gallery',
              style: TextStyle(fontSize: 25.0),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(GalleryScreen.routeName);
            },
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textSelectionColor,
            elevation: 15.0,
            splashColor: Theme.of(context).accentColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(mediaQuery.size.height * 0.02),
          child: Row(
            children: [
              Text(
                'Current weight:',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(width: mediaQuery.size.width * 0.04),
              Text(
                '65',
                style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 40.0,
                ),
              ),
              SizedBox(width: mediaQuery.size.width * 0.01),
              Container(
                height: 30,
                alignment: Alignment.bottomCenter,
                child: Text(
                  'kg',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(NewPhotoScreen.nameRoute);
                },
                backgroundColor: Theme.of(context).textSelectionColor,
                elevation: 15.0,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                ),
                splashColor: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}