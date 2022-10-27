
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

import '../../../../data/services/images_repository.dart';
import '../../../../device/image_utils.dart';
import '../../../common/texts.dart';
class ContainerImagesCategories extends StatefulWidget {
  ContainerImagesCategories({Key? key,required this.keyImage,required this.title}) : super(key: key);
  final String keyImage;
  final String title;
  @override
  _ContainerImagesCategoriesState createState() => _ContainerImagesCategoriesState();
}

class _ContainerImagesCategoriesState extends State<ContainerImagesCategories> {
  bool _activateOptions=false;
  bool modoVertical=true;
  bool isGallery=true;
  bool _loading=true;
  List<bool> _loadingImages=[];
  String _typePlan="";
  int _counterImages=0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List items=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages[widget.keyImage];
      _typePlan=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.category;
      _loadingImages=List.generate(items.length, (index) => false);
      _loading=false;
      setState(() {
        
      });
    });
    super.initState();
  }
  
  bool _isImageMain(List<dynamic> imagenes,dynamic link){
    for(int i=0;i<imagenes.length;i++){
      if(imagenes[i].toString()==link.toString()){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    modoVertical=MediaQuery.of(context).size.height>MediaQuery.of(context).size.width?true:false;
    final mapImages=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages;
    if(_typePlan.toLowerCase()=="gratuito"){
      _counterImages=_counterImagesDistict(mapImages);
    }
    return Container(
      width: double.infinity,
      height: 500*SizeDefault.scaleHeight,
      padding: EdgeInsets.all(7*SizeDefault.scaleWidth),
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroud,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25),),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left:10*SizeDefault.scaleWidth),
                child: TextStandard(
                  text: "${widget.title} ${_typePlan.toLowerCase()=="gratuito"?"($_counterImages de 3 imágenes)":""}", 
                  fontSize: 15*SizeDefault.scaleHeight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FXButton()
            ],
          ),
          SizedBox(height: 15*SizeDefault.scaleHeight,),
          _counterImages>=3
          ?TextStandard(
            text: "Límite de imágenes alcanzado", fontSize: SizeDefault.fSizeStandard,
            color: ColorsDefault.colorTextError,
          ):SizedBox(),
          _loading?SizedBox():_gridView(context),
        ],
      ),
    );
  }

  Widget _gridView(BuildContext context) {
    final List imagesMain=context.watch<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages["principales"];
    final List images=context.watch<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages[widget.keyImage];
    return Expanded(
      child: GridView.builder(
        itemCount: _loadingImages.length+1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: modoVertical?2:4,
          crossAxisSpacing: 5*SizeDefault.scaleWidth,
          mainAxisSpacing: 5*SizeDefault.scaleWidth,
          childAspectRatio: 120/100
        ),
        itemBuilder: (context,index){
          return Container(
            padding: EdgeInsets.all(0),
            child: index==0
            ?_wButtonAdd(images, context)
            :_loadingImages[index-1]?_wLoading():_wImage(images, index, imagesMain)
          );
        }
      ),
    );
  }

  Widget _wLoading(){
    return Container(
      color: ColorsDefault.colorButtonAddImage,
      child: Center(
        child: CupertinoActivityIndicator(
          radius:SizeDefault.radiusCircularIndicator
        )
      ),
    );
  }

  Widget _wImage(List<dynamic> images, int index, List<dynamic> imagesMain) {
    bool inMain=_isImageMain(imagesMain,images[index-1]);
    return InkWell(
        onLongPress: (){
          setState(() {
            _activateOptions=true;
          });
        },
        onTap:(){
          setState(() {
            _activateOptions=false;
          });
        },
        child: Container(
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: ColorsDefault.colorBackgroud,
            border: Border.all(
              width: inMain?3*SizeDefault.scaleHeight:0,
              color: inMain?ColorsDefault.colorPrimary:Colors.transparent
            )
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: images[index-1] as String,
                fit: BoxFit.cover,
              ),
              _activateOptions
              ?Positioned(
                left: 0,
                bottom: 0,
                child: _wButtonDelete(images, index),
              ):SizedBox()
            ],
          ) 
        ),
      );
  }

  Column _actionsImage(List<dynamic> imagesMain, List<dynamic> images, int index) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Container(
                color: Colors.white.withOpacity(0.5),
                height:30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Imagen principal",
                    ),
                    _isImageMain(imagesMain,images[index-1])?
                      Icon(Icons.check,color: Colors.black,):
                      Icon(Icons.close,color: Colors.black,)
                  ],
                ),
                
              ),
              onTap: (){
                if(_isImageMain(imagesMain,images[index-1].toString())){
                  imagesMain.removeWhere((element)=>element.toString()==images[index-1].toString());
                }else{
                  imagesMain.add(images[index-1]);
                }
                setState(() {
                  
                });
              },
            ),
            _wButtonDelete(images, index),
          ],
        );
  }

  Container _wButtonDelete(List<dynamic> images, int index) {
    return Container(
      color: ColorsDefault.colorPrimary,
      width:30,
      height:30,
      child: IconButton(
        padding: EdgeInsets.all(0),
        onPressed: (){
          borrarImage(images,index-1);
          setState(() {
            
          });
      }, icon: Icon(Icons.delete,color: ColorsDefault.colorBackgroud,)),
    );
  }

  Widget _wButtonAdd(List<dynamic> images, BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed(images,context);
      },
      child: Container(
        color: ColorsDefault.colorButtonAddImage,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add,size: 60*SizeDefault.scaleHeight,color:ColorsDefault.colorIcon),
              
            ],
          ),
        ),
      ),
    );
  }

  int _counterImagesDistict(Map<String,dynamic> mapImages){
    int counterImagesDistinct=0;
    mapImages.forEach((key, value) { 
      if(key!="principales"){
        counterImagesDistinct+=int.parse(value.length.toString());
      }
    });
    return counterImagesDistinct;
  }

  void onPressed(List images,BuildContext context) async{
    if(_counterImages<3){
      try{
        final file=await ImageUtils.uploadImage(ratioX: 120,ratioY: 100);
        if(file==null) return;
        setState(() {
          _loadingImages.add(true);
        });
        int lastIndex=_loadingImages.length-1;
        uploadImagen(file).then((urlImage){
          final mapImages=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages;
          mapImages[widget.keyImage].add(urlImage.toString());
          for(int i=0;i<mapImages["principales"].length;i++){
            if(mapImages["principales"][i]==""){
              mapImages["principales"][i]=urlImage.toString();
              break;
            }
          }
          _loadingImages[lastIndex]=false;
          context.read<RegistrationPropertyProvider>().notify();
        });
      }catch(e){
      }
    }
  }
}
/*
Future<CroppedFile?> cropCustomImage(CroppedFile imageFile) async {
  final file=await ImageCropper().cropImage(
  sourcePath: imageFile.path,
  aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  aspectRatioPresets: [CropAspectRatioPreset.square,CropAspectRatioPreset.ratio16x9],
  
  uiSettings: [
    AndroidUiSettings(
        toolbarTitle: "Recortar imagén",
        toolbarColor: Colors.white,
        toolbarWidgetColor:Colors.black,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true),
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
  compressQuality: 70,
  
  );
  return file;
}
*/