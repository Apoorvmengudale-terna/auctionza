import 'dart:collection';
import 'dart:io';

import 'package:Auctionza/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';


class UploadData extends StatefulWidget {
  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  File imageFile;
  var formKey = GlobalKey<FormState>();
  String title,price,description,duration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff5C6BC0)),
        backgroundColor: Colors.white,
        title: Text("Upload Data", style: TextStyle(color: Color(0xff5C6BC0)),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(key: formKey ,
          child:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15)),
            Container(
                child: imageFile == null ?
                TextButton(
                    onPressed: () {
                  _showDialog();
                },
                    child: Icon(Icons.add_a_photo, size: 30,color: Color(0xff5C6BC0),)) :
                Image.file(imageFile, width: 300, height: 300,),
              ),
              Text("Click here to upload image of the item",style: TextStyle(fontFamily: 'Montserrat'),),



              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Theme(
                    data: ThemeData(
                      hintColor: Color(0xff5C6BC0),
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter the Title.";
                        }
                        else
                          {
                            title=value;
                          }
                      },

                      style: TextStyle(color: Color(0xff5C6BC0)),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Please enter the title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Theme(
                    data: ThemeData(
                      hintColor: Color(0xff5C6BC0),
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter the description.";
                        }
                        else
                        {
                          description=value;
                        }
                      },

                      style: TextStyle(color: Color(0xff5C6BC0)),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Please enter the description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              SizedBox(width: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Theme(
                    data: ThemeData(
                      hintColor: Color(0xff5C6BC0),
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter the price.";
                        }
                        else
                        {
                          price=value;
                        }
                      },

                      style: TextStyle(color: Color(0xff5C6BC0)),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Please enter the initial bid",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              SizedBox(width: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Theme(
                    data: ThemeData(
                      hintColor: Color(0xff5C6BC0),
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter the duration.";
                        }
                        else
                        {
                          duration=value;
                        }
                      },

                      style: TextStyle(color: Color(0xff5C6BC0)),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Please enter the duration",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff5C6BC0),width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){
                    if(imageFile == null)
                      {
                        Fluttertoast.showToast(msg: "Please select an Image",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 2);
                      }
                    else
                      {
                        upload();
                      }
                  },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: TextButton(style: TextButton.styleFrom(backgroundColor: Color(0xff5C6BC0)),child: Text("Upload",style: TextStyle(fontFamily: 'OpenSansBold',color: Colors.white),),),//Text("Upload",style: TextStyle(fontSize: 18,color: Colors.blue),),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Future <void> _showDialog() {
    return showDialog(context: context, builder: (BuildContext) {
      return AlertDialog(
        title: Text("You want take a photo from ?"),
        content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            GestureDetector(
              child: Text("Gallery"),
              onTap: () {
                openGallery();
              },
            ),
            SizedBox(height: 5,),
            Padding(padding: EdgeInsets.only(top: 12)),
            GestureDetector(
              child: Text("Camera"),
              onTap: () {
                openCamera();
              },
            ),
          ],
        ),
        ),
      );
    });
  }

  Future <void> openGallery() async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture.path) ;
    });
  }

  Future <void> openCamera() async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
  }

  Future <void> SlideCountDownClock() async {
    duration: duration;
    slideDirection: SlideDirection.Up;
    separator: ':';
    textStyle: TextStyle(fontSize: 36,fontWeight: FontWeight.bold);

  }

  Future <void> upload() async {

    if(formKey.currentState.validate()) {
      Reference reference = FirebaseStorage.instance.ref().child("images")
          .child(new DateTime.now().microsecondsSinceEpoch.toString() + "." +
          imageFile.path);

      UploadTask uploadTask = reference.putFile(imageFile);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      String url = imageUrl.toString();
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .reference().child("Product");
      String uploadId = databaseReference
          .push()
          .key;
      HashMap map = new HashMap();
      map ["title"] = title;
      map ["price"] = price;
      map ["imgUrl"] = url;
      map ["description"] = description;
      map ["duration"] = duration;


      databaseReference.child(uploadId).set(map);

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}