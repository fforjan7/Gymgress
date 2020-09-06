import 'package:Gymgress/models/chartInfo.dart';
import 'package:flutter/material.dart';

import '../models/bodyweightinfo.dart';
import '../utils/dbhelper.dart';
import '../widgets/chart.dart';
import 'gallery_screen.dart';
import 'newphoto_screen.dart';

class MyBodyScreen extends StatefulWidget {
  static const routeName = '/myBody';

  @override
  _MyBodyScreenState createState() => _MyBodyScreenState();
}

class _MyBodyScreenState extends State<MyBodyScreen> {
  DBHelper dbBodyweightInfo;
  List<BodyweightInfo> bodyweightInfos;
  List<ChartInfo> bodyweightChartInfos;
  int _weight;

  @override
  void initState() {
    super.initState();
    dbBodyweightInfo = DBHelper();
    bodyweightInfos = [];
    bodyweightChartInfos = [];
    _refreshInfos();
  }

  void _refreshInfos() {
    dbBodyweightInfo.getBodyweightInfos().then((weightInfo) {
      setState(() {
        bodyweightInfos.clear();
        bodyweightInfos.addAll(weightInfo);
        if (bodyweightInfos.length > 0) {
          bodyweightInfos.sort((a, b) {
            return a.date.compareTo(b.date);
          });
          _weight = bodyweightInfos.last.weight;
        }
      });
      dbBodyweightInfo.getBodyweightChartInfos().then((chartInfo) {
        setState(() {
          bodyweightChartInfos.clear();
          bodyweightChartInfos.addAll(chartInfo);
        });
      });
    });
  }

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
          height: mediaQuery.size.height * 0.4,
          width: mediaQuery.size.width * 1,
          color: Theme.of(context).primaryColor,
          child: bodyweightChartInfos.length > 0
              ? Chart(
                  data: bodyweightChartInfos,
                )
              : Center(
                  child: Text(
                    'No data',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 25.0,
                    ),
                  ),
                ),
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
        SizedBox(height: mediaQuery.size.height * 0.04),
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
                _weight != null ? '$_weight' : '???',
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
                  Navigator.of(context)
                      .pushNamed(NewPhotoScreen.nameRoute)
                      .then((_) => _refreshInfos());
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
