import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/pages/pesan_ruang.dart';
import 'package:peminjaman_ruang/pages/detailPesananAdmin.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class ListPesananAdmin extends StatefulWidget {
  const ListPesananAdmin({Key? key}) : super(key: key);

  @override
  _ListPesananAdminState createState() => _ListPesananAdminState();
}

class _ListPesananAdminState extends State<ListPesananAdmin> {
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
      body: FutureBuilder(
        future: getDataPesanan(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          return snapshot.hasData
              ? ListPesanan(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_circle),
        backgroundColor: Colors.green,
        label: const Text("Pesan Ruang"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PesanRuang();
          }));
        },
      ),
    );
  }
}

class ListPesanan extends StatefulWidget {
  ListPesanan({
    Key? key,
    this.list,
  }) : super(key: key);
  var list;

  @override
  _ListPesananState createState() => _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  String convertDate(time) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result =
        "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}:${date.second}";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.list == null ? 0 : widget.list.length,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Card(
                  color: widget.list[index]["idStatus"] == "5"
                      ? Colors.yellow
                      : widget.list[index]["idStatus"] == "3"
                          ? Colors.green
                          : Colors.red,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      widget.list[index]["peminjam"],
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
                            "${convertDate(widget.list[index]["waktuMulai"])} s/d ${convertDate(widget.list[index]["waktuSelesai"])}",
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.grey),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Meminjam : ${widget.list[index]["ruang"]}",
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Judul Acara : ${widget.list[index]["judul"]}",
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Status : ${widget.list[index]["status"]}",
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
                            return const DetailPesananAdmin();
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
    );
  }
}
