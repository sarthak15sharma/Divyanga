import 'package:divyanga/components/radarChart.dart';
import 'package:divyanga/constants/colors.dart';
import 'package:divyanga/constants/styles.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  List<String> incorrectWords = ['teh','brid','adle','bab'];
  List<String> actualWords = ['the','bridge','able','dad'];


  List<String> incorrectLetters = ['p','b','e','N'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            Expanded(
              flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: containerBox,
                      child: Column(
                        children: [
                          Text('Progress Report', style: infoTextStyle,),
                          Expanded(child: RadarChartGraph()),
                        ],
                      )
                  ),
                )
            ),
            Expanded(
              flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: containerBox,
                      child: Column(
                        children: [
                          Text('Word analysis', style: infoTextStyle,),
                          Container(height: 30,child: Text('Actual Word   ->  Written Word', style: inputTextStyle,)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              child: ListView.builder(
                                  itemCount: incorrectWords.length,
                                  itemBuilder: (context, index){
                                    return Center(child: Container(height: 30,child: Text('${actualWords[index]} -> ${incorrectWords[index]}', style: inputTextStyle,)));
                                  }
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                )
            ),

            Expanded(
              flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: containerBox,
                      child: Column(
                        children: [
                          Text('Reversal Letters', style: infoTextStyle,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Center(child: Text(incorrectLetters.toString(),style: inputTextStyle,))
                            ),
                          )
                        ],
                      )
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
