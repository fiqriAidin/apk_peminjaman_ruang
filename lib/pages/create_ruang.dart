import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/components/inputDateTime.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/pages/list_ruang.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class CreateRuang extends StatefulWidget {
  CreateRuang(
      {Key? key,
      this.id,
      this.code,
      this.name,
      this.description,
      this.firstTimeOff,
      this.lastTimeOff,
      this.status})
      : super(key: key);
  var id;
  var code;
  var name;
  var description;
  var firstTimeOff;
  var lastTimeOff;
  var status;

  @override
  _CreateRuangState createState() => _CreateRuangState();
}

class _CreateRuangState extends State<CreateRuang> {
  DateTime firstDate = DateTime(0);
  DateTime lastDate = DateTime(0);

  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();

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
    createDataRuang(
      controllerCode.text,
      controllerName.text,
      controllerDesc.text,
      "${firstDate.millisecondsSinceEpoch}",
      "${lastDate.millisecondsSinceEpoch}",
    );

    Navigator.pop(context);
  }

  void updateRuang() {
    updateDataRuang(
      widget.id,
      controllerCode.text,
      controllerName.text,
      controllerDesc.text,
      "${firstDate.millisecondsSinceEpoch}",
      "${lastDate.millisecondsSinceEpoch}",
      widget.status,
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    // print(widget.id);
    if (widget.id != null) {
      setState(() {
        controllerCode.text = widget.code;
        controllerName.text = widget.name;
        controllerDesc.text = widget.description;
        firstDate =
            DateTime.fromMillisecondsSinceEpoch(int.parse(widget.firstTimeOff));
        lastDate =
            DateTime.fromMillisecondsSinceEpoch(int.parse(widget.lastTimeOff));
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
                  controller: controllerCode,
                  label: "Kode Ruang",
                  hint: "Masukkan Kode Ruang",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
                  controller: controllerName,
                  label: "Nama Ruang",
                  hint: "Masukkan Nama Ruang",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
                  controller: controllerDesc,
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
            if (widget.id == null) {
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
