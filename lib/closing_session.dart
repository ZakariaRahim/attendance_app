
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_id/unique_id.dart';
import 'form_closing.dart';
import 'closing_form_controller.dart';
import 'package:geolocator/geolocator.dart';




class MyHomePage2 extends StatefulWidget {


  static const String id='closingscreen';
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State  extends State<MyHomePage2> {
  final _formKey = GlobalKey<FormState>();
  String _locationMessage = "";
  String _deviceId="Signature";
  String _status="Status";
  TextEditingController userName=new TextEditingController();
  String _coordinates="Coordinate";
  String date="Date and time";
  final _scaffoldKey= GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text('Attendance App'),
      ),
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            //  transform: Matrix4.rotationZ(5.0),
            width: 500,
            height: 1000,
            color: Colors.red.shade400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Closing Session',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(
                    // height: 10.0,
                    ),
                // Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Container(
                      width: 400.0,
                      height: 1.0,
                      color: Colors.black,
                    ),
                  ),
                   SizedBox(
                    height: 10.0,
                    ),
                Container(
                  margin: EdgeInsets.only(left:20.0),
                  width: 270.0,
                  child: TextField(
                    
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.characters,
                    controller: userName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: 'Enter Your Full Name',
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),

                Text(
                  'Status:' + _status,
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //  Text('Condinates: '+ _coordinates,
                //    style: TextStyle(fontSize: 20.0
                //    ),
                //  ),
                Container(
                    margin: EdgeInsets.only(left:20.0),
                  child: Text(
                    'Time: ' + date.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left:45.0),
                  child: Text(
                    
                    'Signature: ' +  _deviceId.toString(),
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: getUserDetails,
                  child: Text('Generate'),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: _submitForm,
                  child: Text('Submit Attendance'),
                ),
               
              ],
            ),
          ),
          Container(
            transform: Matrix4.rotationZ(5.0),
            width: 500,
            height: 600,
            color: Colors.blue,
            child:  Image.asset(     
                'images/attend.png',
                fit: BoxFit.contain,
               width: 50.0,
                height: 50.0,
              ),
          ),
          Container(
            width: 50,
            height: 1000,
            color: Colors.blue,
          ),
        ]
      ),
       floatingActionButton: FloatingActionButton(onPressed: (){
         

       if(Platform.isAndroid){
         SystemNavigator.pop();
       }else{
        SystemChannels.platform.invokeMethod('SystemNavigator.pop()');
       }
     },
     child:Icon(Icons.close)
     ),
    );
  }

  void getUserDetails() async {
    // LocationPermission permission = await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _locationMessage = "${position.latitude}, ${position.longitude}";
    if(_deviceId !=null && _coordinates !=null) {
      setState(()  {

      
        if(
           position.latitude > 9.37899617 &&
            position.latitude < 9.3799527)
        {
          _status="Within Range";
        } else{
          _status="Out of Range";
        }
        _coordinates = _locationMessage;
        var currentDay = new DateTime.now();
        date = currentDay.day.toString() + ' /' +
            currentDay.month.toString() + ' / ' +
            currentDay.year.toString() + ': ' +"   " +
            currentDay.hour.toString() +  ': ' +
            currentDay.minute.toString() + ":" +
            currentDay.second.toString();


      });
      _deviceId= await UniqueId.getID;
    }
  }

  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_deviceId !=null) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
        //SUBMITTING USER DETAILS
          userName.text,
          _status.toString(),
          _coordinates.toString(),
          date.toString(),
          _deviceId.toString()
      );
      FormController formController = FormController();

      _showSnackbar("Submitting...");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved successfully in Google Sheets.
          _showSnackbar("Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Data could not be submitted!");
        }
      });
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    // message='working';
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  }


