import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';

class ImageUtils{
  static Future<CroppedFile?> pickMedia({
    required bool? isGallery,
    Future<CroppedFile> Function(CroppedFile file)? cropImage,
  })async{
    final source=isGallery!?ImageSource.gallery:ImageSource.camera;
    final pickedFile=await ImagePicker().pickImage(source: source);
    //final pickedVideoFile=await ImagePicker().getVideo(source: source);

    if(pickedFile==null) return null;
    //return File(pickedVideoFile!.path);
    if(cropImage==null){
      
      return CroppedFile(pickedFile.path);
    }else{
      final file=CroppedFile(pickedFile.path);
      return cropImage(file);
    }
  }
  static Future<XFile?> uploadImage({double ratioX=1.0,double ratioY=1.0}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    XFile? xFile;
    if (pickedFile != null) {
      await cropCustomImage(pickedFile,ratioX: ratioX,ratioY: ratioY).then((value) {
        xFile=value!;
      });
      /*setState(() {
        _pickedFile = pickedFile;
      });*/

    }
    return xFile;
  }

  static Future<XFile?> cropCustomImage(XFile imageFile,{double ratioX=1.0,double ratioY=1.0}) async {
    final sizeInicial=File(imageFile.path).lengthSync()/1024;
    final compressQuality=sizeInicial>512?(512/sizeInicial*100).round():100;
    final croppedFile=await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      cropStyle: CropStyle.rectangle,
      aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
      //aspectRatio: CropAspectRatio(ratioX: 21.59, ratioY: 27.94),
      aspectRatioPresets: [CropAspectRatioPreset.square,CropAspectRatioPreset.ratio5x4],
      
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Recortar imagén",
          toolbarColor: ColorsDefault.colorBackgroud,
          toolbarWidgetColor:ColorsDefault.colorText,
          backgroundColor: ColorsDefault.colorBackgroud,
          cropFrameColor: ColorsDefault.colorPrimary,
          activeControlsWidgetColor: Colors.amber,
          cropGridRowCount: 1,
          cropGridColumnCount: 1,
          cropGridStrokeWidth: 1,
          dimmedLayerColor: ColorsDefault.colorBackgroud,
          statusBarColor: Colors.grey.shade500,
          showCropGrid: true,
          hideBottomControls: true,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
          cropGridColor: ColorsDefault.colorPrimary,
          
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
      /*androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Recortar imagén",
        toolbarColor: Colors.white,
        toolbarWidgetColor:Colors.black,
        lockAspectRatio: false
      ),*/
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: compressQuality,
    );
    final XFile file=XFile(croppedFile!.path);
    print("size final ------------------ ${File(croppedFile.path).lengthSync()/1024}");
    return file;
  }
}