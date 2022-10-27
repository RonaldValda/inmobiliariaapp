import 'package:device_information/device_information.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceInfo{
  static Future<Map<String,dynamic>> initPlatformState(bool mounted) async {
    Map<String,dynamic> map={};
    late String imeiNo = '';
    /*late String platformVersion,
        imeiNo = '',
        modelName = '',
        manufacturer = '',
        deviceName = '',
        productName = '',
        cpuType = '',
        hardware = '';
    var apiLevel;*/
    var status=await Permission.phone.request();
    if(status.isGranted){
      try {
        imeiNo = await DeviceInformation.deviceIMEINumber;
        /*platformVersion = await DeviceInformation.platformVersion;
        modelName = await DeviceInformation.deviceModel;
        manufacturer = await DeviceInformation.deviceManufacturer;
        apiLevel = await DeviceInformation.apiLevel;
        deviceName = await DeviceInformation.deviceName;
        productName = await DeviceInformation.productName;
        cpuType = await DeviceInformation.cpuName;
        hardware = await DeviceInformation.hardware;*/
      } on PlatformException catch (e) {
        print("eroror ${e.message}");
        //platformVersion = '${e.message}';
      }
    }
    
    if (!mounted) return {};
    map["imei_number"]=imeiNo;
    return map;
  }
}