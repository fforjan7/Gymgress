import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../widgets/exerciseitem.dart';

class ExercisesListScreen extends StatelessWidget {
  static const routeName = '/exercisesList';

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    return ListView.separated(
        itemCount: exercises_list.length,
        padding: EdgeInsets.all(mediaQuery.size.height * 0.02),
        separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
        itemBuilder: (context, index) => ExerciseItem(
              id: exercises_list[index].id,
              name: exercises_list[index].name,
            ));
  }
}
