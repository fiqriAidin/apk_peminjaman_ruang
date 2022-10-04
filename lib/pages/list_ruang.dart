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
  var itemCount = 0;

  @override
  void initState() {
    // print("Regres hal ruang");
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
          await Future.delayed(Duration(milliseconds: 1500));
          setState(() {
            itemCount = itemCount + 1;
          });
        },
        child: FutureBuilder(
          future: getDataRuang(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ListValue(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
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

class ListValue extends StatefulWidget {
  ListValue({Key? key, this.list}) : super(key: key);
  var list;

  @override
  _ListValueState createState() => _ListValueState();
}

class _ListValueState extends State<ListValue> {
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

  String convertDate(time) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var result = "${date.day}-${date.month}-${date.year}";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: widget.list[index]["status"] == "close"
                        ? Colors.red
                        : Colors.green,
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.list[index]["name"],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Kode Ruang : ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            widget.list[index]["code"],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Deskripsi : ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Expanded(
                            child: Text(
                              widget.list[index]["description"],
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Tanggal Awal Off : ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            convertDate(widget.list[index]["firstTimeOff"]),
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Tanggal Akhir Off : ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            convertDate(widget.list[index]["lastTimeOff"]),
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Status : ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            widget.list[index]["status"],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CreateRuang(
                                  id: widget.list[index]["id"],
                                  code: widget.list[index]["code"],
                                  name: widget.list[index]["name"],
                                  description: widget.list[index]
                                      ["description"],
                                  firstTimeOff: widget.list[index]
                                      ["firstTimeOff"],
                                  lastTimeOff: widget.list[index]
                                      ["lastTimeOff"],
                                  status: widget.list[index]["status"],
                                );
                              }));
                            },
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5.0)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Icon(Icons.delete),
                            onPressed: () {
                              confirm(
                                widget.list[index]["id"],
                                widget.list[index]["name"],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
