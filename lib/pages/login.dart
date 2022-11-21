import 'package:flutter/material.dart';
import 'package:peminjaman_ruang/pages/homeAdmin.dart';
import 'package:peminjaman_ruang/pages/homeUsers.dart';
import 'package:peminjaman_ruang/pages/onboarding_page.dart';
import 'package:peminjaman_ruang/utils/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUsr = TextEditingController();
  TextEditingController controllerPwd = TextEditingController();
  bool loginIndikator = false;

  void pengecekanLogin() async {
    setState(() {
      loginIndikator = true;
    });
    var map;
    bool indikator = true;
    var url =
        Uri.parse('https://project.mis.pens.ac.id/mis142/API/api_auth.php');
    final response = await http.post(url, body: {
      "username": controllerUsr.text,
      "password": controllerPwd.text,
    });
    response.body != "auth error"
        ? map = json.decode(response.body)
        : indikator = false;
    // print(indikator ? "ada" : "null");

    if (controllerUsr.text == "" || controllerPwd.text == "") {
      AlertDialog alertDialog = AlertDialog(
        content: const Text("Username & Password harus di isi !!!"),
        actions: [
          ElevatedButton(
            child: const Text("Oke"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        },
      );
    } else {
      if (indikator) {
        if (map['NIP'] == "197112182009102002") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeAdmin(
              dataUsers: map,
            );
          }));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeUsers(
              dataUsers: map,
            );
          }));
        }
      } else {
        AlertDialog alertDialog = AlertDialog(
          content: const Text(
              "Username & Password yang dimasukkan tidak terdaftar !!!"),
          actions: [
            ElevatedButton(
              child: const Text("Oke"),
              onPressed: () => Navigator.of(context).pop(),
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
    }
    setState(() {
      loginIndikator = false;
    });
  }

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
                        controller: controllerUsr,
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
                        controller: controllerPwd,
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pushReplacement(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return HomeAdmin();
                      //     }));
                      //   },
                      //   child: const Text(
                      //     "Login Admin",
                      //     style: TextStyle(fontSize: 18),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     minimumSize: const Size.fromHeight(50),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(50),
                      //     ),
                      //   ),
                      // ),
                      // const Padding(padding: EdgeInsets.only(top: 10.0)),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pushReplacement(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return HomeUsers();
                      //     }));
                      //   },
                      //   child: const Text(
                      //     "Login User",
                      //     style: TextStyle(fontSize: 18),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     minimumSize: const Size.fromHeight(50),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(50),
                      //     ),
                      //   ),
                      // ),
                      // const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      ElevatedButton(
                        onPressed: loginIndikator
                            ? null
                            : () {
                                pengecekanLogin();
                              },
                        child: Text(
                          loginIndikator == true ? "Proses...." : "Login",
                          style: const TextStyle(fontSize: 18),
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
