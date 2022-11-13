import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:peminjaman_ruang/components/inputDateTime.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/utils/api.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PesanRuang extends StatefulWidget {
  const PesanRuang({Key? key}) : super(key: key);

  @override
  _PesanRuangState createState() => _PesanRuangState();
}

class _PesanRuangState extends State<PesanRuang> {
  List<dynamic> ruang = [];
  String? _ruang;
  List<String> dokumen = [
    "Diupload ke aplikasi",
    "Diserahkan Hardcopy",
  ];
  String? _dokumen;
  String fileName = "Upload File";
  DateTime date = DateTime(0);
  TimeOfDay firstTime = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay lastTime = const TimeOfDay(hour: 00, minute: 00);
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerDesk = TextEditingController();
  TextEditingController controllerNomor = TextEditingController();

  String convertTimestamp(hour, minute) {
    var tempHour = hour.toString().padLeft(2, '0');
    var tempMinute = minute.toString().padLeft(2, '0');
    String tempString =
        "${date.year}-${date.month}-${date.day} ${tempHour}:${tempMinute}:00";
    DateTime tempDate = DateTime.parse(tempString);
    // print(tempDate.millisecondsSinceEpoch);
    var result = "${tempDate.millisecondsSinceEpoch}";
    return result;
  }

  void kirimValue() async {
    var tempRuang;
    var tempPeminjam = "197112182009102002";
    var tempWatuPinjam = "${DateTime.now().millisecondsSinceEpoch}";
    var tempStatusDokumen = _dokumen == "Diupload ke aplikasi" ? "1" : "2";
    await ruang.map((e) {
      if (e['keterangan'] == _ruang) {
        tempRuang = e['nomor'];
      }
    }).toList();
    // print(tempRuang);
    if (date == DateTime(0) ||
        firstTime == TimeOfDay(hour: 00, minute: 00) ||
        lastTime == TimeOfDay(hour: 00, minute: 00)) {
      AlertDialog alert = AlertDialog(
        title: const Text("Data Berhasil Disimpan"),
        content: Text("Waktu pemesanan wajib di isi !!!"),
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
      createDataPesanan(
          controllerJudul.text,
          tempRuang,
          controllerDesk.text,
          convertTimestamp(firstTime.hour, firstTime.minute),
          convertTimestamp(lastTime.hour, lastTime.minute),
          controllerNomor.text,
          tempStatusDokumen,
          "5",
          tempPeminjam,
          tempWatuPinjam,
          "5");
      Navigator.of(context).pop();
    }
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1111),
      lastDate: DateTime(2222),
    );
    if (selected != null && selected != date)
      setState(() {
        date = selected;
      });
    // print(date);
    // print(date.millisecondsSinceEpoch);
  }

  selectFirstTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    if (selected != null && selected != date)
      setState(() {
        firstTime = selected;
      });
    // print(firstTime);
  }

  selectLastTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    if (selected != null && selected != date)
      setState(() {
        lastTime = selected;
      });
  }

  void listRuang() async {
    final response = await http.get(Uri.parse(
        'https://project.mis.pens.ac.id/mis142/API/api_view.php?apicall=get_ruang'));
    var map = json.decode(response.body);
    var data = map["result"];
    setState(() {
      ruang = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listRuang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pemesanan Ruang"),
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
                  hint: Text("Pilih Ruang"),
                  items: ruang.map((value) {
                    return DropdownMenuItem(
                      child: Text(value['keterangan']),
                      value: value['keterangan'],
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
                    selectDate(context);
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.more_time,
                  label: (firstTime == const TimeOfDay(hour: 0, minute: 0))
                      ? "  Jam Mulai"
                      : '  ${firstTime.hour} : ${firstTime.minute}',
                  onPressed: () {
                    selectFirstTime(context);
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                InputDateTime(
                  icon: Icons.more_time,
                  label: (lastTime == const TimeOfDay(hour: 0, minute: 0))
                      ? "  Jam Selesai"
                      : '  ${lastTime.hour} : ${lastTime.minute}',
                  onPressed: () {
                    selectLastTime(context);
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
                  hint: const Text("Pilih status dokumen"),
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
                _dokumen == "Diupload ke aplikasi"
                    ? InputDateTime(
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
                      )
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
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
