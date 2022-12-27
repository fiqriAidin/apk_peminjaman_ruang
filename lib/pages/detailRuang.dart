import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/create_ruang.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class DetailRuang extends StatefulWidget {
  DetailRuang({Key? key, this.data, this.role, this.idRole}) : super(key: key);
  var data;
  var role;
  var idRole;

  @override
  State<DetailRuang> createState() => _DetailRuangState();
}

class _DetailRuangState extends State<DetailRuang> {
  String convertDate(time) {
    if (time == null) {
      return "Tersedia";
    } else {
      var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
      var result = "${date.day}-${date.month}-${date.year}";

      return result;
    }
  }

  void confirm(id, name) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Apakah kamu yakin ingin menghapus ${name}"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Batal"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            deleteDataRuang(id);

            Navigator.pop(context);
          },
          child: const Text("Delete"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 57, 104, 1),
        title: Container(
            padding: EdgeInsets.only(right: 50),
            alignment: Alignment.center,
            child: Text("Detail Ruang")),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Center(
                  child: Text(
                    widget.data['keterangan'],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Code Ruang :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
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
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Pengelola :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.data['pengelola'].toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Kapasitas Ruang :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "${widget.data['kapasitas']} Orang",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Deskripsi :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.data['informasi'],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Tanggal Awal Off :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    convertDate(widget.data['tanggalAwalOff']),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Tanggal Akhir Off :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    convertDate(widget.data['tanggalAkhirOff']),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Status :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.data['kode'].toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.role == "admin"
          ? Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 120.0)),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateRuang(
                        nomor: widget.data['nomor'],
                        ruang: widget.data['ruang'],
                        keterangan: widget.data['keterangan'],
                        pengelola: widget.idRole['NIP'],
                        kapasitas: widget.data['kapasitas'],
                        informasi: widget.data['informasi'],
                        tanggalAwalOff: widget.data['tanggalAwalOff'],
                        tanggalAkhirOff: widget.data['tanggalAkhirOff'],
                        kode: widget.data['kode'],
                      );
                    }));
                  },
                  backgroundColor: Colors.amber,
                  child: const Icon(Icons.edit),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    confirm(widget.data['nomor'], widget.data['keterangan']);
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete),
                ),
              ],
            )
          : Text(""),
    );
  }
}
