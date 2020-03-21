import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(
 Myapp()
);
class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
          body:Stack(
            alignment:AlignmentDirectional.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 300.0,
                    child: Image.network('https://cdn.pixabay.com/photo/2015/03/26/09/42/woman-690118__340.jpg',
                      width: double.infinity,

                    ),
                  ),
                  Divider(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Braken Mohamed',style: TextStyle(fontSize: 24,color: Colors.black)),
                      Divider(height: 30,),
                      Icon(Icons.lightbulb_outline,color: Colors.black54,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.email,color: Colors.indigo,size: 24,),
                      Icon(Icons.image,color: Colors.indigo,size: 24),
                      Icon(Icons.favorite,color: Colors.indigo,size: 24),
                    ],
                  ),
                  Text('About',style: TextStyle(fontSize: 28)),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text('Hi 😊, Im a full stack software developer mainly, and Im an System Administration studentI have 2 years experience in software'
                        ' development, I worked in many projects, I build my own softwares from scratch.Now, Im '
                        'looking for new opportunities outside my home country Algeria to acquire amultinational experience '
                        'and to share my knowledge and my little experience too !PS: I love innovation and new creative ideas !'
                        ' and never give up for challenges',style: TextStyle(fontSize: 18,)),
                  ),
                  RaisedButton(
                    onPressed: (){
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    },
                    color: Colors.indigo,

                    child: Center(child: Text('Contact me',style: TextStyle(color: Colors.white),)),
                  )

                ],
              ),
              Positioned(
                top: 200,
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  child: CircleAvatar(
                    foregroundColor: Colors.red,
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/09/02/12/58/woman-918788__340.jpg',

                    ),

                  ),
                ),
              ),
              Positioned(
                  top: 30,
                  right: 30,
                  child: Container(
                      decoration: BoxDecoration( color: Colors.lightBlueAccent,
                          borderRadius:BorderRadius.circular(25)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border,color: Colors.white,size: 24,),
                      )))

            ],
          )
      ) ,

    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}