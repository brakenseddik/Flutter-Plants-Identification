import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_fin_etude/components/bezierContainer.dart';
import 'package:project_fin_etude/pages/auth/signup.dart';
import 'package:project_fin_etude/pages/home_page.dart';

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
  bool isPassword = true;
  String errorMsg = '';

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
  Widget _entryEmail(String title) {
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
              validator: (String value) {
                if (value.isEmpty ||
                    !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
              onSaved: (input) => _email = input,
              // obscureText: isPassword,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter your E-mail',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryPassword(String title) {
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
                  return 'Enter a valid password';
                }
              },
              onSaved: (input) => _password = input,
              obscureText: isPassword,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                        isPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                        print(isPassword);
                      });
                    },
                  ),
                  hintText: 'Enter your password',
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
          text: 'P',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff11998e),
          ),
          children: [
            TextSpan(
              text: 'LAN',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'TEEX',
              style: TextStyle(color: Color(0xff11998e), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryEmail("Email "),
        _entryPassword("Password"),
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

    if (user1 != null) {
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
      //print(user1);
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
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              )
            : SingleChildScrollView(
                child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: -MediaQuery.of(context).size.height * .15,
                        right: -MediaQuery.of(context).size.width * .4,
                        child: BezierContainer()),
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
      } catch (error) {
        var errorCode = error.code;
        var errorMessage = error.message;
        switch (errorCode) {
          case "ERROR_WRONG_PASSWORD":
          case "ERROR_INVALID_EMAIL":
            {
              errorMessage = "Wrong password or Email.";
              break;
            }
          case "ERROR_NETWORK_REQUEST_FAILED":
            {
              errorMessage = "Check your internet connection.";
              break;
            }
          case "ERROR_USER_NOT_FOUND":
          case "ERROR_USER_DISABLED":
            {
              errorMessage = "Account not found or disabled";
              break;
            }
        }
        setState(() {
          loading = false;
        });
        _scaffoldKey.currentState
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Login Error : ' + errorMessage,
              ),
            ),
          );
        print(error);
      }
    } else {
      setState(() {
        loading = false;
        LoginPage();
      });
      _scaffoldKey.currentState
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Login Error :Empty fields',
            ),
          ),
        );
    }
  }
}
