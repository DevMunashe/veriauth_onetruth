import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:veriauth_onetruth/utils/consts.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:ui';
import 'dart:async';

import 'package:veriauth_onetruth/utils/progress_painter.dart';

class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin>  with SingleTickerProviderStateMixin {

 double _percentage;
  double _nextPercentage;
  Timer _timer;
  AnimationController _progressAnimationController;
  bool _progressDone;

   @override
  initState() {
    super.initState();
    _percentage = 0.0;
    _nextPercentage = 0.0;
    _timer = null;
    _progressDone = false;
    initAnimationController();
  }

  initAnimationController() {
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(
        () {
          setState(() {
            _percentage = lerpDouble(_percentage, _nextPercentage,
                _progressAnimationController.value);
          });
        },
      );
  }

  start() {
    Timer.periodic(Duration(milliseconds: 30), handleTicker);
  }

  handleTicker(Timer timer) {
    _timer = timer;
    if (_nextPercentage < 100) {
      publishProgress();
    } else {
      timer.cancel();
      setState(() {
        _progressDone = true;
      });
    }
  }

  startProgress() {
    if (null != _timer && _timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _percentage = 0.0;
      _nextPercentage = 0.0;
      _progressDone = false;
      start();
    });
  }

  publishProgress() {
    setState(() {
      _percentage = _nextPercentage;
      _nextPercentage += 0.5;
      if (_nextPercentage > 100.0) {
        _percentage = 0.0;
        _nextPercentage = 0.0;
      }
      _progressAnimationController.forward(from: 0.0);
    });
  }

  getDoneImage() {
    return Image.asset(
      "images/checkmark.png",
      width: 50,
      height: 50,
    );
  }

  getProgressText() {
    return Text(
      _nextPercentage == 0 ? '' : '${_nextPercentage.toInt()}',
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.w800, color: Colors.green),
    );
  }

  progressView() {
    return CustomPaint(
      child: Center(
        child: _progressDone ? getDoneImage() : getProgressText(),
      ),
      foregroundPainter: ProgressPainter(
          defaultCircleColor: Colors.amber,
          percentageCompletedCircleColor: Colors.green,
          completedPercentage: _percentage,
          circleWidth: 10.0),
    );
  }

  statusDialog(String qrcode){
    return EasyDialog(
      height: 300,
      title: Text(
        "Checking into " + qrcode ,
        style: TextStyle(fontWeight: FontWeight.bold),
        textScaleFactor: 1.2,
      ),
      // description: Text(
      //   "This is a basic dialog",
      //   textAlign: TextAlign.center,
      // ),

      contentList: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, ),
            child:SizedBox(child:  CircularProgressIndicator(backgroundColor: Colors.green,strokeWidth: 5.0,), height: 100,width: 100,))
      ]).show(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 5.0,
        backgroundColor: Colors.green,
        title: Text(Constants.appName,style: TextStyle(fontSize: 25,)),
        centerTitle: true,
        
        // actions: <Widget>[
        //   new IconButton(icon: Icon(Icons.refresh, color: Colors.white), onPressed: (){}),
        //   new IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: (){}),
        //   ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            // drawer header
            // new UserAccountsDrawerHeader(
            //   accountEmail: Text('munasheshonge@gmail.com',style: TextStyle(fontSize: 18,color: Colors.white)), 
            //   accountName: Text('Munashe Shonge',style: TextStyle(fontSize: 18,color: Colors.white)),
            //   currentAccountPicture: new GestureDetector(
            //     child: new CircleAvatar(
            //       //backgroundColor: Colors.grey,
            //      backgroundImage: AssetImage('assets/avatar.jpg'),
            //     ),
            //   ),
            //     decoration: BoxDecoration(
            //       color: Colors.green
            //     ),
            //   ),

              //body of nav drawer widget
              InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('Check In', style: TextStyle(fontSize: 20),
                 
                  ),
                  leading: Icon(Icons.dashboard, color: Colors.green,),
                ),
              ),


              InkWell(
                  onTap: (){
              //       Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => WeatherScreen()),
          //  );
                  },
                  child: ListTile(
                  title: Text('My ID', style: TextStyle(fontSize: 20, ),
                  ),
                  leading: Icon(FontAwesome.qrcode, color: Colors.orange,),
                ),
              ),

              //Divider(), //insert widget separator line
               InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('Checkin History', style: TextStyle(fontSize: 20,),
                  ),
                  leading: Icon(FontAwesome.history, color: Colors.green,),
                ),
              ),

              InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('My Account', style: TextStyle(fontSize: 20, ),
                  ),
                  leading: Icon(FontAwesome.user, color: Colors.red,),
                ),
              ),


                  Divider(), //insert widget separator line


                   InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('Settings', style: TextStyle(fontSize: 20,),
                  ),
                  leading: Icon(FontAwesome.cog),
                ),
              ),

               InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('About OneTruth', style: TextStyle(fontSize: 20),
                  ),
                  leading: Icon(FontAwesome.info),
                ),
              )
          ],
        ),
      ),

      body: new ListView(
        children: <Widget>[
          //image_carousel,
         // banner,
          new Padding(padding: const EdgeInsets.all(2.0),
          //child: new Text('Categories',),
          ), 
          

          //horizontal listview begins here
         //  HorizontalList(),

         //  new Padding(padding: const EdgeInsets.all(8.0),
         // child: new Text('Dashboard'),),

          //gridview with dashboard report items
          new Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/scan.png', height: 200, width: 200 ,),

                Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child:RaisedButton(
                                
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.white)),
      onPressed: () {
                   
                   
                  
        _scan().then((qrcode) {
          print("FUTURE CODE " + qrcode);
 startProgress();
 statusDialog(qrcode);
           
          
        }
        );
       // Navigator.of(context).pushNamed("/checkin");
      },
      color: Colors.green,
       elevation: 5,
      textColor: Colors.white,
      child:Container(
                      alignment: Alignment.center,
                     width: 150,
                     height: 80,
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Check In',style: TextStyle( fontSize: 15)),
                    ),
    ),

          ),

              ],
            )
            ),
            padding: const EdgeInsets.only(bottom:80.0), //pad bottom to prevent grid item overflow
          //child: new Text('Categories',),
          
            
            
          ),
         
        ],
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    return barcode;
   // print("CODE"+barcode);
    //this._outputController.text = barcode;
  }
}