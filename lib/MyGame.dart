import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';

enum PlayerState{
  runningDown,
  runningUp,
  runningRight,
  runningLeft,
  idleDown,
  idleUp,
  idleRight,
  idleLeft,
}

class MyGame extends FlameGame with TapDetector, KeyboardEvents {

  SpriteAnimationGroupComponent? playerAnimationComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Image image = await images.load('sprite_link_zelda.png');

    Vector2 textureSize = Vector2(96, 104);

    var mapAnimations = <PlayerState, SpriteAnimation>{
      PlayerState.idleDown: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 3, stepTime: 0.1, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*0))),
      PlayerState.idleLeft: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 3, stepTime: 0.1, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*1))),
      PlayerState.idleUp: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 1, stepTime: 0.1, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*2))),
      PlayerState.idleRight: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 2, stepTime: 0.1, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*3))),
      PlayerState.runningDown: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 10, stepTime: 0.05, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*4))),
      PlayerState.runningLeft: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 10, stepTime: 0.05, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*5))),
      PlayerState.runningUp: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 10, stepTime: 0.05, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*6))),
      PlayerState.runningRight: SpriteAnimation.fromFrameData(image, SpriteAnimationData.sequenced(amount: 10, stepTime: 0.05, textureSize: textureSize, texturePosition: Vector2(0, textureSize.y*7))),
    };

    playerAnimationComponent = SpriteAnimationGroupComponent<PlayerState>(
      animations: mapAnimations,
      current: PlayerState.runningDown,
      size: textureSize,
      position: size/2,
      anchor: Anchor.center,
    );

    add(playerAnimationComponent!);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    int index = playerAnimationComponent?.current.index + 1;
    playerAnimationComponent?.current = PlayerState.values[index>7?0:index];
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    final isKeyDown = event is RawKeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if(isSpace && isKeyDown) {
      int index = playerAnimationComponent?.current.index + 1;
      playerAnimationComponent?.current =
      PlayerState.values[index > 7 ? 0 : index];

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}