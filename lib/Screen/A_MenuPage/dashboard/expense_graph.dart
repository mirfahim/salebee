import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:salebee/utils.dart';

class ExpenseGraphDesign extends StatefulWidget {
  int? jan;
  int? feb;
  int? march;
  int? aprl;
  int? may;
  int? june;
  int? july;
  int? aug;
  int? sep;
  int? oct;
  int? nov;
  int? dec;

   ExpenseGraphDesign({this.jan, this.feb, this.march, this.aprl, this.may, this.june, this.july, this.aug, this.sep, this.oct, this.nov, this.dec});

  @override
  State<ExpenseGraphDesign> createState() => _ExpenseGraphDesignState();
}

class _ExpenseGraphDesignState extends State<ExpenseGraphDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 4,
          minY: 0,
          maxY: 10,
          backgroundColor: primaryColorLight,
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 9),
                const FlSpot(1, 6),
                const FlSpot(2, 8),
                const FlSpot(3, 6.2),
                const FlSpot(4, 6.2),


              ],
              isCurved: true,
              gradient: const LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.pink,
                ],
              ),
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.2),
                    Colors.pink.withOpacity(0.2),
                  ],
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
          gridData: FlGridData(
              show: true,
              drawHorizontalLine: false,
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.transparent,
                  strokeWidth: 0.8,
                );
              }),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 10,
                  getTitlesWidget: (value, meta) {
                    String text = '';
                    switch (value.toInt()) {
                      case 1:
                        text = "1";
                        break;
                      case 2:
                        text = "2";
                        break;
                      case 3:
                        text = "3";
                        break;
                      case 4:
                        text = "4";
                        break;


                      default:
                        return Container();
                    }
                    return Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
