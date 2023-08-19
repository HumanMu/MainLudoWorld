import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';


class PlayerMovement extends FlameGame {
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;

  late SpriteAnimationComponent humanSheet;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spritSheetImages = SpriteSheet(
        image: await images.load('ludo_board.png'),
        srcSize: Vector2(48, 48)
    );
    downAnimation = spritSheetImages.createAnimation(row: 0, stepTime: .3, to: 4);
    leftAnimation = spritSheetImages.createAnimation(row: 1, stepTime: .3, to: 4);
    rightAnimation = spritSheetImages.createAnimation(row: 2, stepTime: .3, to: 4);
    upAnimation = spritSheetImages.createAnimation(row: 3, stepTime: .3, to: 4);
    idleAnimation = spritSheetImages.createAnimation(row: 0, stepTime: .3, to: 1);

    humanSheet = SpriteAnimationComponent()..animation = downAnimation
      ..position = Vector2.all(0)
      ..size = Vector2.all(100);
    add(humanSheet);
  }

}