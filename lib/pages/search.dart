import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/classes/searchservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_fin_etude/pages/profile.dart';

void main() => runApp(new Search());

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  navigatDetail(DocumentSnapshot post) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) => Profile(
          post: post,
        ),
      ),
    );
  }

  Future getPost(String searchField) async {
    QuerySnapshot qt = await Firestore.instance
        .collection('plants')
        .where('key', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
    return qt;
  }

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Firestore search'),
      ),
      body: FutureBuilder(
        builder: (_, snapshot) {
            return ListView(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (val) {
                      initiateSearch(val);
                    },
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.arrow_back),
                          iconSize: 20.0,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        contentPadding: EdgeInsets.only(left: 25.0),
                        hintText: 'Search by name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0))),
                  ),
                ),
                SizedBox(height: 10.0),
                GridView.count(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    primary: false,
                    shrinkWrap: true,
                    children: tempSearchStore.map((element) {
                      return buildResultCard(element);
                    }).toList()),
              ],
            );
          }
      ),
  );
  }
}

Widget buildResultCard(data) {
 Future navigatDetail(DocumentSnapshot post) {
  var context;
  return  Navigator.of( context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) => Profile(
          post: post,
        ),
      ),
    );
  }
  var index;
  return GestureDetector(
    onTap: ()=>navigatDetail(data[index]),
    child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        child: Container(
            child: Center(
                child: Text(
                  data['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                )))),
  );
}