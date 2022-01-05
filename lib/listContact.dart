import 'contact.dart';
import 'package:http/http.dart' as http;

Future<List<Contact>> fetchData() async {
  String url =
      "https://61d555622b4f730017a8278b.mockapi.io/contact";
  var client = http.Client();
  var response = await client.get(Uri.parse(url));
  List<Contact> ls = [];
  if (response.statusCode == 200) {
    print('Tai du lieu thanh cong');
    var result = response.body;
    ls = contactFromJson(result);
    print(ls[0].ten);
    return ls;
  } else {
    print('Tai du lieu that bai');
    throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
  }
}
