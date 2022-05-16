import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Data>> fetchData() async {
  const url =
      'http://192.168.100.19/APIs/flutter_php_mysql_crud_shajedul/read.php';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String address;

  Data({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
