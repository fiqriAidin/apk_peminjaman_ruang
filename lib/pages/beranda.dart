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
  var totalPesanan;
  final PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Years> data1 = [
    Years(year: DateTime.now().year.toString(), count: 0),
  ];

  List<Months> data2 = [
    Months(months: DateTime.now().month.toString(), count: 0),
  ];

  Map<String, double> dataMap1 = {
    DateTime.now().year.toString(): 0,
  };

  Map<String, double> dataMap2 = {
    DateTime.now().month.toString(): 0,
  };

  Map<String, double> dataMapTotal = {
    "Total": 0,
  };

  Map<String, double> dataMapMenunggu = {
    "Menunggu": 0,
  };

  Map<String, double> dataMapSetuju = {
    "Setuju": 0,
  };

  Map<String, double> dataMapTolak = {
    "Tolak": 0,
  };

  int convertTahun(time) {
    var value = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result = value.year;

    return result;
  }

  String convertBulan(time) {
    var value = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result = "${value.month}-${value.year}";

    return result;
  }

  String convertToString(value) {
    var result = "";

    switch (value) {
      case 1:
        result = "Januari";
        break;
      case 2:
        result = "Februari";
        break;
      case 3:
        result = "Maret";
        break;
      case 4:
        result = "April";
        break;
      case 5:
        result = "Mei";
        break;
      case 6:
        result = "Juni";
        break;
      case 7:
        result = "Juli";
        break;
      case 8:
        result = "Agustus";
        break;
      case 9:
        result = "September";
        break;
      case 10:
        result = "Oktober";
        break;
      case 11:
        result = "November";
        break;
      case 12:
        result = "Desember";
        break;
      default:
    }

    return result;
  }

  void countDataPesanan(value) async {
    // print(DateTime.january - 2);
    var tempYear = DateTime.now().year;
    var tempBulan = DateTime.now().month;
    var menunggu;
    var tolak;
    var setuju;
    var year1;
    var year2;
    var year3;
    var year4;
    var year5;
    var month1;
    var month2;
    var month3;
    var month4;
    var month5;

    for (var i = 1; i <= 5; i++) {
      var countTahun = 0;
      var countBulan = 0;
      var countTotal = 0;
      var countMenunggu = 0;
      var countSetuju = 0;
      var countTolak = 0;
      await value.map((e) {
        countTotal = countTotal + 1;
        if (convertTahun(e['waktuMulai']) == tempYear) {
          countTahun = countTahun + 1;
        }
        if (convertBulan(e['waktuMulai']) ==
            "${tempBulan}-${DateTime.now().year}") {
          countBulan = countBulan + 1;
        }
        if (e['idStatus'].toString() == "5") {
          countMenunggu = countMenunggu + 1;
        }
        if (e['idStatus'].toString() == "4") {
          countTolak = countTolak + 1;
        }
        if (e['idStatus'].toString() == "3") {
          countSetuju = countSetuju + 1;
        }
      }).toList();
      totalPesanan = countTotal;
      menunggu = countMenunggu;
      tolak = countTolak;
      setuju = countSetuju;
      if (i == 1) {
        year1 = countTahun;
        month1 = countBulan;
      } else if (i == 2) {
        year2 = countTahun;
        month2 = countBulan;
      } else if (i == 3) {
        year3 = countTahun;
        month3 = countBulan;
      } else if (i == 4) {
        year4 = countTahun;
        month4 = countBulan;
      } else if (i == 5) {
        year5 = countTahun;
        month5 = countBulan;
      }
      // print("${tempBulan} = ${countBulan}");

      tempYear = tempYear - 1;
      tempBulan = tempBulan - 1;
    }
    if (!mounted) return;

    setState(() {
      dataMapTotal = {
        "Total": totalPesanan.toDouble(),
      };
      dataMapMenunggu = {
        "Menunggu": menunggu.toDouble(),
      };
      dataMapTolak = {
        "Tolak": tolak.toDouble(),
      };
      dataMapSetuju = {
        "Setuju": setuju.toDouble(),
      };
      dataMap1 = {
        DateTime.now().year.toString(): year1.toDouble(),
        (DateTime.now().year - 1).toString(): year2.toDouble(),
        (DateTime.now().year - 2).toString(): year3.toDouble(),
        (DateTime.now().year - 3).toString(): year4.toDouble(),
        (DateTime.now().year - 4).toString(): year5.toDouble(),
      };
      dataMap2 = {
        DateTime.now().month.toString(): month1.toDouble(),
        (DateTime.now().month - 1).toString(): month2.toDouble(),
        (DateTime.now().month - 2).toString(): month3.toDouble(),
        (DateTime.now().month - 3).toString(): month4.toDouble(),
        (DateTime.now().month - 4).toString(): month5.toDouble(),
      };
      data1 = [
        Years(year: DateTime.now().year.toString(), count: year1),
        Years(year: (DateTime.now().year - 1).toString(), count: year2),
        Years(year: (DateTime.now().year - 2).toString(), count: year3),
        Years(year: (DateTime.now().year - 3).toString(), count: year4),
        Years(year: (DateTime.now().year - 4).toString(), count: year5),
      ];
      data2 = [
        Months(months: convertToString(DateTime.now().month), count: month1),
        Months(
            months: convertToString(DateTime.now().month - 1), count: month2),
        Months(
            months: convertToString(DateTime.now().month - 2), count: month3),
        Months(
            months: convertToString(DateTime.now().month - 3), count: month4),
        Months(
            months: convertToString(DateTime.now().month - 4), count: month5),
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
            Container(
              height: 180,
              child: PageView(
                controller: controller,
                children: [
                  ViewStatistik(
                    text: "Total Pesanan Ruang",
                    data: dataMapTotal,
                    color: Colors.blue,
                    totalValue:
                        totalPesanan == null ? 1 : totalPesanan.toDouble(),
                  ),
                  ViewStatistik(
                    text: "Pesanan Ruang Menunggu",
                    data: dataMapMenunggu,
                    color: Colors.yellow,
                    totalValue:
                        totalPesanan == null ? 1 : totalPesanan.toDouble(),
                  ),
                  ViewStatistik(
                    text: "Pesanan Ruang Ditolak",
                    data: dataMapTolak,
                    color: Colors.red,
                    totalValue:
                        totalPesanan == null ? 1 : totalPesanan.toDouble(),
                  ),
                  ViewStatistik(
                    text: "Pesanan Ruang Disetujui",
                    data: dataMapSetuju,
                    color: Colors.green,
                    totalValue:
                        totalPesanan == null ? 1 : totalPesanan.toDouble(),
                  ),
                ],
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

class ViewStatistik extends StatelessWidget {
  ViewStatistik(
      {Key? key, this.data, this.totalValue, required this.text, this.color})
      : super(key: key);
  var data;
  var totalValue;
  String text;
  var color;

  String countData() {
    var value;
    if (data['Total'] != null) {
      value = data['Total'].toString();
    }
    if (data['Menunggu'] != null) {
      value = data['Menunggu'].toString();
    }
    if (data['Tolak'] != null) {
      value = data['Tolak'].toString();
    }
    if (data['Setuju'] != null) {
      value = data['Setuju'].toString();
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    // print(data["Tolak"]);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: Text(text, style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(countData(), style: TextStyle(fontSize: 35)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text("Data", style: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PieChart(
                chartType: ChartType.ring,
                dataMap: data,
                animationDuration: Duration(milliseconds: 1000),
                baseChartColor: Colors.grey.withOpacity(0.5),
                colorList: [color],
                chartRadius: MediaQuery.of(context).size.width / 5,
                legendOptions: LegendOptions(
                  showLegends: false,
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
                totalValue: totalValue.toDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
