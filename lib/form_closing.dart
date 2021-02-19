/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String deviceId;
  String status;
  String userName;
  String coordinates;
  String date;

  FeedbackForm(this.userName, this.status, this.coordinates,this.date, this.deviceId);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['userName']}",
        "${json['status']}",
        "${json['coordinates']}",
        "${json['date']}",
        "${json['deviceId']}");
  }

  // Method to make GET parameters.
  Map toJson() => {'userName': userName,
                    'status': status,
                   'coordinates':coordinates,
                    'date':date,
                    'deviceId':deviceId
  };
}
