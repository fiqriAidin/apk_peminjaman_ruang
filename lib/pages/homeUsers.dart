import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/beranda.dart';
import 'package:peminjaman_ruang/pages/list_ruang.dart';
import 'package:peminjaman_ruang/pages/list_pesanan_user.dart';

class HomeUsers extends StatefulWidget {
  const HomeUsers({Key? key}) : super(key: key);

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
          ListRuang(),
          ListPesananUser(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          controller: controller,
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.storage_outlined)),
            Tab(icon: Icon(Icons.file_copy_sharp)),
          ],
        ),
      ),
    );
  }
}
