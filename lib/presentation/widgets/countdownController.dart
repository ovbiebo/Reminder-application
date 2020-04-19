import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';

class CountdownController extends FlareController {
  Duration t;
  double x = 0;
  FlutterActorArtboard _artboard;
  ActorAnimation animation;

  final actualCountdownAnimationLength = 6;

  CountdownController(Duration duration, double offset) {
    t = duration;
    x = offset * actualCountdownAnimationLength;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _artboard = artboard;
    animation = artboard.getAnimation("countdown");
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    x += elapsed / (t.inSeconds / actualCountdownAnimationLength);
    animation.apply(x, _artboard, 1.0);

    return true;
  }
}
