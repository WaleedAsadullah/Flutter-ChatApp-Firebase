import 'package:flutter/material.dart';
import 'package:flutterfirsebasecrud/screen/Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirsebasecrud/screen/Chatpage.dart';
import 'package:flutterfirsebasecrud/screen/TestingStorage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color field1Color = Color(0xFF1F1A30);
  Color field2Color = Color(0xFF1F1A30);
  double blurRadius1 = 0;
  double blurRadius2 = 0;
  final myControllerEmail = TextEditingController();
  final myControllerPass = TextEditingController();
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  Future signup() async {
    // Center(
    //     child: CircularProgressIndicator(backgroundColor: Color(0xFF0CF6E3) ,),
    //   );
    try {
      
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: myControllerEmail.text, password: myControllerPass.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Chatpage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
    }
  }

  Widget build(BuildContext context) {
    // Color passColor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF1F1A30),
          // 39304d
          // 0CF6E3
          // 0df6e3
          child: Padding(
            padding: EdgeInsets.only(
                // top: MediaQuery.of(context).size.height * 0.06,
                right: MediaQuery.of(context).size.width * 0.06,
                left: MediaQuery.of(context).size.width * 0.06),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    // Image.asset(),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.005,
                          top: MediaQuery.of(context).size.height * 0.005),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.005,
                          top: MediaQuery.of(context).size.height * 0.005),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Please sign to continue",
                            style: TextStyle(
                              color: Color(0xFF39304D),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01),
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          setState(() => blurRadius1 = hasFocus ? 8 : 0);

                          setState(() => field1Color =
                              hasFocus ? Color(0xFF39304d) : Color(0xFF1F1A30));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1F1A30),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF39304d),
                                blurRadius: blurRadius1,
                                offset: Offset(0, 0), // Shadow position
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: myControllerEmail,
                            cursorColor: Colors.white,
                            style: TextStyle(
                                color: Colors.white,
                                height: 1.4,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              fillColor: field1Color,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide.none,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(height: 5, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01),
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          setState(() => blurRadius2 = hasFocus ? 8 : 0);

                          setState(() => field2Color =
                              hasFocus ? Color(0xFF39304d) : Color(0xFF1F1A30));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1F1A30),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF39304d),
                                blurRadius: blurRadius2,
                                offset: Offset(0, 0), // Shadow position
                              ),
                            ],
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: myControllerPass,
                            cursorColor: Colors.white,
                            style: TextStyle(
                                color: Colors.white,
                                height: 1.4,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              fillColor: field2Color,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide.none,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(height: 5, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01),
                      child: ElevatedButton(
                          onPressed: () {
                            print("done");
                            signup();
                          },
                          child: Text("LOGIN",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF39304D),
                                fontWeight: FontWeight.bold,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0CF6E3),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 18),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1,
                      ),
                      child: Text("Forgot Password!",
                          style: TextStyle(
                            color: Color(0xFF0CF6E3),
                            fontWeight: FontWeight.bold,
                          )),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account ",
                                  style: TextStyle(
                                    color: Color(0xFF39304D),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("Sign Up!",
                                  style: TextStyle(
                                    color: Color(0xFF0CF6E3),
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => TestingStorage()));
                    //     },
                    //     child: Text("testing work")),
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => TestingStorage()));
                    //     },
                    //     child: Text("testing work 26 dec")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //       // When the button is pressed,
      //       // give focus to the text field using myFocusNode.

      //       tooltip: 'Focus Second Text Field',
      //       child: const Icon(Icons.edit),
      //     ),
    );
  }
}
