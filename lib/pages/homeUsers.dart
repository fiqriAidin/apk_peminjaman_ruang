import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/beranda.dart';
import 'package:peminjaman_ruang/pages/list_ruang.dart';
import 'package:peminjaman_ruang/pages/list_pesanan_admin.dart';

class HomeUsers extends StatefulWidget {
  HomeUsers({Key? key, this.dataUsers}) : super(key: key);
  var dataUsers;

  @override
  State<HomeUsers> createState() => _HomeUsersState();
}

class _HomeUsersState extends State<HomeUsers>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
          Beranda(),
          ListRuang(
            role: "user",
          ),
          ListPesananAdmin(
            role: "user",
            dataRole: widget.dataUsers,
          ),
        ],
      ),
      bottomNavigationBar: Material(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            controller: controller,
            tabs: const [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.storage_outlined)),
              Tab(icon: Icon(Icons.file_copy_sharp)),
            ],
          ),
        ),
      ),
    );
  }
}
