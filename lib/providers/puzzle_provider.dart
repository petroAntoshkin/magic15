import 'package:flutter/material.dart';
import 'package:magic15/bloc/puzzle_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class PuzzleProvider extends ChangeNotifier {
  final List<int> _gameField = [];
  final prefsKey = 'gameField';
  late SharedPreferences storage;
  bool win = false;
  int _zeroIndex = 0;
  // final PuzzleLogic _logic = PuzzleLogic();

  PuzzleProvider() {
    initProvider();
  }

  void initProvider() async {
    storage = await SharedPreferences.getInstance();
    _gameField.clear();
    if (storage.getStringList(prefsKey) == null) {
      getNewField();
      _myNotifier();
    } else {
      List<String> restored = storage.getStringList(prefsKey)!;
      if (restored.isNotEmpty) {
        for (int i = 0; i < restored.length; i++) {
          if (int.parse(restored[i]) == 0) {
            _zeroIndex = i;
          }
          _gameField.add(int.parse(restored[i]));
        }
        _myNotifier();
      }
    }
    // debugPrint('prefs: ${_gameField.toString()}');
    // debugPrint('x3');
  }

  void getNewField() {
    win = false;
    _gameField.clear();
    List<int> res = PuzzleLogic.generateField();
    for (int i = 0; i < res.length; i++) {
      _gameField.add(res[i]);
      if (res[i] == 0) {
        _zeroIndex = i;
      }
    }
    _myNotifier();
  }

  void _syncToStorage() {
    List<String> temp = [];
    for (int i = 0; i < _gameField.length; i++) {
      temp.add('${_gameField[i]}');
    }
    storage.setStringList(prefsKey, temp);
  }

  void _myNotifier() {
    _syncToStorage();
    notifyListeners();
  }

  void tryToClick(int index) {
    if (win) return;
    int clkCol = _getColumn(index), clkLine = _getLine(index);
    if (clkLine != _getLine(_zeroIndex) && clkCol != _getColumn(_zeroIndex)) {
      return;
    }
    int moveDir =
        clkCol > _getColumn(_zeroIndex) || clkLine > _getLine(_zeroIndex)
            ? 1 : -1;
    while (clkCol != _getColumn(_zeroIndex)) {
      _gameField[_zeroIndex] = _gameField[_zeroIndex + moveDir];
      _zeroIndex += moveDir;
      _gameField[_zeroIndex] = 0;
    }
    while (clkLine != _getLine(_zeroIndex)) {
      _gameField[_zeroIndex] = _gameField[_zeroIndex + moveDir * sideSize];
      _zeroIndex += moveDir * sideSize;
      _gameField[_zeroIndex] = 0;
    }

    // debugPrint('PROVIDER SAY: click on $index zero index is:$_zeroIndex');
    win = _checkForWin();
    _myNotifier();
  }

  bool _checkForWin() {
    for (int i = 0; i < _gameField.length - 1; i++) {
      if (_gameField[i] - 1 != i) return false;
    }
    return true;
  }

  int get sideSize => sqrt(_gameField.length).truncate();

  int _getLine(int index) => (index / sideSize).truncate();

  int _getColumn(int index) => index - _getLine(index) * sideSize;

  List<int> get gameField => List.castFrom(_gameField);
}
