import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

  final picker=ImagePicker();
/*Future<PickedFile> chooseImage() async{
    final pickedFile=await picker.getImage(source: ImageSource.gallery);
      
    // ignore: unnecessary_null_comparison
    //if(pickedFile!.path == null) retrieveLostData(categoria);
    return pickedFile!;
  } 
  Future<LostData> retrieveLostData() async{
    final LostData response=await picker.getLostData();
    return response;
  }*/

  chooseImage(dynamic imagen) async{
    final pickedFile=await picker.getImage(source: ImageSource.gallery);
    imagen=File(pickedFile!.path);
    
    //imagenes.add(File(pickedFile!.path));
    //print("primero");
    // ignore: unnecessary_null_comparison
    
    if(pickedFile.path == null) retrieveLostData(imagen);
    return imagen;
  } 
  Future<void> retrieveLostData(dynamic imagen) async{
    final LostData response=await picker.getLostData();
    if(response.isEmpty){
      return;
    }
    if(response.file!=null){
      imagen=File(response.file!.path);
      //imagenes.add(File(response.file!.path));
      print("hola");
    }else{
      print(response.file);
    }
  }
  borrarImage(List<dynamic> imagenes,index){
      /*if(_image[index] is String){
      _imagenesEliminar.add(_image[index] as String);
      }*/
      imagenes.removeAt(index);

  }
  Future<dynamic> uploadImagen(dynamic imagen) async{
  dynamic linkImagen;
  firebase_storage.Reference? ref;
      // ignore: unnecessary_cast
      ref=firebase_storage.FirebaseStorage.instance.ref().child('images/${(imagen as File).path}');
      await ref.putFile(imagen).whenComplete(() async{
        await ref!.getDownloadURL().then((value) {
          //img=value;
          linkImagen=value;
          //imagenesRegistrar.add(value);
        });
      });
  
  print(await ref.listAll());
  //print("lista de imagenes $linksImagenes");
  return linkImagen;
}