import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rock_paper_scissors/widgets/draggable_item.dart';

import 'home_controller.dart';

class ResultView extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    if(controller.isWin.value) {controller.winSound();}
    if(controller.isLose.value) {controller.loseSound();}

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          controller.resetPlay();
          return Future.value(true);},
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 100,
                child: Hero(
                  tag: 'card',
                  child: DraggableItem(
                    hwSize: 150,
                    image: controller.selectedCard.value.image,
                    cardName: controller.selectedCard.value.cardName,
                  ).animate()
                      .shimmer(delay : 400.ms, duration: 1800.ms)
                      .shake(hz:4, curve: Curves.easeInOutCubic)
                      .scaleXY(end: 1.3, duration: 600.ms)
                      .then(delay: 600.ms)
                      .scaleXY(end: 1/1.1),
                )
            ),

              if(controller.isWin.value)...[
                Positioned(
                  top: 0,left: 0,right: 0,bottom: 280,
                  child: Lottie.asset('assets/cel1.json')
              ),
                Positioned(
                    top: 0,left: 0,right: 0,bottom: 0,
                    child: Lottie.asset('assets/cel2.json')
                ),
                Positioned(
                top: 0,left: 0,right: 0,
                child: Lottie.asset('assets/cel2.json')
            ),
                const Positioned(
                    left: 0,right: 0,bottom: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Congratulation',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.amber),),
                        Text('YOU WIN!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                      ],
                    )
                ),
              ],
              if(controller.isLose.value)...[
                Positioned(
                    top: 280,left: 0,right: 0,bottom: 280,
                    child: Lottie.asset('assets/fail.json')
                ),
                const Positioned(
                    left: 0,right: 0,bottom: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Oops! You Lose',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.amber),),
                        Text('Better Luck For Next Time',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                      ],
                    )
                ),
              ],

              Positioned(
                bottom: 60, left: 16,right: 16,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text('Play Again',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green.shade100,
                            ),
                            child: IconButton(onPressed: (){
                              Get.back();
                              controller.resetPlay();
                              }, icon: const Icon(Icons.play_arrow_rounded,size: 40,color: Colors.green,))),
                        Container(height: 50,width: 2, color: Colors.blueGrey, margin: const EdgeInsets.symmetric(horizontal: 16)),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blueGrey.shade100,
                            ),
                            child: IconButton(onPressed: (){}, icon: const Icon(Icons.keyboard_return,size: 40,color: Colors.blueGrey,))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
