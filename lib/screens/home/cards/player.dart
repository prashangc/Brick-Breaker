import 'package:flutter/material.dart';

Widget player(
    {required BuildContext context,
    required double playerX,
    required double playerWidth}) {
  return Container(
    alignment: Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
    child: Container(
      height: 10.0,
      width: MediaQuery.of(context).size.width * playerWidth / 2,
      decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    ),
  );
}
