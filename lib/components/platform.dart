import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlatForm extends PositionComponent with CollisionCallbacks{
  PlatForm({required position, required size})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    await add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }
}
