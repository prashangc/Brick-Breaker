import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget gameOver(
    {required BuildContext context,
    required bool isGameOver,
    required Function func}) {
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 28));
  return isGameOver
      ? Stack(
          children: [
            Container(
              alignment: const Alignment(0, -0.3),
              child: Text(
                'G A M E  O V E R',
                style: gameFont,
              ),
            ),
            Container(
              alignment: const Alignment(0, 0),
              child: GestureDetector(
                onTap: func(),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      : Container();
}
