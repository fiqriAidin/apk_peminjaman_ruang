import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/components/inputForm.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class MasterStatus extends StatelessWidget {
  const MasterStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void inputValue() {
      AlertDialog alert = AlertDialog(
        title: const Text("Input Data Master Status"),
        content: Container(
          child: InputForm(
            label: "Master Status",
            hint: "Input nama status",
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: const Text("Tutup"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            child: const Text("Simpan"),
            onPressed: () {},
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Master Status"),
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
      body: FutureBuilder(
        future: getDataStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          print(snapshot.data);
          return snapshot.hasData
              ? ListValue(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
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

class ListValue extends StatefulWidget {
  ListValue({Key? key, this.list}) : super(key: key);
  var list;

  @override
  State<ListValue> createState() => _ListValueState();
}

class _ListValueState extends State<ListValue> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status : ${widget.list[index]["name"]}",
                    style: const TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      const Padding(padding: EdgeInsets.only(left: 5.0)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Icon(Icons.delete),
                        onPressed: () {},
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
}
