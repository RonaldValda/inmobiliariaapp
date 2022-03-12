import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
class ContainerImagenBanco extends StatefulWidget {
  ContainerImagenBanco({Key? key,required this.imagenLogo}) : super(key: key);
  final List<dynamic> imagenLogo;
  @override
  _ContainerImagenBancoState createState() => _ContainerImagenBancoState();
}

class _ContainerImagenBancoState extends State<ContainerImagenBanco> {
  bool uploading=false;
  final picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          (widget.imagenLogo[0] is File)?Container(
                alignment: Alignment.bottomLeft,
                height: MediaQuery.of(context).size.width/3,
                width:MediaQuery.of(context).size.width/3,
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(widget.imagenLogo[0] as File),
                    //image:(_image[index] is String)? (NetworkImage(_image[index].toString())):FileImage(_image[index] as File),
                    fit: BoxFit.fill
                  ),
                ),
              )
          :
          (widget.imagenLogo[0] as String)!=""?Container(
            height: MediaQuery.of(context).size.width/3,
            width:MediaQuery.of(context).size.width/3,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.3),
              image: DecorationImage(
                image: NetworkImage(widget.imagenLogo[0] as String),
                fit: BoxFit.fitHeight,
                scale: 1.5
              )
            ),
          ):Container(
            height: MediaQuery.of(context).size.width/3,
            width:MediaQuery.of(context).size.width/3,
            color: Colors.grey.withOpacity(.3),
          ),
          ElevatedButton(
            onPressed: (){
              //widget.urlComprobantePago.toUpperCase();
              if(!uploading) chooseImage();
            }, 
            child: Text("Subir logo")
          )
        ],
      )
    );
  }
  chooseImage() async{
    final pickedFile=await picker.getImage(source: ImageSource.gallery);
    setState(() {
      widget.imagenLogo.removeAt(0);
      widget.imagenLogo.add(File(pickedFile!.path));
      print(widget.imagenLogo[0]);
    });
    // ignore: unnecessary_null_comparison
    if(pickedFile!.path == null) retrieveLostData();
  }
  Future<void> retrieveLostData() async{
    final LostData response=await picker.getLostData();
    if(response.isEmpty){
      return;
    }
    if(response.file!=null){
      setState((){
        widget.imagenLogo.removeAt(0);
        widget.imagenLogo.add(File(response.file!.path));
        //_image.add(File(response.file!.path));
      });
    }else{
      print(response.file);
    }
  }
}