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
        title: const Text(
          "Peminjaman Ruang PENS",
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
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
              ))
        ],
      ),
      body: ListView(
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Notifikasi Terbaru",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ListNotif(),
                  const ListNotif(),
                  const ListNotif(),
                  const ListNotif(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 15),
            child: const Text(
              "Statistik Peminjaman",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PieChart(
                    dataMap: dataMap1,
                    animationDuration: Duration(milliseconds: 1000),
                    chartLegendSpacing: 5,
                    chartRadius: MediaQuery.of(context).size.width / 4.5,
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                  ),
                  PieChart(
                    dataMap: dataMap2,
                    animationDuration: Duration(milliseconds: 1000),
                    chartLegendSpacing: 5,
                    chartRadius: MediaQuery.of(context).size.width / 4.5,
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 300,
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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

class ListNotif extends StatelessWidget {
  const ListNotif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            "22-02-2022 20.00 s/d 22.00",
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            "Peminjaman ruang Fiqri Aidin di setujui",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
