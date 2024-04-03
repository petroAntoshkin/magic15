import 'dart:math';

import 'package:flutter/material.dart';

class PuzzleLogic{

  static List<int> generateField([int size = 4]) {

    int _zeroIndex = 0;
    int _zeroRow = 0;

    List<int> _simpleGeneration(){
      List<int> startList = [], randList = [];
      startList = List.generate(size * size, (index) => index);

      while (startList.isNotEmpty) {
        randList.add(startList.removeAt(Random().nextInt(startList.length)));
        if(randList.last == 0) _zeroIndex = randList.length - 1;
      }
      return randList;
    }

    List<int> resultList = _simpleGeneration();

    int _countInversions(){
      int inversions = 0;
      for(int i = 0; i < resultList.length; i++){
        for (int j = i + 1; j < resultList.length; j++) {
          if (resultList[i] != 0 &&
              resultList[j] != 0 &&
              resultList[i] > resultList[j]) {
            inversions++;
          }
        }
      }
      return inversions;
    }

    bool _solvability(){
      _zeroRow = (_zeroIndex / 4).truncate();
      if(_countInversions().isOdd) return _zeroRow.isEven;
      return _zeroRow.isOdd;
    }

    while(!_solvability()){
      resultList = _simpleGeneration();
    }
    return resultList;
  }

}