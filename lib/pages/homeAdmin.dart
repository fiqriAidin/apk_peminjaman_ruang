import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/beranda.dart';
import 'package:peminjaman_ruang/pages/master_status.dart';
import 'package:peminjaman_ruang/pages/list_ruang.dart';
import 'package:peminjaman_ruang/pages/list_pesanan_admin.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

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
        children: const [
          Beranda(),
          MasterStatus(),
          ListRuang(),
          ListPesananAdmin(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          controller: controller,
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.widgets)),
            Tab(icon: Icon(Icons.storage_outlined)),
            Tab(icon: Icon(Icons.file_copy_sharp)),
          ],
        ),
      ),
    );
  }
}
