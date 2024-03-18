import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RadarChartGraph extends StatelessWidget {
  const RadarChartGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              dataEntries: [
                RadarEntry(value: 5),
                RadarEntry(value: 2),
                RadarEntry(value: 6),
                RadarEntry(value: 1),
                RadarEntry(value: 7),
              ]
            )
          ],
          radarShape: RadarShape.polygon,
          tickCount: 2,

          getTitle: (index,angle){
            switch (index) {
              case 0:
                return RadarChartTitle(text: 'Reading Fluency', angle: 0,);
              case 1:
                return RadarChartTitle(text: 'Spelling', angle: 0);
              case 2:
                return RadarChartTitle(text: 'Reading Comprehension', angle: 0,);
              case 3:
                return RadarChartTitle(text: 'Word Decoding', angle: 0);
              case 4:
                return RadarChartTitle(text: 'Letter Sound\nKnowledge', angle: 0);
              default:
                return const RadarChartTitle(text: '');
            }
          }
        )
      ),
    );
  }
}
