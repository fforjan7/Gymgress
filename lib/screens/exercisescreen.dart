import 'package:Gymgress/screens/newvideoscreen.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  static const routeName = '/exercises';

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  String name;
  int id;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      id = routeArgs['id'];
      name = routeArgs['name'];
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.02),
            height: mediaQuery.size.height * 0.3,
            width: mediaQuery.size.width * 1,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                'No Data',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current PR:',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(width: mediaQuery.size.width * 0.04),
              Text(
                'Weight',
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
              
            ],
          ),

          Container(
            margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.02),
            height: mediaQuery.size.height * 0.3,
            width: mediaQuery.size.width * 1,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                'Video is not inserted',
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
            ),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(
                vertical: mediaQuery.size.height * 0.01,
                horizontal: mediaQuery.size.height * 0.04,
              ),
              child: Text(
                'Add video',
                style: TextStyle(fontSize: 25.0),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(NewVideoScreen.nameRoute);
              },
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textSelectionColor,
              elevation: 15.0,
              splashColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
