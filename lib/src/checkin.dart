import 'package:flutter/material.dart';
import 'package:veriauth_onetruth/utils/consts.dart';
import 'package:veriauth_onetruth/utils/hexcolor.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text(Constants.appName,style: TextStyle(fontSize: 25,)),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.refresh, color: Colors.white), onPressed: (){}),
          new IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: (){}),
          ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            // drawer header
            new UserAccountsDrawerHeader(
              accountEmail: Text('munasheshonge@gmail.com',style: TextStyle(fontSize: 18,color: Colors.white)), 
              accountName: Text('Munashe Shonge',style: TextStyle(fontSize: 18,color: Colors.white)),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  //backgroundColor: Colors.grey,
                 backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
              ),
                decoration: BoxDecoration(
                  color: Colors.green
                ),
              ),

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
                  leading: Icon(Icons.wb_sunny, color: Colors.orange,),
                ),
              ),

              //Divider(), //insert widget separator line
               InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('Checkin History', style: TextStyle(fontSize: 20,),
                  ),
                  leading: Icon(Icons.schedule, color: Colors.green,),
                ),
              ),

              InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('My Account', style: TextStyle(fontSize: 20, ),
                  ),
                  leading: Icon(Icons.multiline_chart, color: Colors.red,),
                ),
              ),


                  Divider(), //insert widget separator line


                   InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('Settings', style: TextStyle(fontSize: 20,),
                  ),
                  leading: Icon(Icons.settings),
                ),
              ),

               InkWell(
                  onTap: (){},
                  child: ListTile(
                  title: Text('About OneTruth', style: TextStyle(fontSize: 20),
                  ),
                  leading: Icon(Icons.help),
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
                Image.asset('assets/images/scan.png', height: 300, width: 300 ,),

                Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child:RaisedButton(
                                
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.white)),
      onPressed: () {
        _scan();
       // Navigator.of(context).pushNamed("/checkin");
      },
      color: Colors.lightGreenAccent,
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
    print(barcode);
    //this._outputController.text = barcode;
  }
}