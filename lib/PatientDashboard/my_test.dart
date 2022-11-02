// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:murtaza_final_project/Models/appoinments.dart';
import 'package:murtaza_final_project/Models/current_aap_user.dart';

class MyTests extends StatefulWidget {
  const MyTests({Key? key}) : super(key: key);

  @override
  State<MyTests> createState() => _MyTestsState();
}

class _MyTestsState extends State<MyTests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text("MY TETS"),
        )),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  _streamBiulderForTest(),
                ]))));
  }

  myTests(String testName, String date, String labName, String comment,
      String result, String image, AppoinmentsData appoinmentsData) {
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
                    Text("Test Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(testName,
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
                    Text("Lab Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(labName,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Result",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(result,
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
                Image(
                  image: NetworkImage(image),
                  height: 180,
                ),
              ],
            ),
          ),
        ));
  }

  _streamBiulderForTest() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("tests")
            .where("uid", isEqualTo: CurrentAppUser.currentUserData.uid)
            // .doc()
            // .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading");
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
              return myTests(
                "${document.testName}",
                "${document.date}",
                "${document.labName}",
                "${document.result}",
                "${document.comment}",
                "${document.image}",
                document,
              );
            }).toList()),
          );
        });
  }
}
