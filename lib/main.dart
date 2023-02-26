import 'package:flutter/material.dart';
import 'dart:math';

// Domain name: What the flip
// Credit to the image: <a href="https://www.freepik.com/free-vector/poker-cards_1185219.htm#query=playing%20card&position=4&from_view=keyword&track=ais">Image by brgfx</a> on Freepik
// Credit to the image: <a href="https://www.freepik.com/free-vector/set-poker-cards-with-front-back-design_1169379.htm#query=playing%20card&position=0&from_view=keyword&track=ais">Image by brgfx</a> on Freepik
// Initializing list of cards' front and back
List<String> assetsfront = [
  'assets_front/2hearts.png',
  'assets_front/3hearts.png',
  'assets_front/4hearts.png',
  'assets_front/5hearts.png',
  'assets_front/6hearts.png',
  'assets_front/7hearts.png',
  'assets_front/8hearts.png',
  'assets_front/9hearts.png',
  'assets_front/10hearts.png',
  'assets_front/jackhearts.png',
  'assets_front/queenhearts.png',
  'assets_front/kinghearts.png',
  'assets_front/acehearts.png',
  'assets_front/2spades.png',
  'assets_front/3spades.png',
  'assets_front/4spades.png',
  'assets_front/5spades.png',
  'assets_front/6spades.png',
  'assets_front/7spades.png',
  'assets_front/8spades.png',
  'assets_front/9spades.png',
  'assets_front/10spades.png',
  'assets_front/jackspades.png',
  'assets_front/queenspades.png',
  'assets_front/kingspades.png',
  'assets_front/acespades.png',
]..shuffle();

List<String> assetsback = [
  'assets_back/avengers.png',
  'assets_back/lotr.png',
  'assets_back/default.png'
]..shuffle();

// get random cards' front and back
AssetImage getRandomBack() {
  final back = assetsback[0];
  return AssetImage(back);
}

AssetImage getRandomFront() {
  final front = assetsfront[0];
  return AssetImage(front);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //declare the isBack bool
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flip the card!'),
      ),
      backgroundColor: Color(0xFFFFFF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _flip,
                child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: angle),
                    duration: Duration(seconds: 1),
                    builder: (BuildContext context, double val, __) {
                      // change isBack value to change the content of the card
                      if (val >= (pi / 2)) {
                        isBack = false;
                      } else {
                        isBack = true;
                      }
                      return (Transform(
                        // flip the card aligning in the center
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0015)
                          ..rotateX(val),
                        child: Container(
                            width: 294,
                            height: 435,
                            child: isBack
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      image: DecorationImage(
                                        image: getRandomBack(),
                                      ),
                                    ),
                                  )
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..rotateX(
                                          pi), // flip the container vertically
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                          image: getRandomFront(),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                      ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
