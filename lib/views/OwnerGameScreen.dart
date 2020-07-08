import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presidentbomber/constants.dart';
import 'package:presidentbomber/drawers.dart';
import 'package:presidentbomber/widgets/buttons.dart';

import '../text_on_screen.dart';

class OwnerGameScreen extends StatefulWidget {
  final String gameId;
  final String name;

  OwnerGameScreen(this.gameId, this.name);

  @override
  _OwnerGameScreenState createState() => _OwnerGameScreenState();
}

class _OwnerGameScreenState extends State<OwnerGameScreen> {
  Timer _timer;
  int _counter = 300;

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter >= 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.gameId} | Owner Console"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.red])),
        ),
      ),
      drawer: PlayerOwnerDrawer(),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(COLLECTION_NAME)
            .document(this.widget.gameId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlueHostageButton(widget.gameId, snapshot.data[ROLES],
                        snapshot.data[PLAYERS]),
                    Container(
                      height: 103,
                      child: DistributeButton(
                          widget.gameId,
                          widget.name,
                          snapshot.data[ROLES],
                          snapshot.data[PLAYERS],
                          snapshot.data[DISTRIBUTIONS][widget.name]),
                    ),
                    RedHostageButton(widget.gameId, snapshot.data[ROLES],
                        snapshot.data[PLAYERS]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SniperButton(gameId: widget.gameId),
                    GamblerButton(gameId: widget.gameId),
                    MastermindButton(gameId: widget.gameId),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TargetButton(gameId: widget.gameId),
                    HeroButton(gameId: widget.gameId),
                    DecoyButton(gameId: widget.gameId),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HotPotatoButton(gameId: widget.gameId),
                    AnarchistButton(gameId: widget.gameId),
                    TravelerButton(gameId: widget.gameId),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClearRolesButton(gameId: widget.gameId),
                    LeaveGameButton(widget.gameId, widget.name),
                    RaisedButton(
                      onPressed: () => _startTimer(),
                      child: Text("Start"),
                    ),
                  ],
                ),
              ),
              RolesLobbyMessage(snapshot.data[PLAYERS], snapshot.data[ROLES]),
              PlayersListMessage(snapshot.data[PLAYERS]),
              RolesListMessage(snapshot.data[ROLES]),
              UniqueRoleMessage(
                  snapshot.data[DISTRIBUTIONS][widget.name], widget.name),
              StreamBuilder(
                stream: Firestore.instance
                    .collection(COLLECTION_NAME)
                    .document(this.widget.gameId)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data['gameEnd'].toDate()
                        .difference(DateTime.now())
                        .inSeconds
                        .toString(), style: TextStyle(fontSize: 20),),
                  );
                }
              )
//              (_counter > 0)
//                  ? Text("")
//                  : Text(
//                      "DONE!",
//                      style: TextStyle(
//                        color: Colors.green,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 10,
//                      ),
//                    ),
//              Text('$_counter',
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 30,
//                  )),
            ],
          );
        },
      ),
    );
  }
}
