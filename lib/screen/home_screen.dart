import 'package:magic15/providers/puzzle_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import '../elements/puzzle_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double displace = 18.0;
    const readyList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
    debugPrint('HomeScreen built');
    final fieldWidth =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? -MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;
    List<int> gameField = Provider.of<PuzzleProvider>(context).gameField;

    return Scaffold(
      // backgroundColor: Provider.of<PuzzleProvider>(context).win
      // ? Colors.orange.withAlpha(20) : Colors.white70,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: fieldWidth,
                height: fieldWidth,
                child: Stack(
                  children: [
                    Image.asset('assets/images/desk_background.png'),
                    Container(
                      margin: const EdgeInsets.all(displace),
                      child: gameField.isNotEmpty
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Provider.of<PuzzleProvider>(
                                        context,
                                        listen: false)
                                    .sideSize,
                              ),
                              itemCount: gameField.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GameItem(
                                  sideSize: (fieldWidth - displace * 2) /
                                      Provider.of<PuzzleProvider>(context,
                                              listen: false)
                                          .sideSize,
                                  index: gameField[index],
                                  order: index,
                                );
                              })
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: Stack(
            children: [
              Image.asset('assets/images/button.png'),
              Container(
                margin: EdgeInsets.only(left: 2.0, top: 2.0),
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Provider.of<PuzzleProvider>(context).win
                      ? Colors.transparent
                      : Colors.black.withAlpha(80),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 2.0, top: 2.0),
                child: Icon(
                  Icons.refresh_rounded,
                  size: 96.0,
                  color: Colors.black,
                ),
              ),
              Icon(
                Icons.refresh_rounded,
                size: 96.0,
                color: Provider.of<PuzzleProvider>(context).win
                    ? Colors.white
                    : Colors.brown,
              ),
            ],
          ),
        ),
        onTap: () =>
            Provider.of<PuzzleProvider>(context, listen: false).getNewField(),
      ),
    );
  }
}
