import 'package:flutter/material.dart';
import 'package:personal_expenses_new/screens/consts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  String x;
  int y;
  SalesData(this.x, this.y);
}

// class chart2
class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _MyWidgetState2();
}

class _MyWidgetState2 extends State<ChartScreen> {
  int salary = 0;
  int expenses = 0;
  int savings = 0;
  List historyList = [];
  late List<GDBData> _charData;

  get index => null;

  // get index => null;

  @override
  void initState() {
    salary = box.read('salary');
    expenses = box.read('expenses');
    savings = box.read('savings');
    historyList = box.read('historyList');

    _charData = getChatData();
    super.initState();
  }

  dynamic getColumnData() {
    List<SalesData> columnData = <SalesData>[
      for (int i = 0; i < historyList.length; i++)
        SalesData("${historyList[i]['subtitle']}", (historyList[i]['value']))

      // SalesData((historyList[index]['title']), (historyList[index]['value'])),
      // SalesData("ايجار", 500),
    ];
    return columnData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 51),
                    height: 310,
                    width: 325,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: SfCircularChart(
                        title: ChartTitle(
                            text: ":الاجمالي",
                            alignment: ChartAlignment.far,
                            textStyle: const TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            )),
                        palette: <Color>[
                          const Color.fromRGBO(192, 187, 255, 1),
                          Theme.of(context).primaryColor,
                          const Color.fromRGBO(0, 196, 140, 1)
                        ],
                        legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                          alignment: ChartAlignment.center,
                          position: LegendPosition.bottom,
                        ),
                        series: <CircularSeries>[
                          PieSeries<GDBData, String>(
                              dataSource: _charData,
                              xValueMapper: (GDBData data, _) => data.continent,
                              yValueMapper: (GDBData data, _) => data.gdp,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ]),
                  ),
                ]),
                Container(
                    height: 310,
                    width: 325,
                    // margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          // offset: Offset(1, 0),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: SfCartesianChart(
                      palette: <Color>[
                        Theme.of(context).primaryColor,
                      ],
                      title: ChartTitle(
                          text: ":الاكثر صرف",
                          alignment: ChartAlignment.far,
                          textStyle: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      primaryXAxis: CategoryAxis(
                          labelStyle: const TextStyle(
                              fontFamily: 'Archivo',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      primaryYAxis: NumericAxis(
                          crossesAt: 4,
                          opposedPosition: true,
                          labelStyle: const TextStyle(
                              fontFamily: 'Archivo',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      series: <ChartSeries>[
                        ColumnSeries<SalesData, String>(
                            dataSource: getColumnData(),
                            xValueMapper: (SalesData sales, _) => sales.x,
                            yValueMapper: (SalesData sales, _) => sales.y,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ],
                    )),
              ]),
        ),
      ),
    );
  }

  List<GDBData> getChatData() {
    List<GDBData> charData = [
      GDBData("المصاريف", expenses),
      GDBData("ادخار", savings),
      GDBData("المتبقي", salary)
    ];
    return charData;
  }
}

class GDBData {
  String continent;
  int gdp;
  GDBData(this.continent, this.gdp);
}
