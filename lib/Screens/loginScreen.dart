import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:murtaza_final_project/Doctors%20info/doctorsBioData.dart';
import 'package:murtaza_final_project/Models/current_aap_user.dart';
import 'package:murtaza_final_project/PatientDashboard/PatientsBioData.dart';
import 'package:murtaza_final_project/PatientDashboard/signUpPatient.dart';
// import 'package:murtaza_final_project/Screens/CustomerVerification.dart';
import 'package:murtaza_final_project/Widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool load = false;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            width: 20,
            height: 100,
          ),
          Text(
            'WelCome Back',
            style: TextStyle(
                fontSize: 40,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Iam happy to see you again. You can continue where you left off by logging in.',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFieldInput(
            hintText: 'Enter Email Address',
            textInputType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          TextFieldInput(
            hintText: 'Enter assword',
            textInputType: TextInputType.emailAddress,
            textEditingController: passwordController,
            isPass: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 190.0),
            child: TextButton(
              onPressed: () {},
              child: Text('Forgot Your Password?'),
            ),
          ),
          load == false
              ? Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: ElevatedButton(
                    // elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'LogIn',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    // color: Colors.blueAccent,
                    // shape: RoundedRectangleBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () async {
                      setState(() {
                        load = true;
                      });
                      await signIn(
                          emailController.text, passwordController.text);
                      setState(() {
                        load = false;
                      });
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
                Text("Don't have an account yet?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpForPatient()),
                      );
                    },
                    child: Text('Sign Up.'))
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                CurrentAppUser.currentUserData
                    .getCurrentUserData(uid.user!.uid),
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PatientsBioData())),
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
}
