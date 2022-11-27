import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:peminjaman_ruang/components/inputDateTime.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/utils/api.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PesanRuang extends StatefulWidget {
  PesanRuang({Key? key, this.data, this.dataRole, this.role}) : super(key: key);
  var data;
  var dataRole;
  var role;

  @override
  _PesanRuangState createState() => _PesanRuangState();
}

class _PesanRuangState extends State<PesanRuang> {
  List<dynamic> pesanan = [];
  List<dynamic> ruang = [];
  String? _ruang;
  List<String> dokumen = [
    "Diupload ke aplikasi",
    "Diserahkan Hardcopy",
  ];
  String? _dokumen;
  List<String> statusPeminjam = ["Internal", "External"];
  String? _statusPeminjam;
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

  String convertDate(time) {
    var value = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result = "${value.day}-${value.month}-${value.year}";

    return result;
  }

  void kirimValue() async {
    // print(_statusPeminjam);
    bool statusPesanan = false;
    await pesanan.map((e) {
      if (e['ruang'] == _ruang && e['status'] != "Ditolak") {
        if (convertDate(e['waktuMulai']) ==
            "${date.day}-${date.month}-${date.year}") {
          statusPesanan = true;
        }
      }
    }).toList();

    var tempDokumen = "";
    var tempStatusPeminjam = _statusPeminjam == null
        ? "6"
        : _statusPeminjam == "Internal"
            ? "6"
            : "7";
    var tempRuang;
    var tempPeminjam = widget.dataRole['NIP'] == null
        ? widget.dataRole['NRP']
        : widget.dataRole['NIP'];
    var tempWatuPinjam = "${DateTime.now().millisecondsSinceEpoch}";
    var tempStatusDokumen = _dokumen == "Diupload ke aplikasi" ? "1" : "2";
    await ruang.map((e) {
      if (e['keterangan'] == _ruang) {
        tempRuang = e['nomor'];
      }
    }).toList();
    if (controllerJudul.text == "" ||
        controllerDesk.text == "" ||
        controllerNomor.text == "" ||
        _ruang == null ||
        _dokumen == null) {
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
    } else if (date == DateTime(0) ||
        firstTime == TimeOfDay(hour: 00, minute: 00) ||
        lastTime == TimeOfDay(hour: 00, minute: 00)) {
      AlertDialog alert = AlertDialog(
        title: const Text("Peringatan !!!"),
        content: Text("Waktu pemesanan wajib di isi"),
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
    } else if (statusPesanan) {
      AlertDialog alert = AlertDialog(
        title: const Text("Peringatan !!!"),
        content: Text(
            "Ruang tersebut sudah dipesan di waktu yang sama oleh user lain"),
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
      if (widget.data == null) {
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
            "5",
            tempStatusPeminjam,
            tempDokumen);
      } else {
        updateDataPesanan(
            widget.data['nomor'],
            controllerJudul.text,
            tempRuang,
            controllerDesk.text,
            convertTimestamp(firstTime.hour, firstTime.minute),
            convertTimestamp(lastTime.hour, lastTime.minute),
            controllerNomor.text,
            tempStatusDokumen,
            widget.data['statusTerimaDokumen'],
            widget.data['idPeminjam'],
            widget.data['waktuPinjam'],
            widget.data['idStatus'],
            tempStatusPeminjam,
            tempDokumen);
      }

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

  void listPesanan() async {
    final response = await http.get(Uri.parse(
        'https://project.mis.pens.ac.id/mis142/API/api_view.php?apicall=get_pesanan'));
    var map = json.decode(response.body);
    var data = map["result"];
    setState(() {
      pesanan = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listRuang();
    listPesanan();

    if (widget.data != null) {
      var tempDateMulai = DateTime.fromMillisecondsSinceEpoch(
          int.parse(widget.data['waktuMulai']));
      var tempDateSelesai = DateTime.fromMillisecondsSinceEpoch(
          int.parse(widget.data['waktuSelesai']));
      TimeOfDay timeMulai =
          TimeOfDay(hour: tempDateMulai.hour, minute: tempDateMulai.minute);
      TimeOfDay timeSelesai =
          TimeOfDay(hour: tempDateSelesai.hour, minute: tempDateSelesai.minute);
      setState(() {
        controllerJudul.text = widget.data['judul'];
        controllerDesk.text = widget.data['deskripsi'];
        _ruang = widget.data['ruang'];
        controllerNomor.text = widget.data['nomorHp'];
        _dokumen = widget.data['statusDokumen'] == "1"
            ? "Diupload ke aplikasi"
            : "Diserahkan Hardcopy";
        date = tempDateMulai;
        firstTime = timeMulai;
        lastTime = timeSelesai;
        _statusPeminjam =
            widget.data['statusPeminjam'] == "6" ? "Internal" : "External";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 57, 104, 1),
        title: Container(
          padding: EdgeInsets.only(right: 50),
          alignment: Alignment.center,
          child: Text(widget.data == null
              ? "Daftar Pemesanan Ruang"
              : "Rubah Pemesanan Ruang"),
        ),
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
                widget.role == "admin"
                    ? DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: "Status Peminjam",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        value: _statusPeminjam,
                        hint: Text("Pilih Status Peminjam"),
                        items: statusPeminjam.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _statusPeminjam = value.toString();
                          });
                        },
                      )
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                widget.role == "admin"
                    ? const Padding(padding: EdgeInsets.only(top: 20.0))
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
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
            backgroundColor: const Color.fromRGBO(16, 57, 104, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Text(
            widget.data == null ? "Pesan" : "Simpan Perubahan",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
