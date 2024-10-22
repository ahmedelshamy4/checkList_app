import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final Color color;
  final double size;
  final SpinKitType type;

  CustomLoader({super.key,
    this.color = Colors.blue, // Default color
    this.size = 50.0,         // Default size
    this.type = SpinKitType.circle, // Default spinner type
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SpinKitType.circle:
        return SpinKitCircle(
          color: color,
          size: size,
        );
      case SpinKitType.fadingCircle:
        return SpinKitFadingCircle(
          color: color,
          size: size,
        );
      case SpinKitType.pulse:
        return SpinKitPulse(
          color: color,
          size: size,
        );
      case SpinKitType.chasingDots:
        return SpinKitChasingDots(
          color: color,
          size: size,
        );
      default:
        return SpinKitCircle(
          color: color,
          size: size,
        );
    }
  }
}

enum SpinKitType {
  circle,
  fadingCircle,
  pulse,
  chasingDots,
}
