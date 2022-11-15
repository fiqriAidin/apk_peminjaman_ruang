import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/beranda.dart';
import 'package:peminjaman_ruang/pages/master_status.dart';
import 'package:peminjaman_ruang/pages/list_ruang.dart';
import 'package:peminjaman_ruang/pages/list_pesanan.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key? key, this.dataUsers}) : super(key: key);
  var dataUsers;

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 4);
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
          MasterStatus(),
          ListRuang(
            role: "admin",
          ),
          ListPesanan(
            role: "admin",
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
              Tab(icon: Icon(Icons.widgets)),
              Tab(icon: Icon(Icons.storage_outlined)),
              Tab(icon: Icon(Icons.file_copy_sharp)),
            ],
          ),
        ),
      ),
    );
  }
}
