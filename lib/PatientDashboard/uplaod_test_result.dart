// import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:murtaza_final_project/Models/appoinments.dart';
import 'package:murtaza_final_project/Models/current_aap_user.dart';
// import 'package:murtaza_final_project/Models/current_aap_user.dart';
import 'package:murtaza_final_project/PatientDashboard/PatientWelcomeScreen.dart';
import 'package:murtaza_final_project/Widgets/text_field_input.dart';
import 'package:murtaza_final_project/services/database_services.dart';

class UploadTest extends StatefulWidget {
  const UploadTest({Key? key}) : super(key: key);
  @override
  _UploadTestState createState() => _UploadTestState();
}

class _UploadTestState extends State<UploadTest> {
  // TextEditingController drNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController testNameController = TextEditingController();
  TextEditingController commintController = TextEditingController();
  TextEditingController labNameController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool load = false;
  File? FrontImage;
  String dbImageLink = '';
//  File? imageFile;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uplaod Test"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldInput(
              hintText: 'Test name',
              textInputType: TextInputType.emailAddress,
              textEditingController: testNameController,
            ),
            TextFieldInput(
              hintText: 'Date',
              textInputType: TextInputType.emailAddress,
              textEditingController: dateController,
            ),
            TextFieldInput(
              hintText: 'Lab Name',
              textInputType: TextInputType.emailAddress,
              textEditingController: labNameController,
            ),
            TextFieldInput(
              hintText: 'Result',
              textInputType: TextInputType.emailAddress,
              textEditingController: resultController,
            ),
            TextFieldInput(
              hintText: 'Transmiter/Comment',
              textInputType: TextInputType.emailAddress,
              textEditingController: commintController,
            ),
            SizedBox(
              height: 10,
            ),
            FrontImage != null
                ? GestureDetector(
                    onTap: () {
                      _getFromGallery1();
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Image.file(FrontImage!),
                    ))
                : dbImageLink.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _getFromGallery1();
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          child: Image.network(
                            dbImageLink,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          _getFromGallery1();
                        },
                        child: Icon(Icons.image_outlined, size: 150)),
            load == false
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      // elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Summit Test',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      // color: Colors.blueAccent,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(16.0))),
                      onPressed: () async {
                        setState(() {
                          load = true;
                        });
                        await _uplaodTest();
                        setState(() {
                          load = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientWelcomeScreen()),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )),
                  ),
          ],
        ),
      ),
    );
  }

  _uplaodTest() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    String? FrontUrl;
    FrontUrl = await DatabaseServices.uploadImage(
        CurrentAppUser.currentUserData.uid!, FrontImage!);

    AppoinmentsData appionmetsModel = AppoinmentsData();

    // writing all the values
    appionmetsModel.testName = testNameController.text;
    appionmetsModel.uid = user!.uid;
    appionmetsModel.date = dateController.text;
    appionmetsModel.labName = labNameController.text;
    appionmetsModel.comment = commintController.text;
    appionmetsModel.result = resultController.text;
    appionmetsModel.image = FrontUrl;
    // appionmetsModel.onsite = "$onsite";
    // appionmetsModel.role = asAController.text;

    await firebaseFirestore
        .collection("tests")
        .doc()
        .set(AppoinmentsData.toMap(appionmetsModel));
    Fluttertoast.showToast(msg: "test uploaded");
    Navigator.pop(context);
  }

  _getFromGallery1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      FrontImage = File(pickedFile.path);
      setState(() {});
    }
  }
}
