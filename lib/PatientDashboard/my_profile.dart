import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:murtaza_final_project/Models/current_aap_user.dart';
import 'package:murtaza_final_project/services/database_services.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? name;
  String? email;
  String? dateOfBirth;
  String? address;
  String? city;
  String? phone;
  File? imageFile;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    email = CurrentAppUser.currentUserData.email!;
    name = CurrentAppUser.currentUserData.name!;
    dateOfBirth = CurrentAppUser.currentUserData.dateOfBirth!;
    address = CurrentAppUser.currentUserData.address!;
    city = CurrentAppUser.currentUserData.cityProvince!;
    phone = CurrentAppUser.currentUserData.phone!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text('MY PROFILE'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                    onTap: () async {
                      // await _getFromGallery();
                      if (imageFile != null) {
                        setState(() {
                          isLoading = true;
                          CurrentAppUser.currentUserData.image;
                        });
                        String? url;
                        url = await DatabaseServices.uploadImage(
                            CurrentAppUser.currentUserData.uid!, imageFile!);
                        if (url != null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(CurrentAppUser.currentUserData.uid)
                              .update({'image': url});
                          CurrentAppUser.currentUserData.image = url;
                          imageFile = null;
                          Fluttertoast.showToast(msg: 'Image uploaded');
                        } else {
                          Fluttertoast.showToast(msg: 'Something went wrong');
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
                                imageUrl: CurrentAppUser.currentUserData.image!,
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "$name",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "$email",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "$phone",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date of birth",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "$dateOfBirth",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "City",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "$city",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                // elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                // color: Colors.blueAccent,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
