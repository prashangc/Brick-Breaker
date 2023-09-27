import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

Widget ball({
  required double ballX,
  required double ballY,
  required bool hasGameStarted,
  required bool isGameOver,
}) {
  return hasGameStarted
      ? Container(
          alignment: Alignment(ballX, ballY),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
            width: 10.0,
            height: 10.0,
          ),
        )
      : isGameOver
          ? Container()
          : Container(
              alignment: Alignment(ballX, ballY),
              child: AvatarGlow(
                endRadius: 60.0,
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    radius: 7.0,
                    child: Container(
                      height: 15.0,
                      width: 15.0,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            );
}
