import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/pages/create_ruang.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class ListRuang extends StatefulWidget {
  ListRuang({Key? key, this.role}) : super(key: key);
  var role;

  @override
  _ListRuangState createState() => _ListRuangState();
}

class _ListRuangState extends State<ListRuang> {
  var itemCount = 0;
  bool indikator = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Ruang"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));

          setState(() {
            itemCount = itemCount + 1;
          });
        },
        child: FutureBuilder(
          future: getDataRuang(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }

            return snapshot.hasData
                ? ListValue(
                    list: snapshot.data,
                    role: widget.role,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
      floatingActionButton: widget.role == "admin"
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text("Tambah Ruang"),
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateRuang();
                }));
              },
            )
          : Text(""),
    );
  }
}

class ListValue extends StatefulWidget {
  ListValue({Key? key, this.list, this.condition, this.role}) : super(key: key);
  var list;
  var condition;
  var role;

  @override
  State<ListValue> createState() => _ListValueState();
}

class _ListValueState extends State<ListValue> {
  var newData = ([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newData = widget.list;
  }

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

  void viewDetail(nomor, keterangan, ruang, informasi, tanggalAwalOff,
      tanggalAkhirOff, kode) {
    AlertDialog alertDialog = AlertDialog(
      content: Container(
        height: 470,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft, child: Text("Nama Ruang :")),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(keterangan),
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
                alignment: Alignment.topLeft, child: Text("Code Ruang :")),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(ruang),
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(alignment: Alignment.topLeft, child: Text("Deskripsi :")),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(informasi),
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
                alignment: Alignment.topLeft,
                child: Text("Tanggal Awal Off :")),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(convertDate(tanggalAwalOff)),
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
                alignment: Alignment.topLeft,
                child: Text("Tanggal Akhir Off :")),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(convertDate(tanggalAkhirOff)),
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(alignment: Alignment.topLeft, child: Text("Status :")),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(kode.toString()),
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.close_outlined),
        ),
        widget.role == "admin"
            ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateRuang(
                      nomor: nomor,
                      ruang: ruang,
                      keterangan: keterangan,
                      informasi: informasi,
                      tanggalAwalOff: tanggalAwalOff,
                      tanggalAkhirOff: tanggalAkhirOff,
                      kode: kode,
                    );
                  }));
                },
                child: const Icon(Icons.edit),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              )
            : const Padding(padding: EdgeInsets.only(left: 0.0)),
        widget.role == "admin"
            ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  confirm(nomor, keterangan);
                },
                child: const Icon(Icons.delete),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              )
            : const Padding(padding: EdgeInsets.only(left: 0.0)),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void filterData(String value) {
    var result = [];
    if (value.isEmpty) {
      setState(() {
        result = widget.list;
      });
    } else {
      setState(() {
        result = widget.list
            .where((element) => element["keterangan"]
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      });
    }
    newData = result;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));

        setState(() {
          newData = widget.list;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: InputForm(
              label: "Cari",
              hint: "Masukkan nama ruang yang di cari",
              onChenged: (value) => filterData(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: newData == null ? 0 : newData.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    elevation: 4,
                    // color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(newData[index]["keterangan"]),
                      subtitle: Text('Code : ${newData[index]["ruang"]}'),
                      leading: const Icon(
                        Icons.meeting_room,
                        size: 30,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        viewDetail(
                          widget.list[index]["nomor"],
                          widget.list[index]["keterangan"],
                          widget.list[index]["ruang"],
                          widget.list[index]["informasi"],
                          widget.list[index]["tanggalAwalOff"],
                          widget.list[index]["tanggalAkhirOff"],
                          widget.list[index]["kode"],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
