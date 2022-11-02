import 'package:flutter/material.dart';
import 'package:murtaza_final_project/PatientDashboard/uplaod_test_result.dart';

class Tests extends StatefulWidget {
  const Tests({Key? key}) : super(key: key);
  @override
  _TestsState createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  final TextEditingController _testcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tests'),
        ),
        body: UploadTest());
  }
}
