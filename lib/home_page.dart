import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rock_paper_scissors/draggable_data.dart';
import 'package:rock_paper_scissors/home_controller.dart';
import 'package:rock_paper_scissors/widgets/card_flipper.dart';
import 'package:rock_paper_scissors/widgets/draggable_area.dart';
import 'package:rock_paper_scissors/widgets/target_area.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
   final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((){
          controller.selectedCard.value;
          controller.opponentCard.value;
         // controller.animation;

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 100, bottom: 310, left: 50, right: 50,
                  child: DottedBorder(
                    color: const Color(0xFF8E99A3),
                    strokeWidth: 0.7,
                    borderType: BorderType.RRect,
                    dashPattern: const [6, 6],
                    radius: const Radius.circular(24),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  )
              ),
              Positioned(
                left: 16, right: 16, bottom: 20,
                child: Row(
                  children: [
                    DraggableArea(
                      cardName: 'ROCK',
                      flipX: true,
                      colors: const [
                        Color(0xFF829AAF),
                        Color(0xFF8E99A3),
                        Color(0xFF8E99A3),
                        Color(0xFF747C82),
                      ],
                    ),
                    const SizedBox(width: 8),
                    DraggableArea(
                      cardName: 'PAPER',
                      colors: const [
                        Color(0xFFFFBB33),
                        Color(0xFFF94A46),
                      ],
                    ),
                    const SizedBox(width: 8),
                    DraggableArea(
                      cardName: 'SCISSORS',
                      colors: const [
                        Color(0xFFFC9E9E),
                        Color(0xFFAC75E5)
                      ],
                    ),
                  ],
                ),
              ),
              ///.............Opponent Card..
              Positioned(
                  top: 40,
                  child: TargetArea(
                     child: controller.countDown.value > 0
                         ? CardFlipper()
                         : SlideTransition(position: controller.itemAnimation,
                             child:controller.opponentCard.value
                    )
                  )
              ),
              ///.............Selected Card..
              Positioned(
                  bottom: 250,
                  child: DragTarget(
                    onAccept: (String data) {
                      switch (data) {
                        case 'ROCK':
                          controller.selectedCard(DraggableData.draggableItemList[0]);
                          break;
                        case 'PAPER':
                          controller.selectedCard(DraggableData.draggableItemList[1]);
                          break;
                        case 'SCISSORS':
                          controller.selectedCard(DraggableData.draggableItemList[2]);
                          break;
                        default:
                      }
                    },
                    builder: (context, accept, reject) {
                      return TargetArea(
                          child: Hero(
                              tag: 'card',
                              child: controller.selectedCard.value
                          )
                      );
                    },
                  )
              ),
            ],
          );
        }),
      ),
    );
  }

}



// animate()
//     .shimmer(delay : 400.ms, duration: 1800.ms)
//     .shake(hz:4, curve: Curves.easeInOutCubic)
//     .scaleXY(end: 1.3, duration: 600.ms)
//     .then(delay: 600.ms)
//     .scaleXY(end: 1/1.1)