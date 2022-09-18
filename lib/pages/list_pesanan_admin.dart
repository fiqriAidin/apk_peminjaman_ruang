import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/pages/pesan_ruang.dart';
import 'package:peminjaman_ruang/pages/detailPesananAdmin.dart';

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
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListPesanan(
            peminjam: "Nama Peminjam",
            waktu: "22-2-2022 20:30 s/d 20:40",
            ruang: "Nama Ruang",
            judul: "Judul Acaranya",
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
    this.peminjam,
    this.waktu,
    this.ruang,
    this.judul,
  }) : super(key: key);
  var peminjam;
  var waktu;
  var ruang;
  var judul;

  @override
  _ListPesananState createState() => _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const DetailPesananAdmin();
                },
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.peminjam,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.waktu,
                    style: const TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Meminjam : ${widget.ruang}",
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Judul Acara : ${widget.judul}",
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.warning),
                    label: const Text("Pemesanan Ruang Menunggu Persetujuan"),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      primary: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
