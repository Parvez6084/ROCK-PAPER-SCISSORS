import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TargetArea extends StatelessWidget {
  final Widget? child;
  const TargetArea({super.key, this.child});


  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: const Color(0xFF8E99A3),
      strokeWidth: 0.5,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        alignment: Alignment.center,
        height: 120, width: 95,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: child,
      ),
    );
  }
}