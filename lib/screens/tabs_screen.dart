import 'package:Gymgress/screens/exerciseslist_screen.dart';
import 'package:Gymgress/screens/mybody_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPage = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': MyBodyScreen(),
        'title': 'MyBody',
      },
      {
        'page': ExercisesListScreen(),
        'title': 'Exercises',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPage]['title'],
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: _pages[_selectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        selectedItemColor: Theme.of(context).textSelectionColor,
        
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('MyBody'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Exercises'),
          ),
        ],
      ),
    );
  }
}
