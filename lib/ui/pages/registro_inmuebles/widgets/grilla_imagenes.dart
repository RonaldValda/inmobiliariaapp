import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/operaciones_imagenes.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:provider/provider.dart';
import 'package:image_cropper/image_cropper.dart';
class GrillaImagenes extends StatefulWidget {
  GrillaImagenes({Key? key,required this.uploading,required this.imagenes,required this.clave}) : super(key: key);
  final bool uploading;
  final List<dynamic> imagenes;
  final String clave;
  @override
  _GrillaImagenesState createState() => _GrillaImagenesState();
}

class _GrillaImagenesState extends State<GrillaImagenes> {
  bool exterioresSeleccionado=false;
  double widthImagen=0;
  double marginImagen=0;
  bool modoVertical=true;
  bool isGallery=true;
  
  Map<String,dynamic> buscarPrincipal(List<dynamic> imagenes,dynamic link){
    Map<String,dynamic> mapResultado={
      "principal":false,
      "index_elemento":-1
    };
    for(int i=0;i<imagenes.length;i++){
      if(imagenes[i] is File){
        //print("es archivo $i");
      }
      //print(link);
      if(imagenes[i].toString()==link.toString()){
        //print("object ${imagenes[i]}");
        mapResultado["principal"]=true;
        mapResultado["index_elemento"]=i;
        return mapResultado;
      }
    }
    return mapResultado;
  }

  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    widthImagen=MediaQuery.of(context).size.width/2;
    marginImagen=5;
    modoVertical=MediaQuery.of(context).size.height>MediaQuery.of(context).size.width?true:false;
    
    return GridView.builder(
      itemCount: widget.imagenes.length+1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: modoVertical?2:4),
      itemBuilder: (context,index){
        return 
            Container(
              padding: EdgeInsets.all(0),
              child: Column(
                verticalDirection: VerticalDirection.down,
                children:<Widget>[

                  //IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                  index==0?
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(marginImagen),
                      color: Colors.grey,
                      width: widthImagen,
                      height: widthImagen,
                      //height: MediaQuery.of(context).size.width/3-10,
                      child: IconButton(
                        onPressed: onPressed,
                        /*if(!widget.uploading) {
                          dynamic imagen;
                          imagen=await chooseImage(imagen);
                          widget.imagenes.add(imagen);
                          setState(() {
                            
                          });
                          uploadImagen(imagen).then((value){
                            Map<String,dynamic> map=buscarPrincipal(widget.imagenes, imagen);
                            if(map["index_elemento"]>=0){
                              widget.imagenes.replaceRange(map["index_elemento"],map["index_elemento"]+1,[value.toString()]);
                            }
                          }).whenComplete(() {
                            setState(() {
                              
                            });
                          });
                        }*/
                        
                       icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 60,
                        )),
                    ),
                  ):                
                  Expanded(
                    child: InkWell(
                      onLongPress: (){
                        setState(() {
                          exterioresSeleccionado=true;
                        });
                      },
                      onTap:(){
                        setState(() {
                          exterioresSeleccionado=false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        
                        width: widthImagen,
                        height: widthImagen,
                        //height: MediaQuery.of(context).size.width/3-10,
                        margin: EdgeInsets.all(marginImagen),
                        decoration: (widget.imagenes[index-1] is File)?BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(widget.imagenes[index-1] as File),
                            //image:(_image[index] is String)? (NetworkImage(_image[index].toString())):FileImage(_image[index] as File),
                            fit: BoxFit.cover
                          ),
                        )
                        :BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.imagenes[index-1] as String),
                            //image:(_image[index] is String)? (NetworkImage(_image[index].toString())):FileImage(_image[index] as File),
                            fit: BoxFit.cover
                          ),
                        ),
                             
                        child:  exterioresSeleccionado?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                color: Colors.white.withOpacity(0.5),
                                width: widthImagen,
                                height:30,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Imagen principal",
                                    ),
                                    buscarPrincipal(inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes["principales"],widget.imagenes[index-1])["principal"]?
                                      Icon(Icons.check,color: Colors.black,):
                                      Icon(Icons.close,color: Colors.black,)
                                  ],
                                ),
                                
                              ),
                              onTap: (){
                                if(buscarPrincipal(inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes["principales"],widget.imagenes[index-1].toString())["principal"]){
                                  inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes["principales"].removeWhere((element)=>element.toString()==widget.imagenes[index-1].toString());
                                }else{
                                  inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes["principales"].add(widget.imagenes[index-1]);
                                }
                                setState(() {
                                  
                                });
                              },
                            ),
                            Container(
                              color: Colors.white.withOpacity(0.5),
                              width:30,
                              height:30,
                              child:  Container(
                                color: Colors.white.withOpacity(0.5),
                                width:30,
                                height:30,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: (){
                                    borrarImage(widget.imagenes,index-1);
                                    setState(() {
                                      
                                    });
                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                              ),
                            ),
                          ],
                        ):Container(),
                      ),
                    ),
                  )
              ]),
            );
      }
    );
  }

  void onPressed() async{
    final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );
    if(file==null) return;
    setState(() {
      widget.imagenes.add(file); 
    });
    uploadImagen(file).then((value){
      Map<String,dynamic> map=buscarPrincipal(widget.imagenes, file);
      if(map["index_elemento"]>=0){
        widget.imagenes.replaceRange(map["index_elemento"],map["index_elemento"]+1,[value.toString()]);
      }
    }).whenComplete(() {
      setState(() {
        
      });
    });
  }

  Future<File> cropSquareImage(File imageFile) async {
   final file=await ImageCropper.cropImage(
    sourcePath: imageFile.path,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    aspectRatioPresets: [CropAspectRatioPreset.square]
   );
   return file!;
  }
  
}
Future<File> cropCustomImage(File imageFile) async {
  final file=await ImageCropper.cropImage(
  sourcePath: imageFile.path,
  aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  aspectRatioPresets: [CropAspectRatioPreset.square,CropAspectRatioPreset.ratio16x9],
  androidUiSettings: AndroidUiSettings(
    toolbarTitle: "Recortar imagén",
    toolbarColor: Colors.white,
    toolbarWidgetColor:Colors.black,
    lockAspectRatio: false
  ),
  compressFormat: ImageCompressFormat.jpg,
  compressQuality: 70,
  
  );
  AndroidUiSettings androidUiSettings()=>AndroidUiSettings(
    toolbarTitle: "Recortar imagén",
    toolbarColor: Colors.white,
    toolbarWidgetColor:Colors.black,
    lockAspectRatio: true,
  
  );
  return file!;
}
class ImageUtils{
  static Future<File?> pickMedia({
    @required bool? isGallery,
    Future<File> Function(File file)? cropImage,
  })async{
    final source=isGallery!?ImageSource.gallery:ImageSource.camera;
    final pickedFile=await ImagePicker().getImage(source: source);
    //final pickedVideoFile=await ImagePicker().getVideo(source: source);

    if(pickedFile==null) return null;
    //return File(pickedVideoFile!.path);
    if(cropImage==null){
      return File(pickedFile.path);
    }else{
      final file=File(pickedFile.path);
      return cropImage(file);
    }
  }
}