import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/pages/create_ruang.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class ListRuang extends StatefulWidget {
  const ListRuang({Key? key}) : super(key: key);

  @override
  _ListRuangState createState() => _ListRuangState();
}

class _ListRuangState extends State<ListRuang> {
  List<String> field = ["Semua Ruang", "Ruang Open", "Ruang Close"];
  String _field = "Semua Ruang";
  var newData = ([]);
  var oldData = ([]);
  var itemCount = 0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1300), () {
      setState(() {
        newData = oldData;
      });
      // print(newData);
    });

    // TODO: implement initState
    super.initState();
  }

  String convertDate(time) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result = "${date.day}-${date.month}-${date.year}";

    return result;
  }

  void confirm(id, name) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Apakah kamu yakin ingin menghapus ${name}"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {});
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
            setState(() {});
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

  void filterData(String value) {
    var result = [];
    if (value == "all") {
      result = oldData;
    } else {
      result = oldData
          .where((element) => element["status"]
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
    newData = result;
  }

  void viewDetail(id, name, code, descrition, firsTime, lastTime, status) {
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
              child: Text(name),
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
              child: Text(code),
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
              child: Text(descrition),
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
              child: Text(convertDate(firsTime)),
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
              child: Text(convertDate(lastTime)),
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
              child: Text(status),
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
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreateRuang(
                id: id,
                code: code,
                name: name,
                description: descrition,
                firstTimeOff: firsTime,
                lastTimeOff: lastTime,
                status: status,
              );
            }));
          },
          child: const Icon(Icons.edit),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            confirm(id, name);
          },
          child: const Icon(Icons.delete),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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

  Widget listView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: newData == null ? 0 : newData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Card(
              color: newData[index]["status"] == "open"
                  ? Colors.green
                  : Colors.red,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: ListTile(
                title: Text(newData[index]["name"]),
                subtitle: Text('Status : ${newData[index]["status"]}'),
                leading: const Icon(
                  Icons.meeting_room,
                  size: 30,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  viewDetail(
                    newData[index]["id"],
                    newData[index]["name"],
                    newData[index]["code"],
                    newData[index]["description"],
                    newData[index]["firstTimeOff"],
                    newData[index]["lastTimeOff"],
                    newData[index]["status"],
                  );
                },
                iconColor: Colors.white,
                textColor: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  void temp(var value) {
    oldData = value;
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
          await Future.delayed(Duration(milliseconds: 1500));

          setState(() {
            itemCount = itemCount + 1;
            newData = oldData;
          });
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                value: _field,
                items: field.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _field = value.toString();
                  });
                  if (value.toString() == "Ruang Open") {
                    filterData("open");
                  } else if (value.toString() == "Ruang Close") {
                    filterData("close");
                  } else {
                    filterData("all");
                  }
                },
              ),
            ),
            FutureBuilder(
              future: getDataRuang(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }

                if (snapshot.hasData) {
                  temp(snapshot.data);
                  return listView(context);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Tambah Ruang"),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateRuang();
          }));
        },
      ),
    );
  }
}
