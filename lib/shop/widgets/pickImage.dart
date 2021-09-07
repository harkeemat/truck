import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import 'main.dart';
//import 'dart:ffi';
//void main() => runApp(Fourth());

class Fourth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pick Your Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final picker = ImagePicker();
  var myFile = File("_image");

  var pickedFile;
//File myFile;
//late final File _image;
  Future getImagefromcamera() async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        myFile = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  Future getImagefromGallery() async {
    // ignore: unused_local_variable

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        myFile = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        //
        // leading: IconButton(icon: Icon(Icons.arrow_back),
        // onPressed: (){
        //   Navigator.pop(
        //           context,
        //           MaterialPageRoute(builder: (context) => MyApp()),
        //   );
        // },
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Image Picker In Flutter:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                // ignore: unnecessary_null_comparison
                child: myFile == null
                    ? Text("No Image Found")
                    : Image.file(myFile),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: getImagefromcamera,
                tooltip: "pick image from camera",
                child: const Icon(Icons.camera),
                backgroundColor: Colors.blueAccent,
                focusColor: Colors.blue,
                foregroundColor: Colors.white,
                hoverColor: Colors.blueGrey,
                splashColor: Colors.tealAccent,
              ),
              FloatingActionButton(
                onPressed: getImagefromGallery,
                tooltip: "pick image from galery",
                child: const Icon(Icons.folder),
                backgroundColor: Colors.blueAccent,
                focusColor: Colors.blue,
                foregroundColor: Colors.white,
                hoverColor: Colors.blueGrey,
                splashColor: Colors.tealAccent,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => MyApp()),
          // );
        },
        child: const Icon(Icons.done),
        backgroundColor: Colors.blueAccent,
        focusColor: Colors.brown,
        foregroundColor: Colors.white,
        hoverColor: Colors.red,
        splashColor: Colors.green,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[100],
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
