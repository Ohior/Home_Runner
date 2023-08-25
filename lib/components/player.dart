import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:home_runner/main_game.dart';
import 'package:home_runner/utils/enum_states.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  Player({required position, required size})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    _loadAnimations();

    //add(CircleHitbox());
    return super.onLoad();
  }

  void _loadAnimations() {
    animations = {
      PlayerAnimeState.running: _getSpriteAnimation(state: "Run", frameNum: 8),
      PlayerAnimeState.idle: _getSpriteAnimation(state: "Idle", frameNum: 10),
    };
    current = PlayerAnimeState.running;
  }

  SpriteAnimation _getSpriteAnimation(
      {required String state, required int frameNum}) {
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('characters/$state 48x48.png'),
        SpriteAnimationData.sequenced(
            amount: frameNum, stepTime: 0.07, textureSize: Vector2.all(48)));
  }
}
