import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_fin_etude/constants//constants.dart';
import 'package:project_fin_etude/pages/auth/login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF98FB98),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF2AF598),
                Color(0xFF22E4AC),
                Color(0xFF14C9CB),
                Color(0xFF0FBED8),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ))
                    },
                    child: Text(
                      'Passer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 500.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'images/1.png',
                                  ),
                                  height: 250.0,
                                  width: 250.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Créer votre propre collection de plantes ',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Planteex permet d\'ajouter vos plantes préférées à votre collection .',
                                style: kSubtitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/IMGs/flower.png',
                                    ),
                                    height: 250.0,
                                    width: 250.0,
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'Identifiez autant de plantes que vous voulez',
                                  style: kTitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  'Faire identifiez des plantes que vous ne connaissez pas par notre service',
                                  style: kSubtitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/IMGs/plant.png',
                                  ),
                                  height: 250.0,
                                  width: 250.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Explorer un Encyclopédie de plantes médicinales',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Explorer un catalogue de plantes médicinales les plus utilisées',
                                style: kSubtitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Suivant',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 70.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ))
                },
                child: Center(
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      color: Color(0xFF14C9CB),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
