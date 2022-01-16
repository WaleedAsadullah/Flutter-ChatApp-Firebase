import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirsebasecrud/screen/Messagepage.dart';
import 'package:flutterfirsebasecrud/screen/Signup.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  Color field2Color = Color(0xFF1F1A30);
  double blurRadius2 = 0;
  final myControllerPass = TextEditingController();
  DateTime _now = DateTime.now();
  String image_path = '';
  var images_paths;
  var imgaelink;
  // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now1);

  // FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<String> downloadedUrl(String imageName) async* {
    String downloadedUrl =
        await storage.ref('test/$imageName').getDownloadURL();
    yield downloadedUrl;
  }

  addData() async {
    await FirebaseFirestore.instance
        .collection('task')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('todo')
        .add({
      'task': myControllerPass.text,
      'time': '${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}'
    });
    myControllerPass.clear();
    print("done");
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF1F1A30),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0,
                      top: MediaQuery.of(context).size.height * 0.005),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Chat Page",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('user_details')
                        .where('email',
                            isNotEqualTo:
                                FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          // images_paths = '${downloadedUrl(data['image'])}';
                          // Future<String> downloadURLExample(img) async {
                          //   String downloadURL = await firebase_storage
                          //       .FirebaseStorage.instance
                          //       .ref('test/${img}')
                          //       .getDownloadURL()
                          //       .toString();
                          //   print(downloadURL);
                          //   // print("000000000");
                          //   // if(0){
                          //   return downloadURL;
                          //   // }
                          //   // Within your widgets:
                          //   // Image.network(downloadURL);
                          //   // return downloadURL;
                          // }

                          // downloadURLExample(data['image']);

                          // firebase_storage.Reference ref = firebase_storage
                          //     .FirebaseStorage.instance
                          //     .ref('test/images/${data['image']}');

                          //     print(ref);
                          //     print("done");

                          //       image(ref) async {
                          //         String location = await ref.getDownloadURL();
                          //         return location;
                          //       }
                          //       print(image(ref));

                          return InkWell(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.02),
                              decoration: BoxDecoration(
                                color: Color(0xFF39304d),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF39304d),
                                    blurRadius: 10,
                                    offset: Offset(0, 0), // Shadow position
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: StreamBuilder(
                                      stream: downloadedUrl('${data['image']}'),
                                      builder: (context,
                                          AsyncSnapshot<String> snap) {
                                        if (snap.hasError) {
                                          return Text("Error");
                                        }
                                        if (snap.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        imgaelink = snap.data!;
                                        return CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(snap.data!),
                                        );
                                      }),
                                ),
                                title: Text(
                                  data['name'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  data['name'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "12:00 am",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.008),
                                      child: const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Color(0xFF1F1A30),
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Messagepage(
                                          chatman: data['email'],
                                          imgaelink: imgaelink,
                                          chatmanname: data['name'])));

                              // print(ref.getDownloadURL().toString());
                              // print("done");
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                // ),
              ],
            ),
          ),
        ));
  }
}
