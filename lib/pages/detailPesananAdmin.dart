import 'package:flutter/material.dart';

class DetailPesananAdmin extends StatelessWidget {
  const DetailPesananAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pesanan"),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const Center(
                child: Text(
                  "Judul Acara",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
              const Text(
                "Peminjam :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Nama Peminjam",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Meminjam :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Nama Ruang",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Deskripsi Acara :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Berisikan deskripsi acara yang berlangsung",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Nomer HP :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "081234567891",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Tanggal :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "20 Agustus 200",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Jam mulai :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "10.00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Jam Selesai :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "12.00",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Dokumen Pendukung :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Diupload ke aplikasi",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15.0)),
              const Text(
                "Status Terima Dokumen :",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Sudah di terima",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                    label: const Text("Setujui"),
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size((MediaQuery.of(context).size.width * 0.45), 50),
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cancel),
                    label: const Text("Tolak"),
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size((MediaQuery.of(context).size.width * 0.45), 50),
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
            ],
          ),
        ),
      ]),
      floatingActionButton: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 120.0)),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            backgroundColor: Colors.amber,
            child: const Icon(Icons.edit),
          ),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
