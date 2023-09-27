import 'package:flutter/material.dart';

Widget tapToPlay({
  required bool hasGameStarted,
  required bool isGameOver,
}) {
  return hasGameStarted
      ? Container()
      : isGameOver
          ? Container()
          : Container(
              alignment: const Alignment(0, 0.2),
              child: Text(
                'Tap To Play',
                style: TextStyle(color: Colors.deepPurple[400]),
              ),
            );
}
