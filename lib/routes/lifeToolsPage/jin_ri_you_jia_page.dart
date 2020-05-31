/*
* jin_ri_you_jia created by zj 
* on 2020/5/25 10:59 AM
* copyright on zhangjiang
*/
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestURLPath.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/today_oil_price_model_entity.dart';

class JinRiYouJiaPage extends StatefulWidget {
  JinRiYouJiaPage({Key key}) : super(key: key);

  @override
  _JinRiYouJiaState createState() => _JinRiYouJiaState();
}

class _JinRiYouJiaState extends State<JinRiYouJiaPage> {

  Future _getOilPrice(){
    return HTTPManager().getAsync<List<TodayOilPriceModelEntity>>(url: getTodayOilData, tag: "getTodayOilPrice");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("today_oil")),
        ),
        body:Center(
          child: FutureBuilder(
            future: _getOilPrice(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return Center(
                    child: Text('获取油价信息失败',textScaleFactor: 2,),
                  );
                }else{

                  List<TodayOilPriceModelEntity> showData = snapshot.data;
                  print("油价信息成功==${showData.length}");
                  return Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: _buildChatWidget(showData)
                  );
                }
              }else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
    );
  }

  Widget _buildChatWidget(List<TodayOilPriceModelEntity> showData){
    //处理数据
    for (TodayOilPriceModelEntity model in showData){

    }

    return LineChart(
      sampleData2(showData),
    );
  }

  LineChartData sampleData2(List<TodayOilPriceModelEntity> showData) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 7,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 6,
          ),
          margin: 2,
          getTitles: (value) {
            if (value > showData.length - 1){
               return "";
            }
            return showData[value.toInt()].city;
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1元';
              case 2:
                return '2元';
              case 3:
                return '3元';
              case 4:
                return '4元';
              case 5:
                return '5元';
              case 6:
                return '6元';
              case 7:
                return '7元';
              case 8:
                return '8元';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: Color(0xff4e4965), width: 1,
            )
          )
      ),
      minX: 0,
      maxX: showData.length.toDouble(),
      maxY: 7,
      minY: 0,
      lineBarsData: linesBarData2(showData),
    );
  }

  List<LineChartBarData> linesBarData2(List<TodayOilPriceModelEntity> showData) {
    return [LineChartBarData(
      spots: showData.asMap().keys.map((e) =>FlSpot(e.toDouble(),double.parse(showData[e].oil_0h))).toList(),
      isCurved: true,
      curveSmoothness: 0,
      colors: const [Colors.red],
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      barWidth: 4,
    ),
      LineChartBarData(
        spots: showData.asMap().keys.map((e) =>FlSpot(e.toDouble(),double.parse(showData[e].oil_92h))).toList(),
        isCurved: true,
        curveSmoothness: 0,
        colors: const [Colors.green],
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        barWidth: 4,
      ),
      LineChartBarData(
        spots: showData.asMap().keys.map((e) =>FlSpot(e.toDouble(),double.parse(showData[e].oil_95h))).toList(),
        isCurved: true,
        curveSmoothness: 0,
        colors: const [Colors.blue],
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        barWidth: 4,
      ),
      LineChartBarData(
        spots: showData.asMap().keys.map((e) =>FlSpot(e.toDouble(),double.parse(showData[e].oil_98h))).toList(),
        isCurved: true,
        curveSmoothness: 0,
        colors: const [Colors.yellow],
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        barWidth: 4,
      )];

     return [LineChartBarData(
        spots: [
          FlSpot(1, 6),
          FlSpot(2, 4),
          FlSpot(3, 1.8),
          FlSpot(4, 5),
          FlSpot(5, 2),
          FlSpot(6, 2.2),
          FlSpot(7, 1.8),
          FlSpot(8, 6),
          FlSpot(9, 4),
          FlSpot(10, 1.8),
          FlSpot(11, 5),
          FlSpot(12, 2),
          FlSpot(13, 2.2),
          FlSpot(14, 1.8),
          FlSpot(15, 6),
          FlSpot(16, 4),
          FlSpot(17, 1.8),
          FlSpot(18, 5),
          FlSpot(19, 2),
          FlSpot(20, 2.2),
          FlSpot(21, 1.8),
        ],
        isCurved: true,
//        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
//        curveSmoothness: 0,
        belowBarData:  BarAreaData(show: false),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
//      LineChartBarData(
//        spots: [
//          FlSpot(1, 3.8),
//          FlSpot(3, 1.9),
//          FlSpot(6, 5),
//          FlSpot(10, 3.3),
//          FlSpot(13, 4.5),
//        ],
//        isCurved: true,
//        curveSmoothness: 0,
//        colors: const [
//          Color(0x4427b6fc),
//        ],
//        barWidth: 2,
//        isStrokeCapRound: true,
//        dotData: FlDotData(
//          show: true,
//        ),
//        belowBarData: BarAreaData(
//          show: false,
//        ),
//      ),
    ];
  }

}