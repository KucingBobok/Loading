import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var title = "";
  double progress = 0;
  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Hello HTTP!")),
        body: Column(children: [
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  progress = 10;
                });
                var data = await fetchAlbum();
                json.decode(data.body);
                var dataJson = json.decode(data.body);
                setState(() {
                  progress = 0;
                  title = dataJson["title"];
                });
                //#print(dataJson["title"]);//
              },
              child: const Text("Ambil Data")),
          Text(title),
          CircularProgressIndicator(
            value: progress,
          )
        ]));
  }
}
