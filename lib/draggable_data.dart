import 'package:flutter/material.dart';

import 'utils/app_image.dart';
import 'widgets/draggable_item.dart';

class DraggableData {

  static const draggableItemList = [
    DraggableItem(
        hwSize: 100.0,
        flipX: true,
        cardName: 'ROCK',
        image: AppImage.rock,
        shadowColor: Colors.blueGrey),
    DraggableItem(
      hwSize: 100.0,
      cardName: 'PAPER',
      image: AppImage.paper,
      shadowColor: Colors.red,
    ),
    DraggableItem(
      hwSize: 100.0,
      cardName: 'SCISSORS',
      image: AppImage.scissors,
      shadowColor: Colors.deepPurple,
    )
  ];

  static const opponentItemList = [
    DraggableItem(
        hwSize: 100.0,
        flipY: true,
        image: AppImage.rock,
        cardName: 'ROCK',
        shadowColor: Colors.blueGrey),
    DraggableItem(
      hwSize: 100.0,
      flipY: true,
      cardName: 'PAPER',
      image: AppImage.paper,
      shadowColor: Colors.red,
    ),
    DraggableItem(
      hwSize: 100.0,
      flipY: true,
      cardName: 'SCISSORS',
      image: AppImage.scissors,
      shadowColor: Colors.deepPurple,
    )
  ];

}
