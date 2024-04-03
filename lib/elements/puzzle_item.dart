import 'dart:math';

import 'package:flutter/material.dart';
import 'package:magic15/providers/puzzle_provider.dart';
import 'package:provider/provider.dart';

class GameItem extends StatelessWidget {
  GameItem({
    super.key,
    required this.sideSize,
    required this.index,
    required this.order,
  });

  final double sideSize;
  final int index;
  final int order;

  // final List<String> items_backgrounds = [
  //   'assets/images/bgr-1.png',
  //   'assets/images/bgr-2.png',
  //   'assets/images/bgr-3.png'
  // ];

  // String getBackName() {
  //   return items_backgrounds[Random().nextInt(items_backgrounds.length)];
  // }

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? Container()
        : GestureDetector(
            onTap: () => Provider.of<PuzzleProvider>(context, listen: false)
                .tryToClick(order),
            child: Container(
              child: SizedBox(
                  width: sideSize,
                  height: sideSize,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: sideSize,
                        height: sideSize,
                        child: Image.asset('assets/images/item_background.png'),
                      ),
                      Opacity(
                        opacity: 0 + (index / 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: sideSize * 0.6,
                          height: sideSize * 0.6,
                          child: Image.asset('assets/images/$index.png'),
                        ),
                      ),
                    ],
                  )),
            ),
          );
  }
}
