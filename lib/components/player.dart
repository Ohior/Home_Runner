import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:home_runner/components/platform.dart';
import 'package:home_runner/main_game.dart';
import 'package:home_runner/utils/enum_states.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  final Vector2 _up = Vector2(0, -1);

  Player({required position, required size})
      : super(position: position, size: size);

  final Vector2 _velocity = Vector2.zero();
  final double _moveSpeed = 200;
  int _hAxisInput = 0;
  final double _gravity = 10;
  final double _jumpSpeed = 320;
  static bool jumpInput = false;
  static bool _isOnGround = false;

  @override
  FutureOr<void> onLoad() async {
    _loadAnimations();

    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _velocity.x = _hAxisInput * _moveSpeed;
    _velocity.y += _gravity;

    if(jumpInput){
      if(_isOnGround){
      _velocity.y = -_jumpSpeed;
        _isOnGround = false;
      }
      jumpInput = false;
    }
    _velocity.y = _velocity.y.clamp(-_jumpSpeed, 150);

    position += _velocity * dt;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlatForm) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;
        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x/2) - collisionNormal.length;

        collisionNormal.normalize();
        if(_up.dot(collisionNormal) > 0.9){
          _isOnGround = true;
        }

        position += collisionNormal.scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
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
