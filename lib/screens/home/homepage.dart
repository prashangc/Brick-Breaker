import 'dart:async';
import 'package:brick_breaker/screens/home/cards/ball.dart';
import 'package:brick_breaker/screens/home/cards/bricks.dart';
import 'package:brick_breaker/screens/home/cards/game_over.dart';
import 'package:brick_breaker/screens/home/cards/player.dart';
import 'package:brick_breaker/screens/home/cards/tap_to_play.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Direction { up, down, left, right }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ball varaibles
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.01;
  double ballYIncrement = 0.01;
  var ballYDirection = Direction.down;
  var ballXDirection = Direction.left;

  //game settings
  bool hasGameStarted = false;
  bool isGameOver = false;

  //player varaibles
  double playerX = -0.2;
  double playerWidth = 0.4;

  // brick varaibles
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.2;
  static int numberOfBricksInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);
  List myBricks = [
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false]
  ];

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // update direction
      updateDirection();
      // move ball
      moveBall();

      // check is player is dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      // check if the brick is hit
      checkForBrokenBricks();
    });
  }

  checkForBrokenBricks() {
    // checks for brick when ball hits bottom of the brick
    for (int i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY <= myBricks[i][1] + brickHeight &&
          myBricks[i][2] == false) {
        setState(() {
          myBricks[i][2] = true;
          double leftSideDist = (myBricks[i][0] - ballX).abs();
          double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
          double topSideDist = (myBricks[i][1] - ballY).abs();
          double bottomSideDist = (myBricks[i][1] + brickHeight - ballY).abs();
          String min = findMin(
            leftSideDist,
            rightSideDist,
            topSideDist,
            bottomSideDist,
          );
          switch (min) {
            case 'left':
              ballXDirection = Direction.left;
              break;
            case 'right':
              ballXDirection = Direction.right;
              break;
            case 'up':
              ballYDirection = Direction.up;
              break;
            case 'down':
              ballYDirection = Direction.down;
              break;
          }
        });
      }
    }
  }

  String findMin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];

    double currentMin = a;

    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }
    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'up';
    } else {
      return 'down';
    }
  }

  void moveBall() {
    setState(() {
      // move horizontally
      if (ballXDirection == Direction.left) {
        ballX -= ballXIncrement;
      } else if (ballXDirection == Direction.right) {
        ballX += ballXIncrement;
      }
      // move vertically
      if (ballYDirection == Direction.down) {
        ballY += ballYIncrement;
      } else if (ballYDirection == Direction.up) {
        ballY -= ballYIncrement;
      }
    });
  }

  void updateDirection() {
    setState(() {
      // ball goes up when hits player
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      }
      // ball goes down when hits top of the screen
      else if (ballY <= -1) {
        ballYDirection = Direction.down;
      }
      // ball goes left when it hits right wall
      if (ballX >= 1) {
        ballXDirection = Direction.left;
        // ball goes right when it hits left wall
      } else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;
      myBricks = [
        [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false]
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
              child: Stack(
            children: [
              tapToPlay(
                hasGameStarted: hasGameStarted,
                isGameOver: isGameOver,
              ),
              gameOver(
                context: context,
                isGameOver: isGameOver,
                func: resetGame,
              ),
              ball(
                ballX: ballX,
                ballY: ballY,
                hasGameStarted: hasGameStarted,
                isGameOver: isGameOver,
              ),
              player(
                  context: context, playerX: playerX, playerWidth: playerWidth),
              bricks(
                context: context,
                brickX: myBricks[0][0],
                brickY: myBricks[0][1],
                brickWidth: brickWidth,
                brickHeight: brickHeight,
                isBrickBroken: myBricks[0][2],
              ),
              bricks(
                context: context,
                brickX: myBricks[1][0],
                brickY: myBricks[1][1],
                brickWidth: brickWidth,
                brickHeight: brickHeight,
                isBrickBroken: myBricks[1][2],
              ),
              bricks(
                context: context,
                brickX: myBricks[2][0],
                brickY: myBricks[2][1],
                brickWidth: brickWidth,
                brickHeight: brickHeight,
                isBrickBroken: myBricks[2][2],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
