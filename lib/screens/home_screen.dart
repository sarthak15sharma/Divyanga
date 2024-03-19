import 'package:carousel_slider/carousel_slider.dart';
import 'package:circle_list/circle_list.dart';
import 'package:divyanga/constants/colors.dart';
import 'package:divyanga/constants/styles.dart';
import 'package:divyanga/screens/paint_screen.dart';
import 'package:divyanga/screens/photoUpload_screen.dart';
import 'package:divyanga/screens/report_screen.dart';
import 'package:divyanga/screens/speechText_screen.dart';
import 'package:divyanga/screens/traceLetter_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: secondaryColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Rewards: 120', style: inputTextStyle,),
                        Image.asset('assets/reward_icon.png',scale: 12,)
                      ],
                    ),
                    // Avatar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            border: Border.all(color: Colors.pink, width: 5)
                          ),
                          child: CircleAvatar(
                            child: Image.asset('assets/avatar.png', scale: 2,),
                            radius: 70,
                          ),
                        ),
                      ],
                    ),

                    // Greeting
                    Text("Welcome!", style: infoTextStyle,),

                    // Name
                    Text("Shubhi Sharma", style: infoTextStyle,),
                  ],
                ),
              ),
            ),

          // Grid
            Container(
              decoration: curvedTops,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(

                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TraceLetterScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Container(
                                decoration: containerBox,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                    Container(height: 100, width: 130,child: Image.asset('assets/draw_icon.png',scale: 3.7,)),
                                      Text("Draw", style: labelTextStyle,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(

                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SpeechToTextScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Container(
                                decoration: containerBox,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                    Container(height: 100, width: 130,child: Image.asset('assets/speech_icon.png',scale: 3.7,)),
                                      Text("Speech", style: labelTextStyle,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Container(
                                decoration: containerBox,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(height: 100, width: 130,child: Image.asset('assets/report_icon.png',scale: 3.7,)),
                                      Text("Reports", style: labelTextStyle,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                        GestureDetector(

                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoUploadScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Container(
                                decoration: containerBox,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(height: 100, width: 130,child: Image.asset('assets/handwriting_icon.png',scale: 3.7,)),
                                      Text("Handwriting", style: labelTextStyle,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
