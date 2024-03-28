import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_haptics.dart';
import '../utils/app_image.dart';
import '../home_controller.dart';
import 'draggable_item.dart';

class DraggableArea extends StatelessWidget {
 
  final bool flipX;
  final String cardName;
  final List<Color> colors;
  final controller = Get.put(HomeController());
  
  
  DraggableArea({
    super.key,
    required this.cardName,
    required this.colors,
    this.flipX = false
  });

 
  
  @override
  Widget build(BuildContext context) {

    final cardImage = cardName == 'ROCK'
        ? AppImage.rock : cardName == 'PAPER'
        ? AppImage.paper : AppImage.scissors;

    return Obx(() => Expanded(
      flex: 1,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: -50,left: 0,right: 0,
                child: IgnorePointer(
                  ignoring: controller.isDragComplete.value,
                  child: Draggable(
                    data: cardName,
                    childWhenDragging: Container(),
                    feedback: DraggableItem(image: cardImage, cardName: cardName, flipX: flipX),
                    child: DraggableItem(image: cardImage,cardName: cardName, flipX: flipX),
                    onDragCompleted: ()async{
                      await controller.player.play(AssetSource('countdown.wav'));
                      AppHaptics.mediumImpact();
                      controller.startTimer();
                      },
                  ),
                )
            ),
            Positioned(
                bottom: 16, left: 8,right: 8,
                child: Text(cardName,textAlign:TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900
                  ),
                )
            ),
          ],
        ),
      ),
    ));
  }
}
