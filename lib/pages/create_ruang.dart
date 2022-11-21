import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/components/inputDateTime.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/pages/list_ruang.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class CreateRuang extends StatefulWidget {
  CreateRuang(
      {Key? key,
      this.nomor,
      this.ruang,
      this.keterangan,
      this.informasi,
      this.tanggalAwalOff,
      this.tanggalAkhirOff,
      this.kode})
      : super(key: key);
  var nomor;
  var ruang;
  var keterangan;
  var informasi;
  var tanggalAwalOff;
  var tanggalAkhirOff;
  var kode;

  @override
  _CreateRuangState createState() => _CreateRuangState();
}

class _CreateRuangState extends State<CreateRuang> {
  DateTime firstDate = DateTime(0);
  DateTime lastDate = DateTime(0);

  TextEditingController controllerRuang = TextEditingController();
  TextEditingController controllerKet = TextEditingController();
  TextEditingController controllerInfo = TextEditingController();

  selectFirstDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1111),
      lastDate: DateTime(2222),
    );
    if (selected != null && selected != firstDate)
      setState(() {
        firstDate = selected;
      });
  }

  selectLastDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1111),
      lastDate: DateTime(2222),
    );
    if (selected != null && selected != lastDate)
      setState(() {
        lastDate = selected;
      });
  }

  void createNewRuang() {
    if (controllerRuang.text == "" ||
        controllerKet.text == "" ||
        controllerInfo.text == "") {
      AlertDialog alert = AlertDialog(
        title: const Text("Peringatan !!!"),
        content: Text("Mohon untuk mengisi semua form yang ada"),
        actions: [
          ElevatedButton(
            child: const Text("Oke"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
      showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      createDataRuang(
        controllerRuang.text,
        controllerKet.text,
        controllerInfo.text,
        firstDate == DateTime(0) ? "" : "${firstDate.millisecondsSinceEpoch}",
        lastDate == DateTime(0) ? "" : "${lastDate.millisecondsSinceEpoch}",
        "K",
      );

      Navigator.pop(context);
    }
  }

  void updateRuang() {
    updateDataRuang(
      widget.nomor,
      controllerRuang.text,
      controllerKet.text,
      controllerInfo.text,
      firstDate == DateTime(0) ? "" : "${firstDate.millisecondsSinceEpoch}",
      lastDate == DateTime(0) ? "" : "${lastDate.millisecondsSinceEpoch}",
      widget.kode,
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    // print(widget.id);
    if (widget.nomor != null) {
      setState(() {
        controllerRuang.text = widget.ruang;
        controllerKet.text = widget.keterangan;
        controllerInfo.text = widget.informasi;
        firstDate = widget.tanggalAwalOff == null
            ? DateTime(0)
            : DateTime.fromMillisecondsSinceEpoch(
                int.parse(widget.tanggalAwalOff));
        lastDate = widget.tanggalAkhirOff == null
            ? DateTime(0)
            : DateTime.fromMillisecondsSinceEpoch(
                int.parse(widget.tanggalAkhirOff));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peminjaman Ruang PENS"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InputForm(
                  controller: controllerRuang,
                  label: "Kode Ruang",
                  hint: "Masukkan Kode Ruang",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
                  controller: controllerKet,
                  label: "Nama Ruang",
                  hint: "Masukkan Nama Ruang",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
                  controller: controllerInfo,
                  maxLines: 3,
                  label: "Deskripsi Ruang",
                  hint: "Masukkan Deskripsi/Informasi Ruang",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.calendar_today,
                  label: (firstDate == DateTime(0))
                      ? '  Tanggal Awal Off'
                      : '  ${firstDate.day}-${firstDate.month}-${firstDate.year}',
                  onPressed: () {
                    selectFirstDate(context);
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.calendar_today,
                  label: (lastDate == DateTime(0))
                      ? '  Tanggal Akhir Off'
                      : '  ${lastDate.day}-${lastDate.month}-${lastDate.year}',
                  onPressed: () {
                    selectLastDate(context);
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 48.0,
        child: ElevatedButton(
          onPressed: () {
            if (widget.nomor == null) {
              createNewRuang();
            } else {
              updateRuang();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: const Text(
            "Kirim",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
