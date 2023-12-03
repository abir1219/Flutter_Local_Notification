
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            if(Platform.isAndroid){
              if(await requestPermission(Permission.notification)==true){
                NotificationService().showNotification(
                    title: "Flutter Notification",
                    body: "This is a testing notification"
                );
              }else{
                NotificationService().showNotification(
                    title: "Flutter Notification",
                    body: "This is a testing notification"
                );
              }
            }

          },
          child: const Text("Show Notification"),
        ),
      ),
    ));
  }

  Future<bool> requestPermission(Permission permissions) async{
    AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
    if(info.version.sdkInt >= 30){
      var req = await Permission.notification.request();
      if(req.isGranted){
        return true;
      }else{
        return false;
      }
    }else{
      if(await permissions.isGranted){
        return true;
      }else{
        var result=await permissions.request();
        if(result.isGranted)
        {
          return true;
        }
        else{
          return false;
        }
      }
    }
  }


}
