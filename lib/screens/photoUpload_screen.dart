import 'dart:convert';
import 'dart:io';
import 'package:divyanga/constants/colors.dart';
import 'package:divyanga/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {

  late File image;
  String base64 = "";
  bool selected = false;

  void select_image() async{
    ImagePicker picker = new ImagePicker();
    var temp = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(temp!=null) {
        image = File(temp.path);
        List<int> imageBytes = image.readAsBytesSync();
        base64 = base64Encode(imageBytes);
        selected = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            (selected)?Container(decoration: containerBox,height: 450, width:double.infinity ,child: Center(child:Image.memory(base64Decode(base64)),)):Container(decoration: containerBox,height: 500, width:double.infinity ,child: Center(child:Text('Image',style: inputTextStyle,),)),
            TextButton(onPressed: (){select_image();}, child: Text("Select")),
            (selected)?Container(decoration: containerBox,height: 250, width:double.infinity ,child: Center(child:Text('I will do my redin bet.MoM and bab will hepyme.redin will hepy me Wah i got',style: inputTextStyle,),)):SizedBox(),
          ],
        ),
      ),
    );
  }
}
