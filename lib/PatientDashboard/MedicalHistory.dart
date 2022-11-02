import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:murtaza_final_project/Models/appoinments.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({Key? key}) : super(key: key);
  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final TextEditingController _testcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical History'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: TextField(
                  controller: _testcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.grey.shade400,
                    ),
                    hintText: 'search for test',
                    hintStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              Text(
                "Appionments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              _streamBiulderForAppionments(),
              Text("Tests",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              _streamBiulderForTest()
            ],
          ),
        ),
      ),
    );
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

  _streamBiulderForAppionments() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("appoinmetns")
            // .doc()
            .orderBy('created_at', descending: true)
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

myTests(String testName, String date, String labName, String comment,
    String result, String image,AppoinmentsData appoinmentsData) {
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
          // .doc()
          .orderBy('created_at', descending: true)
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
              children: appionmentData.map<Widget>((AppoinmentsData document) {
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
