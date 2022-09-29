import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

// mengambil seluruh data ruang
Future<List> getDataRuang() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=get_ruang'));
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["result"];

  if (response.statusCode == 200) {
    // print(data);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

// mengambil salah satu data ruang
Future<List> getDataOneRuang(id) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=get_one_ruang&id=${id}'));
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["result"];

  if (response.statusCode == 200) {
    // print(data);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

// mengambil seluruh data status
Future<List> getDataStatus() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=get_status'));
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["result"];

  if (response.statusCode == 200) {
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

// mengambil seluruh data pemesanan
Future<List> getDataPemesanan() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=get_pemesanan'));
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["result"];

  if (response.statusCode == 200) {
    Map<String, dynamic> dataPesanan = {};
    for (var i = 0; i < data.length; i++) {
      final response = await http.get(Uri.parse(
          'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=get_one_ruang&id=${data[i]["ruang"]}'));
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> dataRuang = map["result"];

      dataPesanan = {
        'id': data[i]["id"],
        'name': data[i]["name"],
        'nomor': data[i]["nomor"],
        'description': data[i]["description"],
        'date': data[i]["date"],
        'firstTime': data[i]["firstTime"],
        'lastTime': data[i]["lastTime"],
        'ruang': dataRuang[0]["name"],
        'users': data[i]["users"],
        'document': data[i]["document"],
        'status': data[i]["status"],
      };
      print(dataPesanan);
    }

    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

// mengambil salah satu data pemesanan
Future<List> getDataOnePemesanan(id) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=get_one_pemesanan&id=${id}'));
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["result"];

  if (response.statusCode == 200) {
    print(data);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

void createDataStatus(name) {
  var url = Uri.parse(
      'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=create_status');
  http.post(url, body: {
    "name": name,
  });
}

void deleteDataStatus(id) {
  var url = Uri.parse(
      'http://192.168.1.31/pinjam-ruang/api/apiPinjamRuang.php?apicall=delete_status&id=${id}');
  http.delete(url);
}
