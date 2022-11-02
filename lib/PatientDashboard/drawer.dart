// import 'dart:html';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:murtaza_final_project/Models/current_aap_user.dart';
import 'package:murtaza_final_project/PatientDashboard/my_appionments.dart';
import 'package:murtaza_final_project/PatientDashboard/my_profile.dart';
import 'package:murtaza_final_project/PatientDashboard/my_test.dart';
import 'package:murtaza_final_project/PatientDashboard/show_test.dart';
import 'package:murtaza_final_project/services/database_services.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  String? name;
  String? email;
  File? imageFile;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    name = CurrentAppUser.currentUserData.name!;
    email = CurrentAppUser.currentUserData.email!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  size: 35,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                        onTap: () async {
                          await _getFromGallery();
                          if (imageFile != null) {
                            setState(() {
                              isLoading = true;
                              CurrentAppUser.currentUserData.image;
                            });
                            String? url;
                            url = await DatabaseServices.uploadImage(
                                CurrentAppUser.currentUserData.uid!,
                                imageFile!);
                            if (url != null) {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(CurrentAppUser.currentUserData.uid)
                                  .update({'image': url});
                              CurrentAppUser.currentUserData.image = url;
                              imageFile = null;
                              Fluttertoast.showToast(msg: 'Image uploaded');
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Something went wrong');
                            }
                            setState(() {
                              isLoading = false;
                              CurrentAppUser.currentUserData.image;
                            });
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200000),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200000),
                            ),
                            child: imageFile == null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        CurrentAppUser.currentUserData.image!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "$name",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text("$email",
                    style: TextStyle(fontSize: 17, color: Colors.grey)),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 400,
                  width: 350,
                  padding: EdgeInsets.only(top: 15),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(
                          2.0,
                          2,
                        ),
                      )
                    ],
                  ),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProfile()));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.person_rounded,
                            size: 30,
                          ),
                          title: Text(
                            'About me',
                            style: TextStyle(fontSize: 25),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Myappionments()));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.calendar_today_outlined,
                            size: 30,
                          ),
                          title: Text(
                            'My appointments',
                            style: TextStyle(fontSize: 23),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyTests()));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.sd_card_alert_outlined,
                            size: 30,
                          ),
                          title: Text(
                            'My test ',
                            style: TextStyle(fontSize: 25),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Payments methods clicked');
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.payment,
                            size: 30,
                          ),
                          title: Text(
                            'Payments methods',
                            style: TextStyle(fontSize: 25),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Notifications clicked');
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.notifications_active_outlined,
                            size: 30,
                          ),
                          title: Text(
                            'Notifications',
                            style: TextStyle(fontSize: 25),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Privacy and Security clicked');
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.privacy_tip_outlined,
                            size: 30,
                          ),
                          title: Text(
                            'Privacy & Security',
                            style: TextStyle(fontSize: 22),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }
}
