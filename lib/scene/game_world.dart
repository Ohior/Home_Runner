import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:home_runner/components/player.dart';

class GameWorld extends World with HasCollisionDetection {
  final String mapName;

  GameWorld({required this.mapName}) :super();

  late final TiledComponent _tiledComponent;

  @override
  FutureOr<void> onLoad() async {
    _tiledComponent = await TiledComponent.load(mapName, Vector2.all(16));

    _initializeTileObject();

    add(_tiledComponent);
    return super.onLoad();
  }

  void _initializeTileObject() {
    final platform = _tiledComponent
        .tileMap
        .getLayer<ObjectGroup>("Platforms");
    for (final obj in platform!.objects) {
    }

    final spawnPoint = _tiledComponent
        .tileMap
        .getLayer<ObjectGroup>("SpawnPoints");

    for (final obj in spawnPoint!.objects) {
      if (obj.name == "player") {
        final player = Player(
            position: Vector2(obj.x, obj.y),
            size: Vector2(obj.width, obj.height)
        );
        add(player);
      }
    }
  }
}
