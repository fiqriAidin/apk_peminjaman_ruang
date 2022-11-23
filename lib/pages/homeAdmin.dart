import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: GNav(
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromRGBO(16, 57, 104, 1),
            gap: 8,
            padding: const EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
                onPressed: () => controller.index = 0,
              ),
              GButton(
                icon: Icons.widgets,
                text: "Status",
                onPressed: () => controller.index = 1,
              ),
              GButton(
                icon: Icons.storage_outlined,
                text: "Ruang",
                onPressed: () => controller.index = 2,
              ),
              GButton(
                icon: Icons.file_copy_sharp,
                text: "Pesanan",
                onPressed: () => controller.index = 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
