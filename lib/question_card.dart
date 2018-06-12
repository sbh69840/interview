import 'package:flutter/material.dart';

class ProfileCardDraggable extends StatelessWidget
{
  final int index;
  final List data;
  ProfileCardDraggable(this.index,this.data);

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
                        Text(data==null?"":data[index]["question"],
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