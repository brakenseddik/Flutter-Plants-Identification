import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

      body: SafeArea(child: GridView.builder(
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
          ),
          itemBuilder:(context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 15.0),
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context,rootNavigator: true).push(CupertinoPageRoute(builder: (context) =>Profile()));
              },
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Column(
                    children: <Widget>[
                      Stack(children: <Widget>[
                        ClipRRect(
                          child: Image.asset(
                            'images/map_of_europe_80001364_165672874708236_8451702131749635568_n.jpg',
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 8,
                            fit:BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                        ),
                        Positioned(top: 16.0,
                            right: 20.0,
                            child: Container(
                              padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(color: Colors.white , borderRadius: BorderRadius.circular(20)),
                                child: Icon(Icons.delete,size: 25,color: Colors.greenAccent,))),
                      ],),

                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Plant name',style: TextStyle(fontSize: 22),),
                        ),
                      )
                ],

                ),
                ),
              ),
            );
          },
          itemCount: 12,
          ),
      ),
      ),
    );
  }
}