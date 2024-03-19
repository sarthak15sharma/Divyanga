import 'package:divyanga/constants/colors.dart';
import 'package:divyanga/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextScreen extends StatefulWidget {
  @override
  _SpeechToTextScreenState createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  final stt.SpeechToText _speech =stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  List<String> words = ["HAM","KIND","BALL","BAKE","DAD"];
  int count = 0;
  int letter_index = -1;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech()async{
    await _speech.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: 220,
              decoration: containerBox,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_text, style: inputTextStyle,),
                  Container(
                    height: 95,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: words[count].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(words[count][index],style: GoogleFonts.comicNeue(
                                  textStyle:  TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w600,
                                      color:(letter_index>=index)? Colors.green:Colors.white
                                  )
                              ),),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isListening ? stopListening : startListening,
                    child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startListening() {
    _speech.listen(
      onResult: (result) {
        if(result.recognizedWords.toUpperCase().contains(words[count][letter_index+1])){
          setState(() {
            letter_index++;
            print(letter_index);
          });
          if(letter_index == words[count].length-1){
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Congratulations"),
                content: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      count++;
                      letter_index=-1;
                      _text = "";
                      stopListening();
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Next"),
                ),
              ),
            );
          }
        }
        setState(() {
          _text = result.recognizedWords;
        });
      },
    );
    setState(() {
      _isListening = true;
    });
  }

  void stopListening() {
    _speech.stop();
    setState(() {
      _text = "";
      _isListening = false;
    });
  }
}
