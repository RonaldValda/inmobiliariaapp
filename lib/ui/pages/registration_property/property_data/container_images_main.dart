import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';
class ContainerImagesMain extends StatefulWidget {
  ContainerImagesMain({Key? key}) : super(key: key);

  @override
  State<ContainerImagesMain> createState() => _ContainerImagesMainState();
}

class _ContainerImagesMainState extends State<ContainerImagesMain> {
  List<List<String>> _categories=[["Plantas","plantas"],["Ambientes","ambientes"],["Dormitorios","dormitorios"],["Baños","banios"],
    ["Garaje","garaje"],["Amoblado","amoblado"],["Lavandería","lavanderia"],["Cuarto de lavado","cuarto_lavado"],["Churrasquero","churrasquero"],
    ["Azotea","azotea"],["Condominio privado","condominio_privado"],["Cancha de fútbol, tenis, etc.","cancha"],["Piscina","piscina"],["Sauna","sauna"],
    ["Jacuzzi","jacuzzi"],["Estudio","estudio"],["Jardín","jardin"],["Portón eléctrico","porton_electrico"],
    ["Aire acondicionado","aire_acondicionado"],["Calefacción","calefaccion"],["Ascensor","ascensor"],["Depósito","deposito"],["Sótano","sotano"],
    ["Balcón","balcon"],["Tienda","tienda"],["Amurallado terreno","amurallado_terreno"]];
  int _selectedMainNumber=-1;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600*SizeDefault.scaleHeight,
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
                  text: "Imágenes principales", 
                  fontSize: 18*SizeDefault.scaleHeight,
                  fontWeight: FontWeight.w700,
                  color: ColorsDefault.colorText,
                ),
              ),
              FXButton()
            ],
          ),
          SizedBox(height: 15*SizeDefault.scaleHeight,),
          _wMainImages(context),
          Expanded(
            child:  body()
          )
        ],
      ),
    );
  }
  CustomScrollView body() {
    return CustomScrollView(
      dragStartBehavior: DragStartBehavior.start,
      scrollBehavior: ScrollBehavior(),
      shrinkWrap: true,
      slivers: [
        _wImagesAll(context)
      ],
    );
  }
  Widget _wMainImages(BuildContext context) {
    final List images=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages["principales"];
    return Container(
      margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight,bottom: 20*SizeDefault.scaleHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _wMainImageItem(images[0],0),
          _wMainImageItem(images[1],1),
          _wMainImageItem(images[2],2),
        ],
      ),
    );
  }

  Widget _wMainImageItem(String urlImage,int index){
    return InkWell(
      onLongPress: (){
        setState(() {
          _selectedMainNumber=index;
        });
      },
      onTap: (){
        setState(() {
          _selectedMainNumber=-1;
        });
      },
      child: Container(
        width: 120*SizeDefault.scaleWidth,
        height: 100*SizeDefault.scaleWidth,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorsDefault.colorShadowCardImage,
              blurRadius: 5,
              offset: Offset(0, 4)
            )
          ],
          color: ColorsDefault.colorBackgroud,
          border: Border.all(
            width: 0.5*SizeDefault.scaleHeight,
            color: ColorsDefault.colorBorder
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        child: urlImage!=""
        ?Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: urlImage,
                ),
            ),
            Positioned(
              child: Container(
                width: 120*SizeDefault.scaleWidth,
                height: 100*SizeDefault.scaleWidth,
                decoration: BoxDecoration(
                  color: _selectedMainNumber==index?ColorsDefault.colorBackgroundBarrier:Colors.transparent,
                  borderRadius: BorderRadius.circular(15)
                ),
              )
            ),
            _selectedMainNumber==index
            ?_wNumberImage(index):SizedBox()
          ],
        ):SizedBox(),
      ),
    );
  }

  Center _wNumberImage(int index) {
    return Center(
      child: TextStandard(
        text: "${index+1}", 
        color: ColorsDefault.colorBackgroud.withOpacity(0.7),
        fontWeight: FontWeight.w900,
        fontSize: 50*SizeDefault.scaleHeight
      ),
    );
  }

  Widget _wImagesAll(BuildContext context){
    final Map<String,dynamic> mapImages=context.watch<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages;
    final List imagesMain=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages["principales"];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          List<Widget> children=[];
          final List images=mapImages[_categories[index][1]];
          if(images.length>0){
            children.add(
              Container(
                margin: EdgeInsets.only(top: 6.5*SizeDefault.scaleHeight,bottom: 2.5*SizeDefault.scaleHeight,left: SizeDefault.paddingHorizontalBody),
                width: double.infinity,
                child: TextStandard(
                  text: _categories[index][0],
                  color: ColorsDefault.colorText,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700, 
                  fontSize: 14*SizeDefault.scaleHeight,
                ),
              )
            );
          }
          int j=0;
          while(j<images.length){
            final row=Container(
              margin: EdgeInsets.only(bottom:5*SizeDefault.scaleWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _wImage(context,images[j].toString(),imagesMain),
                  ((j+1)<images.length)
                  ?_wImage(context,images[j+1].toString(),imagesMain)
                  :SizedBox(width: 120*SizeDefault.scaleWidth,),
                  ((j+2)<images.length)
                  ?_wImage(context,images[j+2].toString(),imagesMain)
                  :SizedBox(width: 120*SizeDefault.scaleWidth,),
                ],
              ),
            );
            j=j+3;
            children.add(row);
          }
          return Column(
            children: children,
          );
        },
        childCount: _categories.length
      ),
    );
  }

  Widget _wImage(BuildContext context,String urlImage, List<dynamic> imagesMain) {
    bool inMain=_isImageMain(imagesMain,urlImage);
    int indexMain=-1;
    if(inMain){
      indexMain=imagesMain.lastIndexOf(urlImage);
    }
    return InkWell(
      onTap:(){
        if(_selectedMainNumber>=0){
          imagesMain[_selectedMainNumber]=urlImage;
          _selectedMainNumber=-1;
          context.read<RegistrationPropertyProvider>().notify();
        }
      },
      child: Container(
        width: 120*SizeDefault.scaleWidth,
        height: 100*SizeDefault.scaleWidth,
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
              imageUrl: urlImage,
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Container(
                width: 120*SizeDefault.scaleWidth,
                height: 100*SizeDefault.scaleWidth,
                decoration: BoxDecoration(
                  color: _selectedMainNumber>=0&&indexMain>=0?ColorsDefault.colorBackgroundBarrier:Colors.transparent,
                ),
              )
            ),
            _selectedMainNumber>=0&&indexMain>=0?
            _wNumberImage(indexMain):SizedBox()
          ],
        ) 
        //_actionsImage(imagesMain, images, index)
      ),
    );
  }

  bool _isImageMain(List<dynamic> imagenes,dynamic link){
    for(int i=0;i<imagenes.length;i++){
      if(imagenes[i].toString()==link.toString()){
        return true;
      }
    }
    return false;
  }
}