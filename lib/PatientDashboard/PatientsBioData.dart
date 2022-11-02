import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:murtaza_final_project/Models/current_aap_user.dart';
import 'package:murtaza_final_project/PatientDashboard/PatientWelcomeScreen.dart';
import 'package:murtaza_final_project/Widgets/text_field_input.dart';

class PatientsBioData extends StatefulWidget {
  const PatientsBioData({Key? key}) : super(key: key);
  @override
  _PatientsBioDataState createState() => _PatientsBioDataState();
}

class _PatientsBioDataState extends State<PatientsBioData> {
  TextEditingController fulname = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController contact_number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  bool load = false;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    fulname.text = CurrentAppUser.currentUserData.name!;
    dateofbirth.text = CurrentAppUser.currentUserData.dateOfBirth!;
    address.text = CurrentAppUser.currentUserData.address!;
    city.text = CurrentAppUser.currentUserData.cityProvince!;
    contact_number.text = CurrentAppUser.currentUserData.phone!;
    setState(() {});
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your BioData'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            TextFieldInput(
              hintText: 'Enter Full Name: ',
              textInputType: TextInputType.emailAddress,
              textEditingController: fulname,
            ),
            TextFieldInput(
              hintText: 'Date Of Birth',
              textInputType: TextInputType.emailAddress,
              textEditingController: dateofbirth,
            ),
            TextFieldInput(
              hintText: 'Enter Contact Nmber',
              textInputType: TextInputType.emailAddress,
              textEditingController: contact_number,
            ),
            TextFieldInput(
              hintText: 'Address',
              textInputType: TextInputType.emailAddress,
              textEditingController: address,
            ),
            TextFieldInput(
              hintText: 'Enter City, Province',
              textInputType: TextInputType.emailAddress,
              textEditingController: city,
            ),
            SizedBox(
              height: 30,
            ),
            load == false
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      // elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Continue',
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
                        await _update();
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
                : Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  _update() async {
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      'name': fulname.text,
      'dateOfBirth': dateofbirth.text,
      'address': address.text,
      'cityProvince': city.text,
      'phone': contact_number.text,
    });
  }
}
