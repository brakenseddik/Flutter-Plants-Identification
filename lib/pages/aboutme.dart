import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'App Info',
              style: TextStyle(color: Colors.black),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            width: 75,
                            height: 75,
                            image: AssetImage(
                              'images/playstore.png',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'PLANTEEX v1.0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Identifiez vos plantes Instantanément',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/splash.jpg')),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 5.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                              'Vous ne connaissez pas le nom d\'une plante ? Planteex vous aide à identifier les plantes'
                              'que vous ne connaissez pas, à découvrir de belles plantes et à les partager de la maniére la plus'
                              'simple et la plus intéressante qui soit. \n',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                        TextSpan(
                          text: 'Nous avons travaillé dur pour vous offrir '
                              'une meilleure expérience utilisateur et pour optimiser notre algorithme de reconnaissance '
                              'des plantes ! Nous n\'aurions pas pu réussir sans vos suggestions et votre aide et '
                              'nous vous en remercions. \n',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                        TextSpan(
                          text:
                              'Nous aimerions également que quiconque aime les plantes se joigne à notre famille. '
                              'Commençons ensemble un voyage à la découverte des plus belles plantes du monde.',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
