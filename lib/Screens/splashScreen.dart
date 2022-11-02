import 'package:flutter/material.dart';
import 'package:murtaza_final_project/Screens/onboarding_screen.dart';

class SplashTwo extends StatefulWidget {
  const SplashTwo({Key? key}) : super(key: key);
  @override
  State<SplashTwo> createState() => _SplashTwoState();
}

class _SplashTwoState extends State<SplashTwo> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
      // _getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.0001),
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.fitHeight,
                height: 170,
              ),
            ])));
  }

  // _getUser() async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   print("here is user value ******* " + user.toString());
  //   if (user == null)
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
  //   else {
  //     await CurrentAppUser.currentUserData.getCurrentUserData(user.uid);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => navBar()));
  //   }
  // }
}
