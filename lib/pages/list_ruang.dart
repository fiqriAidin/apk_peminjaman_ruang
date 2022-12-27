import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/pages/detailRuang.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/pages/create_ruang.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class ListRuang extends StatefulWidget {
  ListRuang({Key? key, this.role, this.dataRole}) : super(key: key);
  var role;
  var dataRole;

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
        backgroundColor: Color.fromRGBO(16, 57, 104, 1),
        title: Container(
          padding: EdgeInsets.only(left: 50),
          alignment: Alignment.center,
          child: Text("List Ruang"),
        ),
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
                    idRole: widget.dataRole,
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
                  return CreateRuang(
                    pengelola: widget.dataRole['NIP'],
                  );
                }));
              },
            )
          : Text(""),
    );
  }
}

class ListValue extends StatefulWidget {
  ListValue({Key? key, this.list, this.condition, this.role, this.idRole})
      : super(key: key);
  var list;
  var condition;
  var role;
  var idRole;

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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailRuang(
                            data: newData[index],
                            role: widget.role,
                            idRole: widget.idRole,
                          );
                        }));
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
