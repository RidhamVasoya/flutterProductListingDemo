import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/user_model.dart';
import '../model/Contact.dart';
import 'package:http/http.dart' as http;

import '../rest_api.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

List<UserData> contactList = [];

class _FirstState extends State<First> {
  bool isDescending = false;

  @override
  void initState() {
    super.initState();
    getContactList(context, '1');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.blue[100],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
              child: TextButton(
                onPressed: () => setState(() => isDescending = !isDescending),
                child: Row(
                  children: <Widget>[
                    Text(
                      "All",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            contactList.isNotEmpty
                ? Expanded(child: buildList())
                : const Center(
                    child: CircularProgressIndicator(
                        color: Colors.blue, strokeWidth: 2),
                  ),
          ],
        ),
      );

  Widget buildList() => ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (context, index) {
        final sortedItems = contactList
          ..sort((item1, item2) => isDescending
              ? (item2.firstName!).compareTo(item1.firstName!)
              : (item1.firstName!).compareTo(item2.firstName!));
        final item = sortedItems[index];
        return Card(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5.0),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            tileColor: Colors.white,
            leading: CircleAvatar(
                radius: 28, backgroundImage: NetworkImage(item.avatar!)),
            title: Text(item.firstName! + ' ' + item.lastName!),
            onTap: () {
              //  Navigator.pop(context);
              _showDialog(text: 'Index $index');
            },
          ),
        );
      });

  void _showDialog({required String text}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            // overflow: Overflow.visible,
            clipBehavior: Clip.antiAlias,
            //alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 180,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/grass.jpeg',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      child: Text("Ann Lovefully"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                          "Designer,cat lover,bookworm,apple pie fanatic\n                        and nature enthusiast:)"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0,bottom: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on_sharp,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text('Hungary'),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.mail,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text('Send E-mail'),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Container(color: Colors.black26,),
                      height: 1.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container(alignment:Alignment.center,child: Column(
                            children: [
                              Text('8100'),
                              Text("Followers"),
                            ],
                          ))),
                          Container(
                            width: 1,
                            height: 70,
                            color: Colors.black26,
                          ),
                          Expanded(child: Container(alignment:Alignment.center,child: Column(
                            children: [
                              Text('8100'),
                              Text("Following"),
                            ],
                          ))),
                        ]),
                    Container(
                      height: 57,
                      width: 300,
                      child: RaisedButton(
                          child: Text(
                            "Follow",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //elevation: 6.0,
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) => ()));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          color: Colors.green[300]),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 130,
                left: 100,
                child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                      child: Image.asset('assets/images/profile.jpeg')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getContactList(BuildContext context, String pageNo) async {
    var url = URLS.users + '?page=$pageNo';
    await ApiService.callGetAPI(url).then((response) async {
      var contacts = UserModel.fromJson(jsonDecode(jsonEncode(response)));

      if (contacts.data != null) {
        setState(() {
          contactList.clear();
          contactList.addAll(contacts.data!);
        });
      } else {
        await showDialog(
          builder: (context) => AlertDialog(
            title: Text(response),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ],
          ),
          context: context,
        );
      }
    });
  }
}
