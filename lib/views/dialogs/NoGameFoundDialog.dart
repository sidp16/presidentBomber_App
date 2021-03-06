import 'package:flutter/material.dart';

class NoGameFoundAlert extends StatelessWidget {
  const NoGameFoundAlert({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Game Not Found!'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Please enter a valid ID!'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      elevation: 25.0,
      backgroundColor: Colors.white,
    );
  }
}
