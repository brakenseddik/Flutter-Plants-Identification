import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_fin_etude/pages/settings.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'images/map_of_italy_81968107_169647531044320_7038524835093477766_n.jpg'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 15,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            'Braken Mohammed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 14),
                          Text(
                            'Software Developer',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18),
                          ),
                          SizedBox(
                            height: 30,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'About me',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Hi 😊, I\'m a full stack software developer mainly'
                            'and I\'m an System Administration student I have 2 years experience '
                            'in software development, I worked in many projects, I build my own '
                            'softwares from scratch.'
                            'Now, I\m looking for new opportunities outside my home country Algeria to acquire '
                            'a multinational experience and to share my knowledge and my little experience too !'
                            'PS: I love innovation and new creative ideas ! and never give up for challenges',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Follow me on',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({this.bgColor, this.text, this.textColor});

  final Color bgColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Material(
            color: bgColor,
            borderRadius: BorderRadius.circular(7),
            child: InkWell(
              borderRadius: BorderRadius.circular(7),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  '$text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
