import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Name",
                filled: true,
                fillColor: Color(0xFFE7E7E7),
                //hintText: 'Username',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "E-mail",
                filled: true,
                fillColor: Color(0xFFE7E7E7),
                //hintText: 'Username',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Message",
                filled: true,
                fillColor: Color(0xFFE7E7E7),
                //hintText: 'Username',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Text('Send'),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
