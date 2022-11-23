import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:peminjaman_ruang/pages/beranda.dart';
import 'package:peminjaman_ruang/pages/list_ruang.dart';
import 'package:peminjaman_ruang/pages/list_pesanan.dart';

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
          ListPesanan(
            role: "user",
            dataRole: widget.dataUsers,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 45, right: 45),
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
                icon: Icons.storage_outlined,
                text: "Ruang",
                onPressed: () => controller.index = 1,
              ),
              GButton(
                icon: Icons.file_copy_sharp,
                text: "Pesanan",
                onPressed: () => controller.index = 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
