import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:home_runner/components/player.dart';
import 'package:home_runner/scene/game_world.dart';

class MainGame extends FlameGame with TapDetector, HasCollisionDetection{
  late final CameraComponent cameraComponent;

  GameWorld? gameWorld;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;
    await images.loadAllImages();
    await _loadGameWorld("map1.tmx");
    cameraComponent = CameraComponent(
      world: gameWorld,
    );
    //     .withFixedResolution(
    //     width: 640,
    //     height: 320,
    //     world: gameWorld,
    // );
    camera.viewport = FixedResolutionViewport(Vector2(640, 320));
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    await add(cameraComponent);
    return super.onLoad();
  }

  @override
  void onTap() {
    super.onTap();
      print('Player jump');
      Player.jumpInput = Player.isOnGround;
  }

  Future<void> _loadGameWorld(String name) async {
    gameWorld?.removeFromParent();
    gameWorld = GameWorld(mapName: name);
    await add(gameWorld!);
  }

}