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

  Map<String, double> dataMapRuang = {
    "Lap Atas": 5,
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

                        return snapshot.hasData
                            ? ListNotif(data: snapshot.data)
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
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
    );
  }
}
