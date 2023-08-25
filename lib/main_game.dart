import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:home_runner/components/player.dart';
import 'package:home_runner/scene/game_world.dart';

class MainGame extends FlameGame with TapDetector, HasCollisionDetection{
  late final CameraComponent _cameraComponent;

  GameWorld? _gameWorld;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;
    await images.loadAllImages();
    await _loadGameWorld("map1.tmx");
    _cameraComponent = CameraComponent
        .withFixedResolution(
        width: 640,
        height: 320,
        world: _gameWorld
    );
    _cameraComponent.viewfinder.anchor = Anchor.topLeft;
    await add(_cameraComponent);
    return super.onLoad();
  }

  @override
  void onTap() {
    super.onTap();
      print('Player jump');
      Player.jumpInput = true;
  }

  Future<void> _loadGameWorld(String name) async {
    _gameWorld?.removeFromParent();
    _gameWorld = GameWorld(mapName: name);
    await add(_gameWorld!);
  }

}