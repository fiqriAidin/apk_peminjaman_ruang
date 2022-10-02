import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/components/inputDateTime.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';

class CreateRuang extends StatefulWidget {
  const CreateRuang({Key? key}) : super(key: key);

  @override
  _CreateRuangState createState() => _CreateRuangState();
}

class _CreateRuangState extends State<CreateRuang> {
  DateTime firstDate = DateTime(0);
  DateTime lastDate = DateTime(0);

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
    print(firstDate.millisecondsSinceEpoch);
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
    print(lastDate.millisecondsSinceEpoch);
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
                  label: "Kode Ruang",
                  hint: "Masukkan Kode Ruang",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
                  label: "Nama Ruang",
                  hint: "Masukkan Nama Ruang",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
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
          onPressed: () {},
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
