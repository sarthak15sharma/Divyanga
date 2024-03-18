import 'package:divyanga/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:divyanga/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: gradient,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/logo.png', scale: 1,),
              Container(
                decoration: curvedTops,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Personal Details",style: infoTextStyle,),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          style: inputTextStyle,
                          cursorColor: Colors.orangeAccent,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                              labelText: 'Name',
                              labelStyle: inputTextStyle,

                              floatingLabelStyle: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              )),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          style: inputTextStyle,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.orangeAccent,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                              labelText: 'Age',
                              labelStyle: inputTextStyle,

                              floatingLabelStyle: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              )),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          style: inputTextStyle,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.orangeAccent,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                              labelText: 'Grade',
                              labelStyle: inputTextStyle,

                              floatingLabelStyle: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              )),
                        ),
                      ),

                      TextButton(
                          style: flatButtonStyle,
                          onPressed: (){

                          },
                          child: Text("Submit", style: inputTextStyle,)
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
