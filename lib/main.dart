import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_php_mysql_crud_shajedul/repository.dart';
import 'package:http/http.dart' as http;

import 'add_edit_page.dart';

void main() => runApp(const MaterialApp(home: MyHomePage()));

//-------------------------------------------------------------
//Funacionando e não é um clone é uma releitura do video pois algumas partes já estavam obsoletas
// Este projeto utiliza o repósitorio no wampp:
// C:\xampp\htdocs\APIs\flutter_php_mysql_crud_shajedul
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and ListView Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ListView'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEditPage(
                  index: null,
                  id: '',
                  firstName: '',
                  lastName: '',
                  phone: '',
                  address: '',
                ),
              ),
            );
            debugPrint('Clicked FloatingActionButton Button');
          },
        ),
        body: Center(
          child: FutureBuilder<List<Data>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: GestureDetector(
                          child: const Icon(Icons.edit),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditPage(
                                  index: index,
                                  id: data[index].id,
                                  firstName: data[index].firstname,
                                  lastName: data[index].lastname,
                                  phone: data[index].phone,
                                  address: data[index].address,
                                ),
                              ),
                            );
                          },
                        ),
                        title: Text(data[index].firstname),
                        subtitle: Text(data[index].lastname),
                        trailing: GestureDetector(
                          child: const Icon(Icons.delete),
                          onTap: () {
                            setState(() {
                              var url =
                                  'http://seu_ip/APIs/flutter_php_mysql_crud_shajedul/delete.php';
                              http.post(Uri.parse(url), body: {
                                'id': data[index].id,
                              });
                              data.remove(data[index]);
                            });
                            debugPrint('delete Clicked');
                          },
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
