import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rpgmap/MyGame.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

