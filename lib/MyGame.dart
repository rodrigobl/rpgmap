import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

class MyGame extends FlameGame with HasTappables {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Image image = await images.load('sprite_link_zelda.png');

    Vector2 textureSize = Vector2(96, 104);

    SpriteAnimation playerAnimation = SpriteAnimation.fromFrameData(
        image,
        SpriteAnimationData.sequenced(
            amount: 10,
            stepTime: 0.05,
            textureSize: textureSize,
            texturePosition: Vector2(0, textureSize.y*4),
        ),
    );

    SpriteAnimationComponent player = SpriteAnimationComponent()
      ..animation = playerAnimation
      ..size = textureSize
      ..position = Vector2.all(50);

    add(player);
  }
}