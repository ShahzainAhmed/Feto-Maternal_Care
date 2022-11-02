// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:murtaza_final_project/Models/appoinments.dart';
import 'package:murtaza_final_project/Models/current_aap_user.dart';

class Myappionments extends StatefulWidget {
  const Myappionments({Key? key}) : super(key: key);

  @override
  State<Myappionments> createState() => _MyappionmentsState();
}

class _MyappionmentsState extends State<Myappionments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text("MY APPIONMENTS"),
        )),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  _streamBiulderr(),
                ]))));
  }

  myAppionments(String drName, String date, String time, String comment,
      String virtual, String onsite, AppoinmentsData appoinmentsData) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // width: 345,
          // height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(
                  0.0,
                  0.0,
                ),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Doctor Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(drName,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(date,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(time,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Comment",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(comment,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Virtual",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(virtual,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Onsite",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(onsite,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _streamBiulderr() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("appoinmetns")
            .where("uid", isEqualTo: CurrentAppUser.currentUserData.uid)
            // .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading");
          }
          if (!snapshot.hasData) {
            return Text("has no data");
          }
          if (snapshot.hasError) {
            return Text("somthing went wrong");
          }

          List<AppoinmentsData> appionmentData = [];
          appionmentData = snapshot.data!.docs
              .map<AppoinmentsData>((e) =>
                  AppoinmentsData.fromMap(e.data() as Map<String, dynamic>))
              .toList();

          return Container(
            child: Column(
                children:
                    appionmentData.map<Widget>((AppoinmentsData document) {
              return myAppionments(
                "${document.drName}",
                "${document.date}",
                "${document.time}",
                "${document.comment}",
                "${document.physical}",
                "${document.onsite}",
                document,
              );
            }).toList()),
          );
        });
  }
}
