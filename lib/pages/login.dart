import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/homeAdmin.dart';
import 'package:peminjaman_ruang/pages/homeUsers.dart';
import 'package:peminjaman_ruang/pages/onboarding_page.dart';
import 'package:peminjaman_ruang/utils/api.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const OnBoardingPage();
                  }),
                );
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 13),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "WELCOME",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Image.asset(
                  "img/IconCampus.png",
                  width: 250.0,
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: const Icon(
                            Icons.account_circle_outlined,
                            size: 40.0,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            size: 40.0,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomeAdmin();
                          }));
                        },
                        child: const Text(
                          "Login Admin",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.0)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomeUsers();
                          }));
                        },
                        child: const Text(
                          "Login User",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      ElevatedButton(
                        onPressed: () {
                          getDataRuang();
                        },
                        child: const Text(
                          "tombol percobaan",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 13),
          ),
        ],
      ),
    );
  }
}
