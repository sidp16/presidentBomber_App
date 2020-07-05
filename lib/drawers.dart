import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presidentbomber/drawerTiles.dart';
import 'package:presidentbomber/text_fields.dart';
import 'package:presidentbomber/views/OwnerGameScreen.dart';
import 'package:presidentbomber/views/RulesCharactersScreen.dart';

import 'main.dart';

class PlayerOwnerDrawer extends StatelessWidget {
  const PlayerOwnerDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/president.png',
                                width: 90, height: 90),
                          )),
                      Material(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/bombpic.png',
                                width: 90, height: 90),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('President & Bomber',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800)),
                  )
                ],
              )),
          CustomListTile(
              Icons.home,
              'Home',
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))
                  }),
          CustomListTile(
              Icons.person,
              'Characters',
              () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CharacterRulesScreen()))
                  }),
          CustomListTile(
              Icons.library_books,
              'Rules',
              () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CharacterRulesScreen()))
                  }),
          CustomListTile(Icons.build, 'App Usage', () => {}),
          CustomListTile(Icons.accessibility, 'About Me', () => {}),
          CustomListTile(Icons.report_problem, 'Report', () => {}),
        ],
      ),
    );
  }
}

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/president.png',
                                width: 90, height: 90),
                          )),
                      Material(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/bombpic.png',
                                width: 90, height: 90),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('President & Bomber',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800)),
                  )
                ],
              ))),
          CustomListTile(
              Icons.person,
              'Characters',
              () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CharacterRulesScreen()))
                  }),
          CustomListTile(
              Icons.library_books,
              'Rules',
              () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CharacterRulesScreen()))
                  }),
          CustomListTile(Icons.build, 'App Usage', () => {}),
          CustomListTile(Icons.accessibility, 'About Me', () => {}),
          CustomListTile(Icons.report_problem, 'Report', () => {}),
        ],
      ),
    );
  }
}

class CharacterRulesDrawer extends StatelessWidget {
  const CharacterRulesDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/president.png',
                                width: 90, height: 90),
                          )),
                      Material(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/bombpic.png',
                                width: 90, height: 90),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('President & Bomber',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800)),
                  )
                ],
              )),
          CustomListTile(
              Icons.home,
              'Home',
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))
                  }),
          CustomListTile(Icons.build, 'App Usage', () => {}),
          CustomListTile(Icons.accessibility, 'About Me', () => {}),
          CustomListTile(Icons.report_problem, 'Report', () => {}),
        ],
      ),
    );
  }
}