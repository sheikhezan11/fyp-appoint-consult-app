import 'dart:ui';
import 'package:flutter/material.dart';

class CustomShadow extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double sigma;
  final Color color;
  final Offset offset;

  const CustomShadow({
    super.key,
    required this.child,
    this.opacity = 0.5,
    this.sigma = 2,
    this.color = Colors.black,
    this.offset = const Offset(2, 2),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IgnorePointer(
          child: Transform.translate(
            offset: offset,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaY: sigma,
                sigmaX: sigma,
                tileMode: TileMode.decal,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                child: Opacity(
                  opacity: opacity,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
