import 'package:flutter/material.dart';
import 'package:flutter_php_mysql_crud_shajedul/main.dart';
import 'package:http/http.dart' as http;

class AddEditPage extends StatefulWidget {
  final int? index;
  final id;
  final firstName;
  final lastName;
  final phone;
  final address;

  const AddEditPage({
    Key? key,
    required this.index,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  }) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phone;
  late TextEditingController address;

  bool editMode = false;

  addUpdateData() async {
    if (editMode) {
      var url = 'http://sue_ip/APIs/flutter_php_mysql_crud_shajedul/edit.php';
      await http.post(Uri.parse(url), body: {
        'id': widget.id,
        'firstname': firstName.text,
        'lastname': lastName.text,
        'phone': phone.text,
        'address': address.text,
      });
    } else {
      var url = 'http://sue_ip/APIs/flutter_php_mysql_crud_shajedul/add.php';
      await http.post(Uri.parse(url), body: {
        'firstname': firstName.text,
        'lastname': lastName.text,
        'phone': phone.text,
        'address': address.text,
      });
    }
  }

  @override
  void initState() {
    firstName = TextEditingController(text: '');
    lastName = TextEditingController(text: '');
    phone = TextEditingController(text: '');
    address = TextEditingController(text: '');
    if (widget.index != null) {
      editMode = true;
      firstName.text = widget.firstName;
      lastName.text = widget.lastName;
      phone.text = widget.phone;
      address.text = widget.address;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(editMode ? 'Update' : 'Add Data'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: firstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: lastName,
                decoration: const InputDecoration(
                  labelText: 'lastName',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phone,
                decoration: const InputDecoration(
                  labelText: 'phone',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: address,
                decoration: const InputDecoration(
                  labelText: 'address',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addUpdateData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                side: const BorderSide(
                  width: 4,
                  color: Colors.grey,
                ),
              ),
              child: const Text("Save"),
            )
          ],
        ));
  }
}
