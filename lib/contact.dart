// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  Contact({
    this.ten,
    this.sdt,
    this.diachi,
    this.email,
    this.avatar,
    this.ngaysinh,
    this.chan,
    this.yeuthich,
    this.id,
  });

  String ten;
  String sdt;
  String diachi;
  String email;
  String avatar;
  DateTime ngaysinh;
  bool chan;
  bool yeuthich;
  String id;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    ten: json["ten"],
    sdt: json["sdt"],
    diachi: json["diachi"],
    email: json["email"],
    avatar: json["avatar"],
    ngaysinh: DateTime.parse(json["ngaysinh"]),
    chan: json["chan"],
    yeuthich: json["yeuthich"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "ten": ten,
    "sdt": sdt,
    "diachi": diachi,
    "email": email,
    "avatar": avatar,
    "ngaysinh": ngaysinh.toIso8601String(),
    "chan": chan,
    "yeuthich": yeuthich,
    "id": id,
  };
}
