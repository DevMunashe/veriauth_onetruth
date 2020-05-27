import 'package:shared_preferences/shared_preferences.dart';
import 'package:veriauth_onetruth/utils/hexcolor.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40.0, left:20, right: 20),
            child:  Image.asset('assets/images/scan.png',
                                width: 120,
                                height: 150,
                               
                                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0, bottom: 20),
            child: Text(
              "OneTruth. Quick & Safe Check ins.",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 24.0,
                // fontWeight: FontWeight.w700,
                // fontFamily: "UbuntuBold",
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(
          //     "Sign into an existing account or create a new account.",
          //     softWrap: true,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.white,
          //       decoration: TextDecoration.none,
          //       fontSize: 15.0,
          //       fontWeight: FontWeight.w300,
          //       fontFamily: "UbuntuRegular",
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child:RaisedButton(
                                
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.white)),
      onPressed: () {
 
        Navigator.of(context).pushNamed("/checkin");
      },
      color: Colors.green,
       elevation: 5,
      textColor: Colors.white,
      child:Container(
                      alignment: Alignment.center,
                     width: 150,
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Check In',style: TextStyle( fontSize: 15)),
                    ),
    ),

          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child:RaisedButton(
                                
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.white)),
      onPressed: () {
        _setSeen();
      //  Navigator.of(context).pushNamed("/register");
      },
      color:  Colors.green,
       elevation: 5,
      textColor: Colors.white,
      child:Container(
                      alignment: Alignment.center,
                     width: 150,
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Register Self',style: TextStyle(fontSize: 15)),
                    ),
    ),
            
          ),
        ],
      ),
    );
  }

 Future _setSeen() async {
   final SharedPreferences prefs =   await SharedPreferences.getInstance();
   prefs.setBool('seen', true);
  }
  
}
