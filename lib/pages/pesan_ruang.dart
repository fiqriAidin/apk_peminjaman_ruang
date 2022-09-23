import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:peminjaman_ruang/components/inputDateTime.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';

class PesanRuang extends StatefulWidget {
  const PesanRuang({Key? key}) : super(key: key);

  @override
  _PesanRuangState createState() => _PesanRuangState();
}

class _PesanRuangState extends State<PesanRuang> {
  List<String> ruang = ["Pilih Ruang", "Ruang A", "Ruang B", "Ruang C"];
  String _ruang = "Pilih Ruang";
  List<String> dokumen = [
    "Pilih Status Dokumen",
    "Diupload ke aplikasi",
    "Diserahkan berupa hardcopy",
  ];
  String _dokumen = "Pilih Status Dokumen";
  String fileName = "Upload File";
  DateTime date = DateTime(0);
  TimeOfDay firstTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay lastTime = const TimeOfDay(hour: 0, minute: 0);
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerDesk = TextEditingController();
  TextEditingController controllerNomor = TextEditingController();

  void kirimValue() {
    AlertDialog alert = AlertDialog(
      title: const Text("Data Berhasil Disimpan"),
      content: Container(
        height: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Judul Acara : ${controllerJudul.text}"),
            Text("Pilih Ruang : ${_ruang}"),
            Text("Deskripsi Acara : ${controllerDesk.text}"),
            Text("Tanggal Mulai : ${date.day}-${date.month}-${date.year}"),
            Text("Jam Mulai : ${firstTime.hour} : ${firstTime.minute}"),
            Text("Jam Selesai : ${lastTime.hour} : ${lastTime.minute}"),
            Text("Nomor HP : ${controllerNomor.text}"),
          ],
        ),
      ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pemesanan Ruang"),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InputForm(
                  controller: controllerJudul,
                  label: "Judul Acara",
                  hint: "Masukkan Judul Acara",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: "Ruang",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  value: _ruang,
                  items: ruang.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _ruang = value.toString();
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
                  controller: controllerDesk,
                  maxLines: 3,
                  label: "Deskripsi Acara",
                  hint: "Masukkan Deskripsi Acara",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.calendar_today,
                  label: (date == DateTime(0))
                      ? '  Tanggal'
                      : '  ${date.day}-${date.month}-${date.year}',
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1111),
                      lastDate: DateTime(2222),
                    ).then((value) {
                      setState(() {
                        date = value!;
                      });
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.more_time,
                  label: (firstTime == const TimeOfDay(hour: 0, minute: 0))
                      ? "  Jam Mulai"
                      : '  ${firstTime.hour} : ${firstTime.minute}',
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                    ).then((value) {
                      setState(() {
                        firstTime = value!;
                      });
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.more_time,
                  label: (lastTime == const TimeOfDay(hour: 0, minute: 0))
                      ? "  Jam Selesai"
                      : '  ${lastTime.hour} : ${lastTime.minute}',
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                    ).then((value) {
                      setState(() {
                        lastTime = value!;
                      });
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputForm(
                  controller: controllerNomor,
                  label: "Nomor HP",
                  hint: "Masukkan Nomor HP",
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: "Status Dokumen",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  value: _dokumen,
                  items: dokumen.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _dokumen = value.toString();
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.upload_file,
                  label: "  $fileName",
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      final file = result.files.first;
                      setState(() {
                        fileName = file.name;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 48.0,
        child: ElevatedButton(
          onPressed: () {
            kirimValue();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: const Text(
            "Pesan",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
