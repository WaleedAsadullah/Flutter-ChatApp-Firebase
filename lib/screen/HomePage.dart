import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color field2Color = Color(0xFF1F1A30);
  double blurRadius2 = 0;
  final myControllerPass = TextEditingController();
  DateTime _now = DateTime.now();
  // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now1);
  
  // FirebaseAuth auth = FirebaseAuth.instance;
  @override
  addData() async {
    await FirebaseFirestore.instance
        .collection('task').doc(FirebaseAuth.instance.currentUser!.uid).collection('todo')
        .add({'task': myControllerPass.text,'time': '${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}'}
        );
        myControllerPass.clear();
    print("done");
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  top: MediaQuery.of(context).size.height * 0.03),
              child: ElevatedButton(
                  onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Color(0xFF1F1A30),
                          title: const Text(
                            'Enter Task',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.01),
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                setState(() => blurRadius2 = hasFocus ? 8 : 0);

                                setState(() => field2Color = hasFocus
                                    ? Color(0xFF39304d)
                                    : Color(0xFF1F1A30));
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
                                  // obscureText: true,
                                  controller: myControllerPass,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    fillColor: field2Color,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide:
                                          BorderSide.none,
                                    ),
                                    filled: true,
                                    // prefixIcon: Icon(
                                    //   Icons.lock_outline,
                                    //   color: Colors.white,
                                    // ),
                                    labelText: 'Task',
                                    labelStyle: TextStyle(
                                        height: 5, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                addData();
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                  child: Text("Add Task",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF39304D),
                        fontWeight: FontWeight.bold,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0CF6E3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                  )),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Color(0xFF39304d),
            //     borderRadius: BorderRadius.circular(20),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color(0xFF39304d),
            //         blurRadius: 10,
            //         offset: Offset(0, 0), // Shadow position
            //       ),
            //     ],
            //   ),
            //   child:
            Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0,
                      top: MediaQuery.of(context).size.height * 0.005),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Task Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                  ),
                ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('task').doc(FirebaseAuth.instance.currentUser!.uid).collection('todo').orderBy('time').snapshots(),
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
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02),
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
                          title: Text(data['task'],style: TextStyle(color: Colors.white),),
                          subtitle: Text(data['time'],style: TextStyle(color: Colors.white),),
                          trailing: TextButton(
                              onPressed: () {
                                document.reference.delete();
                              },
                              child: Icon(Icons.delete_forever_rounded ,color:Color(0xFF0CF6E3) ,)),
                        ),
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
