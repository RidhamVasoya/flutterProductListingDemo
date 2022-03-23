import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'https://reqres.in/api/';

  static const String users='users';
}

class ApiService {
  static Future<dynamic> callGetAPI(String url) async {
    log('Api:- ' + URLS.BASE_URL + url);

    final response = await http.get(Uri.parse(URLS.BASE_URL + url));

    log('Response:- ' + response.body.toString());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static void dialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Internet needed!'),
        content: const Text(
          'You may want to exit the app here',
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('EXIT'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
