import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rock_paper_scissors/draggable_data.dart';
import 'package:rock_paper_scissors/result_view.dart';
import 'package:rock_paper_scissors/widgets/draggable_item.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  var countDown = 5.obs;
  var isDragComplete = false.obs;
  var isWin = false.obs;
  var isLose = false.obs;
  var isStart = false.obs;

  var selectedCard = const DraggableItem().obs;
  var opponentCard = const DraggableItem().obs;

  var celebrationController = ConfettiController();
  var flipCardController = FlipCardController();

  late AnimationController animationController;
  late Animation<Offset> itemAnimation;
  var player = AudioPlayer();

  void onPlayLogic(){
    if(selectedCard.value.cardName == opponentCard.value.cardName) {
      Future.delayed(2.seconds, () {
        Get.dialog(
            AlertDialog(
              title: const Text('Match Draw'),
              content: const Text('Play Again'),
              actions: [
                TextButton(onPressed: () {
                  Get.back();
                  resetPlay();
                  }, child: const Text('Play'))
              ],
            ));
      });
      isWin.value = false;
      isLose.value = false;
    }else if(selectedCard.value.cardName == 'ROCK' && opponentCard.value.cardName == 'SCISSORS') {
      isWin.value = true;
      isLose.value = false;
    }else if(selectedCard.value.cardName == 'PAPER' && opponentCard.value.cardName == 'ROCK') {
      isWin.value = true;
      isLose.value = false;
    }else if(selectedCard.value.cardName == 'SCISSORS' && opponentCard.value.cardName == 'PAPER') {
      isWin.value = true;
      isLose.value = false;
    }else {
      isWin.value = false;
      isLose.value = true;
    }
    if(isWin.value) {
      celebrationController.play();
      Future.delayed(2.seconds, () {Get.to(() => ResultView());});
    }
    if(isLose.value) {Future.delayed(2.seconds, () {Get.to(() => ResultView());});}

  }

  void botPlaying() {
    var items = DraggableData.opponentItemList;
    var randomItem = items[Random().nextInt(items.length)];
    opponentCard.value = randomItem;
  }

  void startTimer()async {
    Future.delayed(1.seconds, () {
      if (countDown.value > 0) {
        flipCardController.toggleCard();
        isStart.value = true;
        countDown.value--;
        startTimer();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    animationController = AnimationController(vsync: this, duration: 800.milliseconds);
    itemAnimation = Tween<Offset>(begin: const Offset(0, -2), end: Offset.zero).animate(animationController);

    ever(countDown, (callback)async {
      if (countDown.value == 0) {
        await player.stop();
        botPlaying();
        isStart.value = false;
        isDragComplete.value = true;
        animationController.forward();
        onPlayLogic();
      }
    });
  }

  void winSound()async {
    player.play(AssetSource('win.mp3'));
    Future.delayed(3.seconds, () {player.stop();});
  }

  void loseSound()async {
    player.play(AssetSource('fail.mp3'));
    Future.delayed(3.seconds, () {player.stop();});
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    celebrationController.dispose();
  }

  void resetPlay() {
    countDown.value = 5;
    isDragComplete.value = false;
    selectedCard.value = const DraggableItem();
    opponentCard.value = const DraggableItem();
    celebrationController.stop();
    animationController.reset();
   // Get.back();
  }

}

