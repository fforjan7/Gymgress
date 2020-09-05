import 'package:Gymgress/screens/exercisescreen.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final int id;
  final String name;

  ExerciseItem({this.id, this.name});

  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(ExerciseScreen.routeName, arguments: {
      'id': id,
      'name': name,
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).accentColor,
      child: Container(
        padding: EdgeInsets.all(mediaQuery.size.height * 0.02),
        child: Text(
          name,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
