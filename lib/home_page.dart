import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnectedInternet = false;
  StreamSubscription? _internetConnectionStreamSubscription;

  @override
void initState() {
    _internetConnectionStreamSubscription
    =InternetConnection().onStatusChange.listen((event){
      print(event);
    switch(event){
      case InternetStatus.connected:
        setState(() {
          isConnectedInternet = true;
        });
        break;
      case InternetStatus.disconnected:
        setState(() {
          isConnectedInternet = false;
        });
       break;
      default:
        setState(() {
          isConnectedInternet = false;
        });
    }
    });
    super.initState();
  }
  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isConnectedInternet? Icons.wifi  : Icons.wifi_off , size:50,color: Colors.red,),
            Text(isConnectedInternet?"Internet connected" : "No internet connection")
          ],
        ),
      ),
    );
  }
}
