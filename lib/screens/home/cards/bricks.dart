import 'package:flutter/material.dart';

Widget bricks({
  required BuildContext context,
  required double brickX,
  required double brickY,
  required double brickWidth,
  required double brickHeight,
  required bool isBrickBroken,
}) {
  return isBrickBroken
      ? Container()
      : Container(
          alignment: Alignment((2 * brickX + brickWidth), brickY),
          child: Container(
            height: MediaQuery.of(context).size.height * brickHeight / 2,
            width: MediaQuery.of(context).size.width * brickWidth / 2,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Colors.deepPurple),
          ),
        );
}
