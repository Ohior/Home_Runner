import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:home_runner/components/platform.dart';
import 'package:home_runner/components/player.dart';

class GameWorld extends World{
  final String mapName;

  GameWorld({required this.mapName}) :super();

  late final TiledComponent _tiledComponent;
  late final Rect _levelBounds;

  @override
  FutureOr<void> onLoad() async {
    _tiledComponent = await TiledComponent.load(mapName, Vector2.all(16));
    //_tiledComponent.anchor = Anchor.bottomLeft;

    _initializeTileObject();

    _levelBounds = Rect.fromLTWH(0, 0,
        (_tiledComponent.tileMap.map.width *
            _tiledComponent.tileMap.map.tileWidth).toDouble(),
        (_tiledComponent.tileMap.map.height *
            _tiledComponent.tileMap.map.tileHeight).toDouble()
    );

    add(_tiledComponent);
    return super.onLoad();
  }

  void _initializeTileObject() async {
    final platform = _tiledComponent
        .tileMap
        .getLayer<ObjectGroup>("Platforms");
    for (final obj in platform!.objects) {
      final plat = PlatForm(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height)
      );
      await add(plat);
    }

    final spawnPoint = _tiledComponent
        .tileMap
        .getLayer<ObjectGroup>("SpawnPoints");

    for (final obj in spawnPoint!.objects) {
      if (obj.name == "player") {
        final player = Player(
            position: Vector2(obj.x, obj.y),
            size: Vector2(obj.width, obj.height),
          levelBounds: _levelBounds
        );
        await add(player);
      }
    }
  }
}
