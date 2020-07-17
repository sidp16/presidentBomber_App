import 'package:flutter/material.dart';
import 'package:presidentbomber/constants.dart';

class DistributeButton extends StatelessWidget {
  final String gameId;
  final Function onPressed;

  DistributeButton({
    this.gameId,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 180.0,
      child: RaisedButton(
        color: Colors.green,
        splashColor: Colors.lightGreen,
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            DISTRIBUTE_ROLES_BUTTON_TEXT,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
