import 'package:cloud_firestore/cloud_firestore.dart';

class AppoinmentsData {
  String? uid;
  String? drName;
  Timestamp? createdAt;
  String? date;
  String? image;
  String? time;
  String? comment;
  String? testComment;
  String? physical;
  String? onsite;
  String? testName;
  String? result;
  String? labName;

  AppoinmentsData(
      {this.uid,
      this.drName,
      this.date,
      this.createdAt,
      this.time,
      this.comment,
      this.physical,
      this.onsite,
      this.labName,
      this.result,
      this.testName,
      this.testComment,
      this.image});

  // receiving data from server
  static AppoinmentsData fromMap(Map<String, dynamic> map) {
    return AppoinmentsData(
        uid: map['uid'],
        drName: map['drName'],
        date: map['date'],
        createdAt: map['created_at'],
        time: map['time'],
        comment: map['comment'],
        onsite: map['onsite'],
        physical: map['physical'],
        labName: map['labName'],
        result: map['result'],
        testName: map['testName'],
        testComment: map['testComment'],
        image: map['image']);
  }

  // sending data to our server
  static Map<String, dynamic> toMap(AppoinmentsData userM) {
    return {
      'uid': userM.uid,
      'drName': userM.drName,
      'date': userM.date,
      'created_at': Timestamp.now(),
      'time': userM.time,
      'comment': userM.comment,
      'physical': userM.physical,
      'onsite': userM.onsite,
      'testName': userM.testName,
      'labName': userM.labName,
      'result': userM.result,
      'testComment': userM.testComment,
      'image': userM.image,
    };
  }
}
