import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/classes/searchservice.dart';
import 'package:project_fin_etude/pages/profile.dart';

void main() => runApp(new Search());

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getPost(String searchField) async {
    QuerySnapshot qt = await Firestore.instance.collection('plants').where('key', isEqualTo: searchField.substring(0, 1).toUpperCase()).getDocuments();
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

    var capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i]);
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
      backgroundColor: Colors.white,
      body: FutureBuilder(
        builder: (_, snapshot) {
          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 50),
                child: TextField(
                  onChanged: (val) {
                    initiateSearch(val);
                  },
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.search),
                      iconSize: 20.0,
                      onPressed: () {
                      //  Navigator.of(context).pop();
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Search by name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
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
                children: tempSearchStore.map(
                  (element) {
                    return buildResultCard(element, context);
                  },
                ).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Future navigateDetail(DocumentSnapshot post, ctx) {
    return Navigator.of(ctx).push(
      CupertinoPageRoute(
        builder: (context) => Profile(
          post: post,
        ),
      ),
    );
  }

  Widget buildResultCard(data, ctx) {
    return GestureDetector(
      onTap: () => navigateDetail(data, ctx),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
            ),
          ),
        ),
      ),
    );
  }
}
