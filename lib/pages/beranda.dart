import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:peminjaman_ruang/utils/api.dart';
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

class Beranda extends StatefulWidget {
  Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  var tempData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   dataMap1 = {"2012": 50};
    // });
    // print(tempData);
  }

  List<Years> data1 = [
    Years(year: DateTime.now().year.toString(), count: 0),
  ];

  List<Months> data2 = [
    Months(months: "Januari", count: 10),
    Months(months: "Februari", count: 12),
    Months(months: "Maret", count: 17),
    Months(months: "April", count: 16),
    Months(months: "Mei", count: 20),
  ];

  Map<String, double> dataMap1 = {
    DateTime.now().year.toString(): 0,
  };

  Map<String, double> dataMap2 = {
    "Januari": 10,
    "Februari": 12,
    "Maret": 17,
    "April": 16,
  };

  Map<String, double> dataMapRuang = {
    "Lap Atas": 5,
  };

  int convertTahun(time) {
    var value = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result = value.year;

    return result;
  }

  int convertBulan(time) {
    var value = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result = value.month;

    return result;
  }

  void countDataPesanan(value) async {
    var tempYear = DateTime.now().year;
    var year1;
    var year2;
    var year3;
    var year4;
    var year5;
    for (var i = 0; i < 5; i++) {
      var count = 0;
      await value.map((e) {
        if (convertTahun(e['waktuMulai']) == tempYear) {
          count = count + 1;
        }
      }).toList();
      if (i == 0) {
        year1 = count;
      } else if (i == 1) {
        year2 = count;
      } else if (i == 2) {
        year3 = count;
      } else if (i == 3) {
        year4 = count;
      } else if (i == 4) {
        year5 = count;
      }
      tempYear = tempYear - 1;
    }
    if (!mounted) return;

    setState(() {
      dataMap1 = {
        DateTime.now().year.toString(): year1.toDouble(),
        (DateTime.now().year - 1).toString(): year2.toDouble(),
        (DateTime.now().year - 2).toString(): year3.toDouble(),
        (DateTime.now().year - 3).toString(): year4.toDouble(),
        (DateTime.now().year - 4).toString(): year5.toDouble(),
      };
      data1 = [
        Years(year: DateTime.now().year.toString(), count: year1),
        Years(year: (DateTime.now().year - 1).toString(), count: year2),
        Years(year: (DateTime.now().year - 2).toString(), count: year3),
        Years(year: (DateTime.now().year - 3).toString(), count: year4),
        Years(year: (DateTime.now().year - 4).toString(), count: year5),
      ];
    });
    // print(DateTime.now().month);
  }

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
        id: "Months",
        data: data2,
        domainFn: (Months series, _) => series.months,
        measureFn: (Months series, _) => series.count,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 57, 104, 1),
        title: Container(
          padding: EdgeInsets.only(left: 50),
          alignment: Alignment.center,
          child: Text(
            "Peminjaman Ruang PENS",
          ),
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
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Card(
              elevation: 5,
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(15),
                height: 300,
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
                    FutureBuilder(
                      future: getDataPesanan(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        if (snapshot.hasData) {
                          countDataPesanan(snapshot.data);
                          return ListNotif(data: snapshot.data);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                            "Ruang yang sering dilakukan peminjaman dalam bulan ini adalah Lap Atas"),
                      ),
                    ),
                    Expanded(
                      child: PieChart(
                        chartType: ChartType.ring,
                        dataMap: dataMapRuang,
                        animationDuration: Duration(milliseconds: 1000),
                        baseChartColor: Colors.grey.withOpacity(0.5),
                        colorList: [Colors.greenAccent],
                        chartRadius: MediaQuery.of(context).size.width / 6,
                        legendOptions: LegendOptions(
                          showLegends: false,
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        totalValue: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PieChart(
                        dataMap: dataMap1,
                        animationDuration: Duration(milliseconds: 1000),
                        chartLegendSpacing: 5,
                        chartRadius: MediaQuery.of(context).size.width / 4.5,
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: PieChart(
                        dataMap: dataMap2,
                        animationDuration: Duration(milliseconds: 1000),
                        chartLegendSpacing: 5,
                        chartRadius: MediaQuery.of(context).size.width / 4.5,
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
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
          ])),
        ],
      ),
    );
  }
}

class ListNotif extends StatefulWidget {
  ListNotif({Key? key, this.data}) : super(key: key);
  var data;

  @override
  State<ListNotif> createState() => _ListNotifState();
}

class _ListNotifState extends State<ListNotif> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String convertDate(time) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result =
        "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}:${date.second}";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: widget.data == null ? 0 : widget.data.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    convertDate(widget.data[index]["waktuPinjam"]),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Peminjaman ruang ${widget.data[index]["peminjamMhs"].toString() == "[]" ? widget.data[index]["peminjamPgw"].toString() : widget.data[index]["peminjamMhs"].toString()} berstatus ${widget.data[index]["status"]}",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
