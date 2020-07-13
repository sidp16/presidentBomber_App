import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presidentbomber/buttons/clear_button.dart';
import 'package:presidentbomber/buttons/create_game.dart';
import 'package:presidentbomber/buttons/join_game_button.dart';
import 'package:presidentbomber/constants.dart';
import 'package:presidentbomber/fields/text_fields.dart';
import 'package:presidentbomber/views/drawer/drawers.dart';
import 'package:presidentbomber/views/messages/no_gameid_message.dart';
import 'package:presidentbomber/views/screens/OwnerGameScreen.dart';
import 'package:presidentbomber/views/screens/PlayerGameScreen.dart';

import 'utils.dart';

void main() {
  runApp(MaterialApp(
    title: APP_TITLE,
    home: MyApp(),
  ));
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
  final GlobalKey<FormState> _gameIdFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final wordPair = WordPair.random();

    return MaterialApp(
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
            drawer: HomeScreenDrawer(),
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection(COLLECTION_NAME)
                    .document(currentGameId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return _buildContent(wordPair, context, snapshot);
                })));
  }

  Column _buildContent(
      WordPair wordPair, BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      children: <Widget>[
        buildUtilityButtons(wordPair, context, snapshot),
        NoGameIDMessage(pressed: pressed, currentGameId: currentGameId),
        Form(
            key: _nameFormKey,
            child: NameTextField(
                nameTextFieldController: nameTextFieldController)),
        Form(
          key: _gameIdFormKey,
          child: Column(
            children: [
              GameIDTextField(
                  gameIdTextFieldController: gameIdTextFieldController),
            ],
          ),
        ),
      ],
    );
  }

  Row buildUtilityButtons(
      WordPair wordPair, BuildContext context, AsyncSnapshot snapshot) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(child: CreateGameButton(onPressed: () {
            validateFieldAndCreateGame(wordPair);
          })),
          Container(
            child: JoinGameButton(onPressed: () {
              validateFieldsAndJoinGame();
            }),
          ),
          ClearButton(
              gameIdTextFieldController: gameIdTextFieldController,
              nameIdTextFieldController: nameTextFieldController),
        ]);
  }

  void validateFieldAndCreateGame(WordPair wordPair) {
    if (!_nameFormKey.currentState.validate()) {
      gameIdTextFieldController.clear();
      _gameIdFormKey.currentState.reset();
      return;
    }

    String gameId = wordPair.asPascalCase;
    setState(() {
      pressed = true;
      currentGameId = gameId;
    });

    gameIdTextFieldController.clear();
    _gameIdFormKey.currentState.reset();
    _nameFormKey.currentState.save();
    createGame(gameId, nameTextFieldController.text.trim());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OwnerGameScreen(
                currentGameId, nameTextFieldController.text.trim())));
  }

  void validateFieldsAndJoinGame() {
    if (!_gameIdFormKey.currentState.validate() &&
        !_nameFormKey.currentState.validate()) {
      return;
    }
    _gameIdFormKey.currentState.save();
    _nameFormKey.currentState.save();
    addPlayerToGame(gameIdTextFieldController.text.trim(),
        nameTextFieldController.text.trim());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlayerGameScreen(
                  gameIdTextFieldController.text.trim(),
                  nameTextFieldController.text.trim(),
                )));
  }
}
