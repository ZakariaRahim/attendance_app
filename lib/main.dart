import 'package:attendance_app/camera_screen.dart';
import 'package:flutter/material.dart';
import 'closing_session.dart';

void main() {
  runApp(
      MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MyHomePage.id: (context)=>MyHomePage(),
        MyHomePage2.id: (context)=>MyHomePage2()
      },
      home: MyApps(),
    );
  }
}

class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          toolbarHeight: 140.0,
          centerTitle: true,
          title: Text(" Ratendance "),
        //   title: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     CircleAvatar(
        //       radius: 100.0,
        //                   child: Image.asset(     
        //         'images/attend.png',
        //         fit: BoxFit.fitWidth,
               
        //         // height: 82,
        //       ),
        //     ),
             
        //   ],

        // ),
      ),
        
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight:  Radius.circular(20.0)
              ),
            color: Colors.deepPurple,
          ),
          // color: Colors.deepPurple,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 90.0,),
                Container(

                  width: 280.0,
                  child: OutlineButton(onPressed: () {

                    // route to morning page
                    Navigator.pushNamed(context, MyHomePage.id);

                  },
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape:OutlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  child: Text("Opening Session",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                ),
                SizedBox(height: 90.0,),
                Container(
                  width: 280.0,
                  child: OutlineButton(onPressed: () {
                    // route to closing page
                    Navigator.pushNamed(context,MyHomePage2.id);
                  },
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape:OutlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Text("Closing Session",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  }
}
