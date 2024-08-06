import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myweatherapp/services/FirebaseAuth.services.dart';
import 'package:myweatherapp/views/RegPage.dart';
import 'package:myweatherapp/views/weatherPage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ReguserName = TextEditingController();
    TextEditingController ReguserEmail = TextEditingController();
    TextEditingController ReguserPassword = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    FirebaseAuthServices _auth = FirebaseAuthServices();
    
    void signIn() async {
      String email = ReguserEmail.text;
      String password = ReguserPassword.text;
      // ignore: unused_local_variable
      String userName = ReguserName.text;
      User? user = await _auth.SignInWithEmailAndPasword(email, password);
      if (user != null) {
        print("login sucessfull");
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return WeatherPage();
        }));
      } else {
        print("error occured");
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 242, 242),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenWidth * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Text(
                  "Myweather Login Page",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.15,
            ),
            Center(
              child: SizedBox(
                width: screenWidth * 0.9,
                child: TextFormField(
                  controller: ReguserName,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white38)),
                    fillColor: Color.fromARGB(255, 254, 254, 254),
                    filled: true,
                    labelText: "Name",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: TextField(
                controller: ReguserEmail,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    labelText: "Email",
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: TextField(
                controller: ReguserPassword,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    labelText: "Password",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.35,
            ),
            GestureDetector(
              onTap: () {
                signIn();
                if (_formKey.currentState!.validate()) {
                  
                }
              },
              child: Container(
                width: screenWidth * 0.60,
                height: screenHeight * 0.055,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Center(
                    child: Text(
                  "SignIn",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account?"),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return Regpage();
                    }));
                  },
                  child: Text(
                    " Register",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w900),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
