import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/models/searchservice.dart';
import 'package:project_fin_etude/pages/profile.dart';
import 'package:project_fin_etude/styles/styles.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.search,
          color: Colors.greenAccent,
          size: 28,
        ),
        title: Text(
          'Search',
          style: kPagetitle,
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        builder: (_, snapshot) {
          return ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: TextField(
                  onChanged: (val) {
                    initiateSearch(val);
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xFFDCDCDC).withOpacity(0.5),
                    filled: true,
                    prefixIcon: IconButton(
                      color: Colors.greenAccent,
                      icon: Icon(Icons.search),
                      iconSize: 24.0,
                      onPressed: () {
                        //  Navigator.of(context).pop();
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Search by name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              ListView.separated(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                itemCount: tempSearchStore.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        navigateDetail(tempSearchStore[index], context),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(tempSearchStore[index]['avatar']),
                        ),
                        subtitle: Text(
                          tempSearchStore[index]['family'],
                          style: klisttileSubtitle,
                        ),
                        title: Text(tempSearchStore[index]['name'],
                            style: listtileTitle),
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
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
}
