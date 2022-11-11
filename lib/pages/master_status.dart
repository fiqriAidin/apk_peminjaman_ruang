import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class MasterStatus extends StatefulWidget {
  const MasterStatus({Key? key}) : super(key: key);

  @override
  State<MasterStatus> createState() => _MasterStatusState();
}

class _MasterStatusState extends State<MasterStatus> {
  TextEditingController controllerName = TextEditingController();

  var itemCount = 0;

  void inputValue() {
    AlertDialog alert = AlertDialog(
      title: const Text("Input Data Master Status"),
      content: Container(
        child: InputForm(
          controller: controllerName,
          label: "Master Status",
          hint: "Input nama status",
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Tutup"),
          onPressed: () {
            setState(() {
              controllerName.text = "";
            });
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text("Simpan"),
          onPressed: () {
            createDataStatus(controllerName.text);
            Navigator.of(context).pop();
            setState(() {
              controllerName.text = "";
            });
          },
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
            deleteDataStatus(id);
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

  void updateValue(nomor, status) {
    setState(() {
      controllerName.text = status;
    });

    AlertDialog alert = AlertDialog(
      title: const Text("Input Data Master Status"),
      content: Container(
        child: InputForm(
          controller: controllerName,
          label: "Master Status",
          hint: "Input nama status",
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Tutup"),
          onPressed: () {
            setState(() {
              controllerName.text = "";
            });
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text("Simpan"),
          onPressed: () {
            updateDataStatus(nomor, controllerName.text);
            Navigator.of(context).pop();
            setState(() {
              controllerName.text = "";
            });
          },
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

  Widget listView(BuildContext context, var data) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status : ${data[index]["status"]}",
                    style: const TextStyle(
                      fontSize: 19,
                    ),
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
                          updateValue(
                            data[index]["nomor"],
                            data[index]["status"],
                          );
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
                            data[index]["nomor"],
                            data[index]["delete"],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Master Status"),
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
          future: getDataStatus(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? listView(context, snapshot.data)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_comment),
        backgroundColor: Colors.green,
        label: const Text("Tambah Data"),
        onPressed: () {
          inputValue();
        },
      ),
    );
  }
}
