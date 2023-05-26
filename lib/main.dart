import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      routes: {
        '/home': (context) => const Home(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int picLeft = 1;
  int picRight = 1;
  int roundWinner = 1;
  int myScore = 0;
  int computerScore = 0;
  int drawScore = 0;
  int finalScore = 0;
  Widget title = const Text('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade300,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: const Text('Rock Paper Scissors'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title,
            const SizedBox(height: 20),
            ///Images
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// You
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/right$picRight.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.indigo.shade900),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                /// Computer
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/left$picLeft.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.indigo.shade900),
                    ],
                  ),
                ),
              ],
            ),

            /// Texts
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 95.0, top: 20.0),
                  child: Text(
                    'YOU:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 95.0, top: 20.0),
                  child: Text(
                    'COMPUTER:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
             /// Button
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade900,
                  minimumSize: const Size(150, 70),
                ),
                onPressed: () {
                  setState(() {
                    picLeft = Random().nextInt(3) + 1;
                    picRight = Random().nextInt(3) + 1;
                    print(whoWin());
                    getTitle();
                    finalScore += 1;
                    if (finalScore == 10) {
                      print(
                          '**************************************** : GAME END : ****************************************');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              title: const Text('Game end!'),
                              content: Text('Final Result : $myScore/10'),
                              actions: <Widget>[
                                ElevatedButton(

                                  onPressed: () {
                                    myScore = 0;
                                    computerScore = 0;
                                    finalScore = 0;
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo
                                  ),

                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  });
                  if (roundWinner == 1) {
                    myScore += 1;
                  } else if (roundWinner == -1) {
                    computerScore += 1;
                  } else {
                    drawScore += 1;
                  }
                },
                child: const Text(
                  'GO',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  int whoWin() {
    if (picLeft == 1 && picRight == 2) {
      roundWinner = -1;
    } else if (picLeft == 2 && picRight == 2) {
      roundWinner = 0;
    } else if (picLeft == 3 && picRight == 2) {
      roundWinner = 1;

      ///
    } else if (picLeft == 1 && picRight == 1) {
      roundWinner = 0;
    } else if (picLeft == 2 && picRight == 1) {
      roundWinner = 1;
    } else if (picLeft == 3 && picRight == 1) {
      roundWinner = -1;

      ///
    } else if (picLeft == 1 && picRight == 3) {
      roundWinner = 1;
    } else if (picLeft == 2 && picRight == 3) {
      roundWinner = -1;
    } else if (picLeft == 3 && picRight == 3) {
      roundWinner = 0;
    }
    return roundWinner;
  }

  Widget getTitle() {
    if (roundWinner == 1) {
      title = const Text(
        'WIN',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      );
    } else if (roundWinner == -1) {
      title = const Text(
        'LOSE',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      );
    } else {
      title = const Text(
        'DRAW',
        style: TextStyle(
          color: Colors.yellowAccent,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      );
    }
    return title;
  }
}
