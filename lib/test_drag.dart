import 'package:flutter/material.dart';
import 'test_card.dart';
import 'package:flutter/cupertino.dart';

class TestQuestionDraggable extends StatefulWidget
{
  final List data;
  TestQuestionDraggable(this.data);
  @override
  _CardsSectionState createState() => new _CardsSectionState(this.data);
}


class _CardsSectionState extends State<TestQuestionDraggable>
{
  final List data;
  
  _CardsSectionState(this.data);  
  bool bgcolor=true;
  bool dragOverTarget = false;
  bool dragOverTarget1 = false;
  int questions = 0;
  int score = 0;
  List<ProfileCardDraggable> cards = new List();
  int cardsCounter = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text('You selected: $value'),
          ),
        );
      }
    });
  }

  @override
  void initState()
  {
    super.initState();

    for (cardsCounter = 0; cardsCounter < data.length; cardsCounter++)
    {
      cards.add(new ProfileCardDraggable(cardsCounter,data));
    }
  }

  @override
  Widget build(BuildContext context)
  {
    
    return new Expanded
    (
      child: new Stack
      (
        children: <Widget>
        [
          // Drag target row
          new Row
          (
            mainAxisSize: MainAxisSize.max,
            children: <Widget>
            [
              dragTarget(),
              new Flexible
              (
                flex: 15,
                child: new Container(
                  color:bgcolor?Colors.white:Colors.white,
                )
              ),
              dragTarget1()
            ],
          ),
          // Back card
          new Align
          (
            alignment: new Alignment(0.0, 1.0),
            child: new IgnorePointer(child: new SizedBox.fromSize
            (
              size: new Size(MediaQuery.of(context).size.width * 0.8, MediaQuery.of(context).size.height * 0.5),
              child: cards[2],
            )),
          ),
          // Middle card
          new Align
          (
            alignment: new Alignment(0.0, 0.8),
            child: new IgnorePointer(child: new SizedBox.fromSize
            (
              size: new Size(MediaQuery.of(context).size.width * 0.85, MediaQuery.of(context).size.height * 0.55),
              child: cards[1],
            )),
          ),
          // Front card
          new Align
          (
            alignment: new Alignment(0.0, 0.0),
            child: new Draggable
            (
              feedback: new SizedBox.fromSize
              (
                size: new Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.6),
                child: cards[0],
              ),
              child: new SizedBox.fromSize
              (
                size: new Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.6),
                child: cards[0],
              ),
              childWhenDragging: new Container(),
            ),
          ),
        ],
      )
    );
  }

  void changeCardsOrder()
  {
    setState(()
    {
      // Swap cards
      var temp = cards[0];
      cards[0] = cards[1];
      cards[1] = cards[2];
      cards[2] = cards[3];
      cards[3] = cards[4];
      cards[4] = temp;
      cards[0].index1!=cards[0].index?score+=1:score+=0;

      //cards[2] = new ProfileCardDraggable(cardsCounter,data);
      if(cardsCounter==data.length-1){
        cardsCounter=0;
      }else{
        cardsCounter++;
      }
    });
  }
   void changeCardsOrder1()
  {
    setState(()
    {
      // Swap cards
      var temp = cards[0];
      cards[0] = cards[1];
      cards[1] = cards[2];
      cards[2] = cards[3];
      cards[3] = cards[4];
      cards[4] = temp;
      cards[0].index1==cards[0].index?score+=1:score+=0;
      

      //cards[2] = new ProfileCardDraggable(cardsCounter,data);
      if(cardsCounter==data.length-1){
        cardsCounter=0;
      }else{
        cardsCounter++;
      }
    });
  }

  Widget dragTarget()
  {
    return new Flexible
    (
      flex: 1,
      child: new DragTarget
      (
        builder: (_, __, ___)
        {
         
          return new Container(color: dragOverTarget ? Colors.red[200] : Colors.transparent,);
        },
        onWillAccept: (_)
        {
          setState(() => dragOverTarget = true);
          return true;
        },
        onAccept: (_)
        {
          questions++;
          if(questions<5){
          changeCardsOrder();
          }else{
            showDemoDialog<String>(
                context: context,
                child: new CupertinoAlertDialog(
                  title: Text('Your Score is'+(score+1).toString()+'/5',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  
                  actions: <Widget>[
                    new CupertinoDialogAction(
                      child: const Text('Discard',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Discard');
                      },
                    ),
                    new CupertinoDialogAction(
                      child: const Text('Cancel',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    ),
                  ],
                ),
              );
            setState(()=>questions=0);
            setState(()=>score=0);

          }
          setState(() => dragOverTarget = false);
        },
        onLeave: (_) => setState(() => dragOverTarget = false)
      ),
    );
  }
  Widget dragTarget1()
  {
    return new Flexible
    (
      flex: 1,
      child: new DragTarget
      (
        builder: (_, __, ___)
        {
         
          return new Container(color: dragOverTarget1 ? Colors.blue[200] : Colors.transparent,);
        },
        onWillAccept: (_)
        {
          setState(() => dragOverTarget1 = true);
          return true;
        },
        onAccept: (_)
        {
          questions++;
          if(questions<5){
            changeCardsOrder1();
          }else{
            showDemoDialog<String>(
                context: context,
                child: new CupertinoAlertDialog(
                  title: Text('Your Score is'+(score+1).toString()+'/5',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  
                  actions: <Widget>[
                    new CupertinoDialogAction(
                      child: const Text('Discard',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Discard');
                      },
                    ),
                    new CupertinoDialogAction(
                      child: const Text('Cancel',style: TextStyle(
                        fontFamily: 'Caviar',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    ),
                  ],
                ),
              );
            setState(()=>questions=0);
            setState(()=>score=0);

          }
          setState(() => dragOverTarget1 = false);
        },
        onLeave: (_) => setState(() => dragOverTarget1 = false)
      ),
    );
  }
}