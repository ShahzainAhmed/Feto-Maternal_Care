import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:murtaza_final_project/Models/appoinments.dart';
// import 'package:murtaza_final_project/Models/current_aap_user.dart';
import 'package:murtaza_final_project/PatientDashboard/PatientWelcomeScreen.dart';
import 'package:murtaza_final_project/Widgets/text_field_input.dart';

class MakeAppoinmentScreen extends StatefulWidget {
  const MakeAppoinmentScreen({Key? key}) : super(key: key);
  @override
  _MakeAppoinmentScreenState createState() => _MakeAppoinmentScreenState();
}

class _MakeAppoinmentScreenState extends State<MakeAppoinmentScreen> {
  // TextEditingController drNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController commintController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool load = false;
  bool vertual = false;
  bool onsite = false;
  User? user = FirebaseAuth.instance.currentUser;
  String drName = 'Doctor Name';
  // List of items in our Dropdown menu
  var dr = [
    'Doctor Name',
    'Doctor Faheem Ahmed',
    'Doctor Murtaza Bozdar',
    'Doctor Asif Jagirani',
    'Doctor Raheel Shaikh',
    'Doctor Gulzar Jakhro',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton(
              // Initial Value
              value: drName,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: dr.map((String itemsForIntrested) {
                return DropdownMenuItem(
                  value: itemsForIntrested,
                  child: Text(itemsForIntrested),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  drName = newValue!;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldInput(
              hintText: 'Date',
              textInputType: TextInputType.emailAddress,
              textEditingController: dateController,
            ),
            TextFieldInput(
              hintText: 'Time',
              textInputType: TextInputType.emailAddress,
              textEditingController: timeController,
            ),
            TextFieldInput(
              hintText: 'Transmiter/Comment',
              textInputType: TextInputType.emailAddress,
              textEditingController: commintController,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Checkbox(
                  value: vertual,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      vertual = !vertual;
                      onsite = false;
                    });
                  },
                ),
                // SizedBox(height: 10),
                Text("Vertual",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    )),
                Checkbox(
                  value: onsite,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      onsite = !onsite;
                      vertual = false;
                    });
                  },
                ),
                // SizedBox(height: 10),
                Text("Onsite",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    )),
              ],
            ),
            load == false
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      // elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Summit Appoinment',
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
                        await _uplaodAppoinment();
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
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  _uplaodAppoinment() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    AppoinmentsData appionmetsModel = AppoinmentsData();

    // writing all the values
    appionmetsModel.drName = drName;
    appionmetsModel.uid = user!.uid;
    appionmetsModel.date = dateController.text;
    appionmetsModel.time = timeController.text;
    appionmetsModel.comment = commintController.text;
    appionmetsModel.physical = "$vertual";
    appionmetsModel.onsite = "$onsite";
    // appionmetsModel.role = asAController.text;

    await firebaseFirestore
        .collection("appoinmetns")
        .doc()
        .set(AppoinmentsData.toMap(appionmetsModel));
    Fluttertoast.showToast(msg: "Appoinment booked");
    Navigator.pop(context);
  }
}
