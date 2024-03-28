import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class DraggableItem extends StatelessWidget {
  final String image;
  final String cardName;
  final bool flipX;
  final bool flipY;
  final double hwSize;
  final Color shadowColor;

  const DraggableItem({
    super.key,
    this.image = '',
    this.cardName = '',
    this.flipX = false,
    this.flipY = false,
    this.hwSize = 120.0,
    this.shadowColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return image != ''
        ? SimpleShadow(
          opacity: 0.5, // Default: 0.5
          color: shadowColor, // Default: Black
          offset: const Offset(5, 8), // Default: Offset(2, 2)
          sigma: 2.5,
              child: Transform.flip(
                  flipX: flipX, flipY: flipY,
                  child: Image.asset(image, height: hwSize, width: hwSize)
              ),
        )
        : const SizedBox();
  }
}

