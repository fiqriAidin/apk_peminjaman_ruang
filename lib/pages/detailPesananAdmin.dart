import 'package:flutter/material.dart';

class DetailPesananAdmin extends StatefulWidget {
  DetailPesananAdmin({Key? key, this.data}) : super(key: key);
  var data;

  @override
  State<DetailPesananAdmin> createState() => _DetailPesananAdminState();
}

class _DetailPesananAdminState extends State<DetailPesananAdmin> {
  String convertDate(value) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(value));
    var result = "${date.day}-${date.month}-${date.year}";

    return result;
  }

  String convertTime(value) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(value));
    var result = "${date.hour}:${date.minute}:${date.second}";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pesanan"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              Center(
                child: Text(
                  widget.data['judul'],
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
                child: Text(
                  widget.data["peminjamMhs"].toString() == "[]"
                      ? widget.data["peminjamPgw"].toString()
                      : widget.data["peminjamMhs"].toString(),
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
                child: Text(
                  widget.data['ruang'],
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
                child: Text(
                  widget.data['deskripsi'],
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
                child: Text(
                  widget.data['nomorHp'],
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
                child: Text(
                  convertDate(widget.data['waktuMulai']),
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
                child: Text(
                  convertTime(widget.data['waktuMulai']),
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
                child: Text(
                  convertTime(widget.data['waktuSelesai']),
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
                child: Text(
                  widget.data['statusDokumen'] == "2"
                      ? "Diserahkan Hardcopy"
                      : "Diupload di aplikasi",
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
                child: Text(
                  widget.data['statusTerimaDokumen'] == "5"
                      ? "Belum diperiksa"
                      : widget.data['statusTerimaDokumen'] == "3"
                          ? "Diterima"
                          : "Ditolak",
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
