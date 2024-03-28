import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../home_controller.dart';

class CardFlipper extends StatelessWidget {

  CardFlipper({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => FlipCard(
      controller: controller.flipCardController,
      fill: Fill.fillBack,
      flipOnTouch: false,
      direction: FlipDirection.VERTICAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: buildCard(text: '${controller.countDown.value}', colors: const [ Color(0xFFFFBB33), Color(0xFFF94A46)]),
      back: buildCard(text: '${controller.countDown.value}', colors: const [ Color(0xFFFC9E9E), Color(0xFFAC75E5)]),
      autoFlipDuration: 1.seconds,
    ));
  }

  Widget buildCard({required String text, required colors}) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                 top: 0,left: 0, right: 0,
                child: Lottie.asset('assets/load.json', animate: controller.isStart.value)
            ),
            Positioned(
                bottom: 0,
                child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900))
                ),
          ],
        )
       ),
    );
  }
}

