import 'package:flutter/material.dart';

class Blank_Pixel extends StatefulWidget {

  @override
  State<Blank_Pixel> createState() => _Blank_PixelState();
}

class _Blank_PixelState extends State<Blank_Pixel> {

  Color? pixel = Colors.grey[900] ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details){
        setState(() {
          pixel = Colors.green;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: pixel,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
    );
  }
}
