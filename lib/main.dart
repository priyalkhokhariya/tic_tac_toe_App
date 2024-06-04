import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; // the 1st player turn 0
  List<String> displayExOh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  var myTextstyle = TextStyle(color: Colors.white , fontSize: 30);
  int ohScore =0;
  int exScore = 0;
  int filledBoxes =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children:<Widget> [
            Expanded(
                child: Container(
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Player 0', style: myTextstyle,),
                            Text(ohScore.toString(), style: myTextstyle,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Player X', style: myTextstyle,),
                            Text(exScore.toString(), style: myTextstyle,),
                          ],
                        ),
                      ),
                    ],
                  ),

                ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Text(
                            displayExOh[index],
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),


            Expanded(
              child: Container(
               // color: Colors.red,

              ),
            ),

          ],
        ),
      ),
    );
  }

  void _tapped(int index) {

    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = '0';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'x';
        filledBoxes += 1;
      }

      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  //###########################################
  void _checkWinner() {

    //checks 1st row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showinDialog(displayExOh[0]);
    }


    //checks 2st row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showinDialog(displayExOh[3]);
    }


    //checks 3st row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showinDialog(displayExOh[6]);
    }


    //checks 1st column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showinDialog(displayExOh[0]);
    }

    //check 2nd colmn
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showinDialog(displayExOh[1]);
    }

    //check 3nd colmn
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showinDialog(displayExOh[2]);
    }

    //check cross check
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showinDialog(displayExOh[0]);
    }

    //check cross check2
    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != '') {
      _showinDialog(displayExOh[2]);
    }
    
    else if(filledBoxes == 9){
      _showDrawDialog();
    }
  }





  //###########################################################

  void _showDrawDialog() {

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('DRAW'),
            actions: <Widget>[
              TextButton(
                  child: Text('Play Again'),
                  onPressed :(){
                    _clearBoard();
                    Navigator.of(context).pop();
                  }

              )
            ],
          );
        }
    );

  }













  // ############################################
  void _showinDialog(String winner) {

    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('WINNER IS: ' + winner),
            actions: <Widget>[
              TextButton(
                child: Text('Play Again'),
                onPressed :(){
                  _clearBoard();
                  Navigator.of(context).pop();
                }

              )
            ],
          );
        }
    );

    if(winner =='0'){
      ohScore += 1;
    }
    else if(winner == 'x'){
      exScore += 1;
    }
    //_clearBoard();
  }


  //###################################################
   void _clearBoard(){

    setState(() {
      for(int i=0; i<9;i++){
        displayExOh[i] ='';
      }
    });

    filledBoxes =0;
   }



}
