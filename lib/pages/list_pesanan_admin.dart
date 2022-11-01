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
        future: getDataPemesanan(),
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
    var result = "${date.day}-${date.month}-${date.year}";

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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      widget.list[index]["users"],
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
                            convertDate(widget.list[index]["date"]),
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
                            "Judul Acara : ${widget.list[index]["name"]}",
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: widget.list[index]["status"] == "Setuju"
                                ? const Icon(Icons.check)
                                : const Icon(Icons.close),
                            label: widget.list[index]["status"] == "Setuju"
                                ? const Text("Pemesanan Ruang Disetujui")
                                : const Text("Pemesanan Ruang Ditolak"),
                            style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 40),
                              backgroundColor:
                                  widget.list[index]["status"] == "Setuju"
                                      ? Colors.green
                                      : Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
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
