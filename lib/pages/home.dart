import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_fin_etude/pages/details.dart';
import 'package:project_fin_etude/pages/profile.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'dashboard.dart';
import 'saved.dart';
import 'search.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties & Variables needed
  File _image;

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Dashboard(),
    Chat(),
    Search(),
    Settings(),
    Profile()
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard(); // Our first view in viewport

  @override
  void initState() {
    super.initState();
    ConnectivityUtils.initialize(
        serverToPing:
            "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt",
        callback: (response) => response.contains("This is a test!"));
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      showOfflineBanner: false,
      builder: (context, isOnline) => Scaffold(
        body: isOnline
            ? PageStorage(
                child: currentScreen,
                bucket: bucket,
              )
            : Center(
                child: Text(
                  'offline',
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0XFFFFFFFF),
          child: Icon(
            Icons.camera,
            size: 36,
            color: Colors.greenAccent,
          ),
          onPressed: isOnline ? _optionDialogBox : null,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: isOnline
                          ? () {
                              setState(() {
                                currentScreen =
                                    Dashboard(); // if user taps on this dashboard tab will be active
                                currentTab = 0;
                              });
                            }
                          : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: currentTab == 0
                                ? Color(0XFF1aff1a)
                                : Colors.grey,
                          ),
                          Text(
                            'Main',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? Color(0XFF7fff00)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: isOnline
                          ? () {
                              setState(() {
                                currentScreen =
                                    Chat(); // if user taps on this dashboard tab will be active
                                currentTab = 1;
                              });
                            }
                          : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.favorite_border,
                            color: currentTab == 1
                                ? Color(0XFF1aff1a)
                                : Colors.grey,
                          ),
                          Text(
                            'Saved',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? Color(0XFF7fff00)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: isOnline
                          ? () {
                              setState(() {
                                currentScreen =
                                    Search(); // if user taps on this dashboard tab will be active
                                currentTab = 2;
                              });
                            }
                          : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.search,
                            color: currentTab == 2
                                ? Color(0XFF7fff00)
                                : Colors.grey,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: currentTab == 2
                                  ? Color(0XFF7fff00)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: isOnline
                          ? () {
                              setState(() {
                                currentScreen =
                                    Settings(); // if user taps on this dashboard tab will be active
                                currentTab = 3;
                              });
                            }
                          : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: currentTab == 3
                                ? Color(0XFF1aff1a)
                                : Colors.grey,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? Color(0XFF7fff00)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _optionDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Take a Picture',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    child: Text(
                      'Select  from Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

//Camera Method
  Future openCamera() async {
    Navigator.pop(context);

    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(imageFile: image),
        ),
      );
      setState(() {
        _image = image;
      });
    }
  }

// you want the selected image to display in a new page?????? yes i have this page
  // there u go i think the navigator should bi in setState
  // if u are not updating the current ui then u dont need the set state .. set state will call the current widgets build  function u dont need that
  //if u are not using the image object in the UI then u dont need to put it inside the set state okay thank you so much
  //do u have idea about machine learning??
  // as a matter of fact i am learning it right now i want to implements this in my app
  // my app is about plants identification so i created everything and also the ML i used teachable machine to train my model
  // now i want to integrate the model in my app
  // lk whether tenserflow as a package for dart
  // they must have ye. us can use ur model and predict output tensorflow is the integration tool
  // yes the model craetsed with trenserflow and there's a package  for it
  //understand what what i want to implements yeah i understand
  // do you have any idea?
  //i will look into it meanwhile make a post in the group someone might know
  // i've got the idea but i just need some more détails , i found an example of ml in flutter
  // BTw thank you so much
  //its fine bro you are welcome
  //update your ide
  // Gallery Method
  Future openGallery() async {
    Navigator.pop(context);

    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(imageFile: picture),
        ),
      );
      setState(() {
        _image = picture;
      });
      // add your model file and labels.txt to that folder
      //I HQVE the model but the labls are related to the firestore names
      // why the files are not showing i dn't know please if   ur a
//my laptop is slow pleease wait
      //you have too many softwares and thread running in the background
      // if u want to develop flutter apps in this lap u need to format it and install a new os then only use it for flutter development and use a physical device for testing and u can use for browsing internet
      // if u use for other things or even install anything it can take up memory and cpu use

      // which country are u from?? algeria my laptop is 8 GB RAM AND I5 but slow
    }
  }
}
