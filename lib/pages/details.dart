import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:project_fin_etude/pages/profile.dart';
import 'package:tflite/tflite.dart';
class Details extends StatefulWidget {
  final imageFile;
  Details({this.imageFile});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool loading=false;
  bool detecting=false;
  var output;
  List snapshotsOfPlants;
  @override
  void initState() {
    super.initState();
    loadModel();
  }
  //Load the Tflite model
  loadModel() async {
    setState(() {
      loading=true;
    });
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('plants').orderBy('key',descending: false).getDocuments();
    snapshotsOfPlants=qn.documents;
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    // then what are u studying????? cs computer science and this is my graduate project haha sweet how long have u been working on this design
    // since 15 january ps: i'm biginner in flutter & firebase
    // i worked on many apps but i cant create beautiful designs i am a not that creative ur design looks cool
    // i'm a ui/ux designer too
    // well that explains a lot...lol i wanted to learn flutter well but i thought the time will not helps me
    //just one thing i want to show also the percentage 59%
    setState(() {
      loading=false;
    });
    classifyImage(widget.imageFile);
  }
  // plaese i'm going out just 5   minutes u can complete ur work :) ok
  // which one u want clickable image or textt  tor u want to add a button text
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.file(
                widget.imageFile,height: MediaQuery.of(context).size.height / 2.5,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Result',style: TextStyle(fontSize: 28),textAlign: TextAlign.center,),
              ),
              GestureDetector(
                onTap: (){
                  if(output!=null)
                  {
                    for(var v in snapshotsOfPlants){
                      // print(v.data['name'].toString().toLowerCase());
                      // print(output[0]['label'].toString().split(' ')[1].toLowerCase());
                      if(v.data['name'].toString().toLowerCase()==output[0]['label'].toString().split(' ')[1].toLowerCase()){
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => Profile(
                              post: v,
                            ),
                          ),
                        );
                        break;
                      }
                    }
                  }
                },
                child: ListTile(
                  leading: Icon(output!=null?output.isEmpty?Icons.close:Icons.check_circle:Icons.all_inclusive),
                  trailing:loading?
                  CircularProgressIndicator():detecting ?
                  CircularProgressIndicator():Text(output!=null?output.isEmpty?'':'${(output[0]['confidence']*100).floor()}'+'%':''),
                  title:Text(loading?
                  'loading please wait...':detecting ?
                  'Identifing the image...':output!=null?output.isEmpty?'Couldn\'t identify your picture':' image contains ${output[0]['label'].toString().split(' ')[1]}':'',style: TextStyle(fontSize: 20.0,),) ,
                ),
              ),
             /* GestureDetector(
                onTap: (){
                  if(output!=null)
                  {
                    for(var v in snapshotsOfPlants){
                     // print(v.data['name'].toString().toLowerCase());
                     // print(output[0]['label'].toString().split(' ')[1].toLowerCase());
                      if(v.data['name'].toString().toLowerCase()==output[0]['label'].toString().split(' ')[1].toLowerCase()){
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => Profile(
                              post: v,
                            ),
                          ),
                        );
                        break;
                      }
                    }
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: Text(loading? 'loading please wait...':detecting ?'Identifing the image...':' image contains ${output[0]['label'].toString().split(' ')[1]}',style: TextStyle(fontSize: 20.0,),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:24.0),
                child: Text(output==null?'':''
                    'Confidence: ${(output[0]['confidence']*100).floor()} %',style: TextStyle(fontSize: 20.0,),
                ),
              ),*/
            ],
          ),
          Positioned(
            left: 10,top: 20,
            child: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon:Icon(Icons.arrow_back,color: Colors.white, ),),
          )
        ],
      ),
    );
  }


  classifyImage(File image) async {
    setState(() {
      detecting=true;
    });
    var _output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print(_output);
    setState(() {
      detecting=false;
      //Declare List _outputs in the class which will be used to show the classified classs name and confidence
      output = _output;
    });
  }
}
