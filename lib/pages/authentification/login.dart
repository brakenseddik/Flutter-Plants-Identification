import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/authentification/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_fin_etude/Widget/bezierContainer.dart';
import 'package:project_fin_etude/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final FirebaseUser title;
  //final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  /*Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
*/
  Widget _entryEmail(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              // ignore: missing_return
              validator: (input) {
                if (input.isEmpty) {
                  'please tap an email';
                }
              },
              onSaved: (input) => _email = input,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xffE7E7E7),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryPassword(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              // ignore: missing_return
              validator: (input) {
                if (input.isEmpty) {
                  'please enter your password';
                }
              },
              onSaved: (input) => _password = input,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () => signIn(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff38ef7d), Color(0xff11998e)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xff38ef7d),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'F',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display2,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff11998e),
          ),
          children: [
            TextSpan(
              text: 'LO',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'REEX',
              style: TextStyle(color: Color(0xff11998e), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryEmail("Email "),
        _entryPassword("Password", isPassword: true),
      ],
    );
  }

  bool loading = false;
  @override
  void initState() {
    super.initState();
    detectUser();
  }

  void detectUser() async {
    setState(() {
      loading = true;
    });
    FirebaseAuth _auth1 = FirebaseAuth.instance;
    FirebaseUser user1 = await _auth1.currentUser();
    if (user1.uid != null) {
      print(user1);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => Home(user: user1),
        ),
      );
      setState(() {
        loading = false;
      });
    } else {
      print(user1);
      setState(() {
        loading = false;
      });
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: SizedBox(),
                            ),
                            _title(),
                            SizedBox(
                              height: 50,
                            ),
                            _emailPasswordWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            _submitButton(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerRight,
                              child: Text('Forgot Password ?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            _divider(),
                            _facebookButton(),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _createAccountLabel(),
                    ),
                    // Positioned(top: 40, left: 0, child: _backButton()),
                    Positioned(
                        top: -MediaQuery.of(context).size.height * .15,
                        right: -MediaQuery.of(context).size.width * .4,
                        child: BezierContainer())
                  ],
                ),
              )));
  }

  void signIn() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _email.trim(), password: _password.trim()))
            .user;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => Home(user: user),
          ),
        );
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
        _scaffoldKey.currentState
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Login Error',
              ),
            ),
          );
        print(e);
      }
    } else {
      setState(() {
        loading = false;
      });
      _scaffoldKey.currentState
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Login Error',
            ),
          ),
        );
    }
  }
}
