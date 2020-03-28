import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: <Widget>[
          Expanded(child: Image.file(widget.imageFile,),),
          GestureDetector(
            onTap: (){
              if(output!=null)
              {
                // just make sure the name u stored in the firebase and the name u have in the label.txt file are same if they are diff then this code wornt work
                // hello yes i'll take a look it's okay now
                for(var v in snapshotsOfPlants){
                  print(v.data['name'].toString().toLowerCase());
                  print(output[0]['label'].toString().split(' ')[1].toLowerCase());
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
              // i think that is the name of the class in the model u should name is properly when u create a class in the teachable when u train again do it with the same name as the fire store and change the asset files and u are good to go...
              // good luck thank you   is it working ???
              // what is iot it
              // yes code is working just the names are not matching when u create a class in teachable website name it in the same name
              // what if we change the name in labels.txt
              // i dont know will it work
              // lets see
              //fill itmi
              // coollyeaaaaaaaah cool it works thank you so much bro
              // you are welcome :)
              // how is corona panic in ur place so bad
              // stay safe yes i'm in my home for last 10 days
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Text(loading?'loading please wait...':detecting ?'Identifing the image...':' image contains ${output[0]['label'].toString().split(' ')[1]}',style: TextStyle(fontSize: 20.0,),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:24.0),
            child: Text(output==null?'':'Confidence: ${(output[0]['confidence']*100).floor()} %',style: TextStyle(fontSize: 20.0,),),
          ),
        ],
      ),
    );
  }
  // done yeah it works thank you so much if you  have free time i've something i want to make it with you
  // what u have in mind ok when the user click on the result it should take it him to the profile of that output
  // how u named those pages??


  // code is working fine
  // model is not trained enough  yes dio  uu have any image to teach the model yes i used just 50 images/plant  u need to use more than thousand
  // images per catogery no problem i'll train the model agioool cool then the code is done wait one more change

  classifyImage(File image) async {
    setState(() {
      detecting=true;
    });
    var _output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
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
