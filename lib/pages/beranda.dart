import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';

//membuat model dalam satu tahun
class Years {
  final String year;
  final int count;

  Years({
    required this.year,
    required this.count,
  });
}

//membuat model dalam satu bulan
class Months {
  final String months;
  final int count;

  Months({
    required this.months,
    required this.count,
  });
}

class Beranda extends StatelessWidget {
  Beranda({Key? key}) : super(key: key);

  final List<Years> data1 = [
    Years(year: "2011", count: 50),
    Years(year: "2012", count: 42),
    Years(year: "2013", count: 45),
    Years(year: "2014", count: 56),
    Years(year: "2015", count: 38),
  ];

  final List<Months> data2 = [
    Months(months: "Januari", count: 10),
    Months(months: "Februari", count: 12),
    Months(months: "Maret", count: 17),
    Months(months: "April", count: 16),
    Months(months: "Mei", count: 20),
  ];

  Map<String, double> dataMap1 = {
    "2012": 50,
    "2013": 42,
    "2014": 45,
    "2015": 38,
  };

  Map<String, double> dataMap2 = {
    "Januari": 10,
    "Februari": 12,
    "Maret": 17,
    "April": 16,
  };

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Years, String>> series1 = [
      charts.Series(
        id: "Years",
        data: data1,
        domainFn: (Years series, _) => series.year,
        measureFn: (Years series, _) => series.count,
      )
    ];

    List<charts.Series<Months, String>> series2 = [
      charts.Series(
        id: "Years",
        data: data2,
        domainFn: (Months series, _) => series.months,
        measureFn: (Months series, _) => series.count,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Peminjaman Ruang PENS"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const Login();
                }));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            padding: EdgeInsets.only(left: 15, bottom: 15),
            child: Text(
              "Statistik Peminjaman",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PieChart(
                dataMap: dataMap1,
                animationDuration: Duration(milliseconds: 1000),
                chartLegendSpacing: 10,
                chartRadius: MediaQuery.of(context).size.width / 3.8,
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
              ),
              PieChart(
                dataMap: dataMap2,
                animationDuration: Duration(milliseconds: 1000),
                chartLegendSpacing: 10,
                chartRadius: MediaQuery.of(context).size.width / 3.8,
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
              ),
            ],
          ),
          Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Statisktik Peminjaman Ruang Tiap Tahun",
                    ),
                    Expanded(
                      child: charts.BarChart(
                        series1,
                        animate: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Statisktik Peminjaman Ruang Tiap Bulan",
                    ),
                    Expanded(
                      child: charts.BarChart(
                        series2,
                        animate: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
