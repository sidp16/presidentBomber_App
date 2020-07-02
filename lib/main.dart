import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:presidentbomber/constants.dart';
import 'package:presidentbomber/views/PlayerGameScreen.dart';
import 'package:presidentbomber/views/OwnerGameScreen.dart';
import 'package:presidentbomber/widgets/buttons.dart';

import 'common_utils.dart';

final wordPair = WordPair.random();

void main() {
  runApp(MaterialApp(
    title: APP_TITLE,
    home: MyApp(),
  ));
}

checkifEmpty(String text) {
  if (text.length == 0) {
    return true;
  }
  return null;
}

class Routes {
  static const String playerPage = '/player';
  static const String ownerPage = '/owner';
  static const String homePage = '/home';
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool pressed = false;
  String currentGameId = NO_GAME_ID_MESSAGE;
  final gameIdTextFieldController = TextEditingController();
  final nameTextFieldController = TextEditingController();

  final db = Firestore.instance;

  _updateData() async {
    print(gameIdTextFieldController.text);
    await db
        .collection(COLLECTION_NAME)
        .document(gameIdTextFieldController.text)
        .updateData({
      PLAYERS: FieldValue.arrayUnion([nameTextFieldController.text])
    });
  }

  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    bool _validate = false;

    return MaterialApp(
        routes: {
          Routes.playerPage: (BuildContext context) =>
              PlayerGameScreen(
                  gameIdTextFieldController.text, nameTextFieldController.text),
          Routes.ownerPage: (BuildContext context) =>
              OwnerGameScreen(
                  gameIdTextFieldController.text, nameTextFieldController.text),
          Routes.homePage: (BuildContext context) => MyApp(),
        },
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(APP_TITLE),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Colors.blue, Colors.red])),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                          child: Text("President and Bomber!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 35, color: Colors.white)))),
                  ListTile(
                      title: Text("Home",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20))),
                  ListTile(
                      title: Text("Rules",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20))),
                  ListTile(
                      title: Text("Characters",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20))),
                  ListTile(
                      title: Text("About us",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20))),
                  ListTile(
                      title: Text("Report",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection(COLLECTION_NAME)
                    .document(currentGameId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(child: CreateGameButton(onPressed: () {
                              String gameId = wordPair.asPascalCase;
                              setState(() {
                                pressed = true;
                                currentGameId = gameId;
                              });
                              createGame(gameId, nameTextFieldController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OwnerGameScreen(
                                              gameId,
                                              nameTextFieldController.text)));
                            })),
                            Container(
                              child: RaisedButton.icon(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: () {
                                  _updateData();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlayerGameScreen(
                                                  gameIdTextFieldController
                                                      .text,
                                                  nameTextFieldController
                                                      .text)));
                                  if (snapshot.data[PLAYERS].indexOf(
                                      nameTextFieldController.text) ==
                                      0) {
                                    _updateData();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OwnerGameScreen(
                                                    gameIdTextFieldController
                                                        .text,
                                                    nameTextFieldController
                                                        .text)));
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                                label: Text(
                                  JOIN_GAME_BUTTON_MESSAGE,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                            Container(
                              child: ClearButton(
                                  gameIdTextFieldController:
                                  gameIdTextFieldController,
                                  nameIdTextFieldController:
                                  nameTextFieldController),
                            ),
                          ]),
                      Text(""),
                      Text(pressed ? currentGameId : NO_GAME_ID_MESSAGE,
                          style: TextStyle(fontSize: 18)),
                      Text(""),
                      Container(
                          child: TextField(
                            controller: gameIdTextFieldController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,
                                    color: Colors.grey, size: 20),
                                border: OutlineInputBorder(),
                                labelText: JOIN_GAME_TEXT_FIELD_HINT),
                            scrollPadding: EdgeInsets.all(10.0),
                          ),
                          width: 200),
                      Text(""),
                      Container(
                          child: TextFormField(
                            controller: nameTextFieldController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person,
                                    color: Colors.grey, size: 20),
                                border: OutlineInputBorder(),
                                labelText: NAME_TEXT_FIELD_HINT,
                                errorText: nameTextFieldController.text.isEmpty
                                    ? 'Empty'
                                    : null),
                            scrollPadding: EdgeInsets.all(10.0),
                          ),
                          width: 200)
                    ],
                  );
                })));
  }
}
