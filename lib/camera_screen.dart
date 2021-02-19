
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as Io;
import 'package:unique_id/unique_id.dart';
import 'form.dart';
import 'form_controller.dart';
import 'package:geolocator/geolocator.dart';




class MyHomePage extends StatefulWidget {


  static const String id='camerascreen';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState  extends State<MyHomePage> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10.0,),

          // Text('Device Id: ' + _deviceId),
          SizedBox(
            height: 10.0,
          ),
         // Row(children: [
            TextField(
               controller: userName,
               decoration: const InputDecoration(
                 hintText: 'Enter Your Full Name',
               ),

             ),

           Text('Status:'+ _status,
             style: TextStyle(fontSize: 23.0
             ),
           ),
          //  Text('Condinates: '+ _coordinates,
          //    style: TextStyle(fontSize: 20.0
          //    ),
          //  ),
          Text('Time: ' + date.toString(),
            style: TextStyle(fontSize: 20.0
            ),
          ),
           Text('Signature: ' + _deviceId.toString(),
             style: TextStyle(fontSize: 22.0
             ),
           ),

         // ],
         // ),

          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed:getUserDetails,
            child: Text('Generate'),
          ),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed:_submitForm,
            child: Text('Submit Attendance'),
          ),
          // RaisedButton(
          //   color: Colors.blue,
          //   textColor: Colors.white,
          //   onPressed:exit(0),
          //   child: Text('Close'),
          // ),

        ],
      ),

    );
  }

  void getUserDetails() async {
    // LocationPermission permission = await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _locationMessage = "${position.latitude}, ${position.longitude}";
    if(_deviceId !=null && _coordinates !=null) {
      setState(()  {

       // if(position.latitude < 9.3873267 && position.longitude<-0.899183 ){
       //   _status = "Out of Range";
       // } else if(position.latitude>9.3873267 && position.longitude>-0.8989183){
       //   _status="Out of Range";
       // }else{
       //   _status="Within Range";
       // }
        if(position.latitude<=9.3799617 && position.latitude > 9.3699617  && position.latitude <9.3801709){
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


