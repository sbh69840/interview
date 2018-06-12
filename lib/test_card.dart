import 'package:flutter/material.dart';
import 'dart:math';
class ProfileCardDraggable extends StatelessWidget
{
  final List data;
  final int index1;
  ProfileCardDraggable(this.index1,this.data);
  static Random rand = new Random();
  final int index = rand.nextInt(4);


  @override
  Widget build(BuildContext context)
  {
    return new Card
    (
      elevation: 20.0,
      
      child: new Stack
      (
        
        children: <Widget>
        [
          new SizedBox.expand
          (
            child: new Material
            (
              color: Colors.white70,
              borderRadius: new BorderRadius.circular(5.0),
              child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  
                  Card(
                    elevation: 20.0,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: 
                        Text(data==null?"":data[index1]["question"],
                      style: 
                      TextStyle(fontSize: 20.0,
                      fontFamily: 'Caviar',
                      
                      color:Colors.black87)),

                        
                      ),
                  ),
                  Card(
                    elevation: 20.0,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child : Text(data==null?"":data[index]["Answer"],
                      style: 
                      TextStyle(fontSize: 15.0,
                      fontFamily: 'Caviar',
                      fontStyle: FontStyle.italic,
                      color:Colors.black87)),
                    ),
                  ),
                  ],
              ),
            ),
            ),
          ),
          
         
        ],
      ),
    );
  }
}