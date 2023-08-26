import 'package:flame/effects.dart';
import 'package:vector_math/vector_math_64.dart';

class ObjectPositionProvider extends PositionProvider {
  ObjectPositionProvider({required this.position}) : super();
  @override
  Vector2 position;
}
