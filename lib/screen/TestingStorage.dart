// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutterfirsebasecrud/screen/storage_helper.dart';

class TestingStorage extends StatefulWidget {
  const TestingStorage({Key? key}) : super(key: key);

  @override
  _TestingStorageState createState() => _TestingStorageState();
}

class _TestingStorageState extends State<TestingStorage> {
  @override
  var result;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF1F1A30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'jpeg', 'png', 'jpg'],
                  );

                  setState(() {
                    result = result;
                  });
                  if (result == null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("No file")));
                  }

                  Storage a = Storage();

                  a.uploadFile(result.files.single.path, result.files.single.name);
                  
                },
                child: Text("Select")),
            if (result != null)
              Container(
                child: Image.file(File(result.files.single.path),),
              ),
          ],
        ),
      ),
    );
  }
}
