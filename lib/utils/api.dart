import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

// mengambil seluruh data ruang
Future<List> getDataRuang() async {
  final response = await http.get(Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_view.php?apicall=get_ruang'));
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
      'https://project.mis.pens.ac.id/mis142/API/api_view.php?apicall=get_status'));
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["result"];

  if (response.statusCode == 200) {
    // print(data);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

// mengambil seluruh data pemesanan
Future<List> getDataPesanan() async {
  final response = await http.get(Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_view.php?apicall=get_pesanan'));
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["result"];

  if (response.statusCode == 200) {
    // print(data);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

// membuat data status baru
void createDataStatus(status) {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_insert.php?apicall=create_status');
  http.post(url, body: {
    "status": status,
  });
}

// membuat data ruang baru
void createDataRuang(
    ruang, keterangan, informasi, tanggalAwalOff, tanggalAkhirOff, kode) async {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_insert.php?apicall=create_ruang');
  http.post(url, body: {
    "ruang": ruang,
    "keterangan": keterangan,
    "informasi": informasi,
    "tanggalAwalOff": tanggalAwalOff,
    "tanggalAkhirOff": tanggalAkhirOff,
    "kode": kode,
  });
}

// membuat data pesanan
void createDataPesanan(judul, ruang, deskripsi, waktuMulai, waktuSelesai, nomor,
    statusDokumen, statusTerimaDokumen, peminjam, waktuPinjam, status) async {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_insert.php?apicall=create_pesanan');
  http.post(url, body: {
    "judul": judul,
    "ruang": ruang,
    "deskripsi": deskripsi,
    "waktuMulai": waktuMulai,
    "waktuSelesai": waktuSelesai,
    "nomor": nomor,
    "statusDokumen": statusDokumen,
    "statusTerimaDokumen": statusTerimaDokumen,
    "peminjam": peminjam,
    "waktuPinjam": waktuPinjam,
    "status": status,
  });
}

// update data pesanan
void updateDataPesanan(
    nomor,
    judul,
    ruang,
    deskripsi,
    waktuMulai,
    waktuSelesai,
    nomorHp,
    statusDokumen,
    statusTerimaDokumen,
    peminjam,
    waktuPinjam,
    status) async {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_update.php?apicall=update_pesanan');
  http.post(url, body: {
    "nomor": nomor,
    "judul": judul,
    "ruang": ruang,
    "deskripsi": deskripsi,
    "waktuMulai": waktuMulai,
    "waktuSelesai": waktuSelesai,
    "nomorHp": nomorHp,
    "statusDokumen": statusDokumen,
    "statusTerimaDokumen": statusTerimaDokumen,
    "peminjam": peminjam,
    "waktuPinjam": waktuPinjam,
    "status": status,
  });
}

// acc data pesanan
void accDataPesanan(
    nomor, petugas, waktuVerifikasi, status, statusTerimaDokumen) async {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_update.php?apicall=acc_pesanan');
  http.post(url, body: {
    "nomor": nomor,
    "petugas": petugas,
    "waktuVerifikasi": waktuVerifikasi,
    "status": status,
    "statusTerimaDokumen": statusTerimaDokumen,
  });
}

// mengupdate data status
void updateDataStatus(nomor, status) {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_update.php?apicall=update_status');
  http.post(url, body: {
    "nomor": nomor,
    "status": status,
  });
}

// mengupdate data ruang
void updateDataRuang(nomor, ruang, keterangan, informasi, tanggalAwalOff,
    tanggalAkhirOff, kode) {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_update.php?apicall=update_ruang');
  http.post(url, body: {
    "nomor": nomor,
    "ruang": ruang,
    "keterangan": keterangan,
    "informasi": informasi,
    "tanggalAwalOff": tanggalAwalOff,
    "tanggalAkhirOff": tanggalAkhirOff,
    "kode": kode,
  });
}

// menghapus data status
void deleteDataStatus(nomor) {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_delete.php?apicall=delete_status&nomor=${nomor}');
  http.delete(url);
}

// menghapus data ruang
void deleteDataRuang(nomor) {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_delete.php?apicall=delete_ruang&nomor=${nomor}');
  http.delete(url);
}

// menghapus data pesanan
void deleteDataPesanan(nomor) {
  var url = Uri.parse(
      'https://project.mis.pens.ac.id/mis142/API/api_delete.php?apicall=delete_pesanan&nomor=${nomor}');
  http.delete(url);
}

// pengecekan login aplikasi
Future<Map<String, dynamic>> authUsers() async {
  Map<String, dynamic> map;
  var url = Uri.parse('https://project.mis.pens.ac.id/mis142/API/api_auth.php');
  final response = await http.post(url, body: {
    "username": "fikriaidin98@it.student.pens.ac.id",
    "password": "rahasia",
  });
  response.body != "auth error" ? map = json.decode(response.body) : map = {};
  return map;
}
