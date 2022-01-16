import 'package:flutter/material.dart';
import 'package:flutterfirsebasecrud/screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutterfirsebasecrud/screen/storage_helper.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

Future<String> downloadURLExample(img) async {
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref('test/$img')
      .getDownloadURL();
  return downloadURL;
}

var images_paths = "profile.jpg";

class _SignupState extends State<Signup> {
  Color field1Color = Color(0xFF1F1A30);
  Color field2Color = Color(0xFF1F1A30);
  Color field3Color = Color(0xFF1F1A30);
  Color field4Color = Color(0xFF1F1A30);
  double blurRadius1 = 0;
  double blurRadius2 = 0;
  double blurRadius3 = 0;
  double blurRadius4 = 0;
  String image = 'assets/profile.jpg';
  var result;
  var img_url;
  final myControllerName = TextEditingController();
  final myControllerPhone = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerPass = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future signup() async {
    // img_url = downloadURLExample(images_paths);
    print(images_paths);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: myControllerEmail.text, password: myControllerPass.text);
      await FirebaseFirestore.instance.collection('user_details').add({
        'email': myControllerEmail.text,
        'name': myControllerName.text,
        'phone': myControllerPhone.text,
        'image': images_paths,
        // 'img_url' : img_url
      });
      // print("done");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                right: MediaQuery.of(context).size.width * 0.06,
                left: MediaQuery.of(context).size.width * 0.06),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    // Image.asset(),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.005,
                          top: MediaQuery.of(context).size.height * 0.005),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Create Account",
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
                        child: Text("Please fill the input blow here",
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
                            controller: myControllerName,
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
                                Icons.perm_identity_rounded,
                                color: Colors.white,
                              ),
                              labelText: 'Name',
                              labelStyle: TextStyle(height: 5, color: Colors.white),
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
                            controller: myControllerPhone,
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
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                // textDirection :  TextDirection.rtl,
                                Icons.phone_enabled_outlined,
                                color: Colors.white,
                              ),
                              labelText: 'Phone',
                              labelStyle: TextStyle(height: 5, color: Colors.white),
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
                          setState(() => blurRadius3 = hasFocus ? 8 : 0);
              
                          setState(() => field3Color =
                              hasFocus ? Color(0xFF39304d) : Color(0xFF1F1A30));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1F1A30),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF39304d),
                                blurRadius: blurRadius3,
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
                              fillColor: field3Color,
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
                              labelStyle: TextStyle(height: 5, color: Colors.white),
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
                          setState(() => blurRadius4 = hasFocus ? 8 : 0);
              
                          setState(() => field4Color =
                              hasFocus ? Color(0xFF39304d) : Color(0xFF1F1A30));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1F1A30),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF39304d),
                                blurRadius: blurRadius4,
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
                              fillColor: field4Color,
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
                              labelStyle: TextStyle(height: 5, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (result != null)
                      Stack(
                        children: [
                          Positioned(
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.height * 0.05,
                              backgroundImage: FileImage(
                                File(result.files.single.path),
                              ),
                              // child: Image.file(File(result.files.single.path),),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.height * 0.018,
                              backgroundColor: Color(0xFF0CF6E3),
                              child: Icon(
                                Icons.add_a_photo,
                                size: MediaQuery.of(context).size.height * 0.024,
                                color: Color(0xFF39304D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (result == null)
                      InkWell(
                        onTap: () async {
                          result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpeg', 'png', 'jpg'],
                          );
                          setState(() {
                            result = result;
                            print(result);
              
                            Random random = new Random();
                            int randomNumber = random.nextInt(100000000);
                            images_paths =
                                '${randomNumber}_${result.files.single.name}';
                          });
                          Storage a = Storage();
              
                          a.uploadFile(result.files.single.path, images_paths);
                          // a.getDownloadURL();
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.height * 0.05,
                                backgroundImage: AssetImage('assets/profile.jpg'),
                                // child: Image.file(File(result.files.single.path),),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.height * 0.018,
                                backgroundColor: Color(0xFF0CF6E3),
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: MediaQuery.of(context).size.height * 0.024,
                                  color: Color(0xFF39304D),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              
                    Padding(
                      padding: EdgeInsets.only(
                          // bottom: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: ElevatedButton(
                          onPressed: () {
                            signup();
                          },
                          child: Text("SIGN UP",
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
                            padding:
                                EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Home()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Do have an account ",
                                  style: TextStyle(
                                    color: Color(0xFF39304D),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("Login",
                                  style: TextStyle(
                                    color: Color(0xFF0CF6E3),
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
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
