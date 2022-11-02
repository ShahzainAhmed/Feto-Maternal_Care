import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:murtaza_final_project/Models/app_user.dart';
// import 'package:murtaza_final_project/PatientDashboard/loginScreen.dart';
import 'package:murtaza_final_project/Screens/loginScreen.dart';
import 'package:murtaza_final_project/Widgets/text_field_input.dart';

class SignUpForPatient extends StatefulWidget {
  const SignUpForPatient({Key? key}) : super(key: key);

  @override
  _SignUpForPatientState createState() => _SignUpForPatientState();
}

class _SignUpForPatientState extends State<SignUpForPatient> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool load = false;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 100),
          child: Column(
            children: [
              Text(
                'Welcome to Fetomaternal Care!',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'You can start using this application after sign up.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldInput(
                hintText: 'Enter Full Name',
                textInputType: TextInputType.emailAddress,
                textEditingController: nameController,
              ),
              TextFieldInput(
                hintText: 'Enter Email Address',
                textInputType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              TextFieldInput(
                hintText: 'Enter Password',
                textInputType: TextInputType.emailAddress,
                textEditingController: passwordController,
                isPass: true,
              ),
              load == false
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        // elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Create account',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        // color: Colors.blueAccent,
                        // shape: RoundedRectangleBorder(
                        //     borderRadius:
                                // BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () async {
                          setState(() {
                            load = true;
                          });
                          await signUp(
                              emailController.text, passwordController.text);
                          setState(() {
                            load = false;
                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => LoginScreen()),
                          // );
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Row(
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text('LogIn.'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    AppUser userModel = AppUser();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;
    // userModel.role = asAController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(AppUser.toMap(userModel));
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.push(
        (context), MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
