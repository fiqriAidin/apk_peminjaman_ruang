import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/pages/pesan_ruang.dart';
import 'package:peminjaman_ruang/pages/detailPesanan.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class ListPesanan extends StatefulWidget {
  ListPesanan({Key? key, this.role, this.dataRole}) : super(key: key);
  var role;
  var dataRole;

  @override
  _ListPesananState createState() => _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  var itemCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pesanan"),
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
                color: Colors.white,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1500));

          setState(() {
            itemCount = itemCount + 1;
          });
        },
        child: FutureBuilder(
          future: getDataPesanan(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }

            return snapshot.hasData
                ? ListData(
                    list: snapshot.data,
                    role: widget.role,
                    dataRole: widget.dataRole,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_circle),
        backgroundColor: Colors.green,
        label: const Text("Pesan Ruang"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PesanRuang(
              dataRole: widget.dataRole,
              role: widget.role,
            );
          }));
        },
      ),
    );
  }
}

class ListData extends StatefulWidget {
  ListData({Key? key, this.list, this.role, this.dataRole}) : super(key: key);
  var list;
  var role;
  var dataRole;

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  var newData = ([]);
  String? _status;
  List<String> status = [
    "Semua",
    "Disetujui",
    "Menunggu",
    "Ditolak",
    "Internal",
    "External",
  ];

  void filterData() {
    var result = [];
    var tempStatus;
    if (_status == "Semua") {
      setState(() {
        result = widget.list;
      });
    } else if (_status == "Internal") {
      tempStatus = "6";
      setState(() {
        result = widget.list
            .where((element) => element["statusPeminjam"]
                .toString()
                .toLowerCase()
                .contains(tempStatus.toLowerCase()))
            .toList();
      });
    } else if (_status == "External") {
      tempStatus = "7";
      setState(() {
        result = widget.list
            .where((element) => element["statusPeminjam"]
                .toString()
                .toLowerCase()
                .contains(tempStatus.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        result = widget.list
            .where((element) => element["status"]
                .toString()
                .toLowerCase()
                .contains(_status!.toLowerCase()))
            .toList();
      });
    }
    newData = result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newData = widget.list;
  }

  String convertDate(time) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result =
        "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}:${date.second}";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));

        setState(() {
          newData = widget.list;
          _status = null;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  labelText: "Status Pesanan",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              value: _status,
              hint: const Text("Pilih status"),
              items: status.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _status = value.toString();
                });
                filterData();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: newData == null ? 0 : newData.length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Card(
                    color: newData[index]["idStatus"] == "5"
                        ? Colors.yellow
                        : newData[index]["idStatus"] == "3"
                            ? Colors.green
                            : Colors.red,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40))),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        newData[index]["peminjamMhs"].toString() == "[]"
                            ? newData[index]["peminjamPgw"].toString()
                            : newData[index]["peminjamMhs"].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${convertDate(newData[index]["waktuMulai"])} s/d ${convertDate(newData[index]["waktuSelesai"])}",
                              style: const TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Meminjam : ${newData[index]["ruang"]}",
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Judul Acara : ${newData[index]["judul"]}",
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Status Peminjam : ${newData[index]["statusPeminjam"] == "6" ? "Internal" : "External"}",
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Status : ${newData[index]["status"]}",
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailPesanan(
                                data: newData[index],
                                role: widget.role,
                                dataRole: widget.dataRole,
                              );
                            },
                          ),
                        );
                      },
                      textColor: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
