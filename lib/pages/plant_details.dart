import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_fin_etude/pages/plant_profile.dart';
import 'package:tflite/tflite.dart';

class Details extends StatefulWidget {
  final imageFile;
  Details({this.imageFile});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool loading = false;
  bool detecting = false;
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
      loading = true;
    });
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('plants')
        .orderBy('key', descending: false)
        .getDocuments();
    snapshotsOfPlants = qn.documents;
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );

    setState(() {
      loading = false;
    });
    classifyImage(widget.imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.file(
                  widget.imageFile,
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Result',
                    style: TextStyle(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (output != null) {
                      for (var v in snapshotsOfPlants) {
                        // print(v.data['name'].toString().toLowerCase());
                        // print(output[0]['label'].toString().split(' ')[1].toLowerCase());
                        if (v.data['name'].toString().toLowerCase() ==
                            output[0]['label']
                                .toString()
                                .split(' ')[1]
                                .toLowerCase()) {
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
                    leading: Icon(output != null
                        ? output.isEmpty ? Icons.close : Icons.check_circle
                        : FontAwesomeIcons.arrowAltCircleUp),
                    trailing: loading
                        ? CircularProgressIndicator()
                        : detecting
                            ? CircularProgressIndicator()
                            : Text(output != null
                                ? output.isEmpty
                                    ? ''
                                    : '${(output[0]['confidence'] * 100).floor()}' +
                                        '%'
                                : ''),
                    title: Text(
                      loading
                          ? 'loading please wait...'
                          : detecting
                              ? 'Identifing the image...'
                              : output != null
                                  ? output.isEmpty
                                      ? 'Couldn\'t identify your picture'
                                      : ' image contains ${output[0]['label'].toString().split(' ')[1]}'
                                  : '',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
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
              left: 10,
              top: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  classifyImage(File image) async {
    setState(() {
      detecting = true;
    });
    var _output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    //print(_output);
    setState(() {
      detecting = false;
      //Declare List _outputs in the class which will be used to show the classified classs name and confidence
      output = _output;
    });
  }
}
