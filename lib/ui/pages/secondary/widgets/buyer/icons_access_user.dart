import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_base.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/buyer/container_ubication_property_map.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../domain/usecases/property/usecase_property.dart';
import '../../../../provider/home/properties_provider.dart';
import '../../../utils/share_property_pdf.dart';
import 'package:url_launcher/link.dart';
class IconsAccesUser extends StatefulWidget {
  const IconsAccesUser({Key? key,required this.propertyTotal}) : super(key: key);
  final PropertyTotal propertyTotal;
  @override
  _IconsAccesUserState createState() => _IconsAccesUserState();
}

class _IconsAccesUserState extends State<IconsAccesUser> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  bool vertical=true;
  double height=0.0;
  double width=0.0;
  bool isContacto=false;
  bool isLinks=false;
  ScrollController? scrollController=ScrollController(initialScrollOffset:0);
  UseCaseProperty useCaseInmueble=UseCaseProperty();
  UseCasePropertyBase useCaseInmuebleBase=UseCasePropertyBase();
  bool isVertical=true;
  double _sizeIcon=25*SizeDefault.scaleWidth;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      width=48*5*SizeDefault.scaleWidth;
      if(isContacto){
        width+=48*3*SizeDefault.scaleWidth;
      }
      if(isLinks){
        width+=48*3*SizeDefault.scaleWidth;
      }
      if(width>MediaQuery.of(context).size.width){
        width=MediaQuery.of(context).size.width;
      }
      isVertical=true;
    }else{
      width=47*5*SizeDefault.scaleWidth;
      if(isContacto){
        width+=47*3*SizeDefault.scaleWidth;
      }
      if(isLinks){
        width+=47*3*SizeDefault.scaleWidth;
      }
      if(width>MediaQuery.of(context).size.width*1.9){
        width=MediaQuery.of(context).size.width*1.9;
      }
      isVertical=false;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth),
      margin: isVertical?EdgeInsets.only(top: 5*SizeDefault.scaleWidth,bottom: 0,left: 0,right: 0):EdgeInsets.only(top: 5*SizeDefault.scaleWidth,bottom: 10*SizeDefault.scaleWidth,left: 0,right: 0),
      width: width,
      height: 40*SizeDefault.scaleWidth,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          padding: EdgeInsets.zero,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconAccessItem(
              icon: Icon(Icons.group_work,color: isLinks?ColorsDefault.colorPrimary:ColorsDefault.colorIcon,size: _sizeIcon),
              text: "",
              onTap:(){
                isLinks=!isLinks;
                setState(() {
                  
                });
              }
            ),
            if(isLinks)
            Row(
              children: [
                IconAccessItem(
                  icon: Icon(Icons.web_sharp,color: ColorsDefault.colorIcon,size: _sizeIcon),
                  text: "",
                  onTap:()async{
                    if (!await launchUrl(
                      Uri.parse(widget.propertyTotal.propertyOthers.tourVirtual360Link),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw 'No existe el link';
                    }
                  }
                ),
                IconAccessItem(
                  icon: Icon(Icons.video_collection,color: ColorsDefault.colorIcon,size: _sizeIcon),
                  text: "",
                  onTap:()async{
                    if (!await launchUrl(
                      Uri.parse(widget.propertyTotal.propertyOthers.video2DLink),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw 'No existe el link';
                    }
                  }
                ),
                IconAccessItem(
                  icon: Icon(Icons.video_label,color: ColorsDefault.colorIcon,size: _sizeIcon),
                  text: "",
                  onTap:()async{
                    if (!await launchUrl(
                      Uri.parse(widget.propertyTotal.propertyOthers.videoTour360Link),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw 'No existe el link';
                    }
                  }
                ),
              ],
            ),
            IconAccessItem(icon: Icon(Icons.public,color: ColorsDefault.colorIcon,size: _sizeIcon),
              text: "",
              onTap:()async{
                await fShowModalBottomSheet(
                  context: context, widget: ContainerUbicationPropertyMap()
                );
              }
            ),
            IconAccessItem(
              icon: widget.propertyTotal.userPropertyFavorite.favorite?
              Icon(Icons.favorite,color: ColorsDefault.colorFavorite,size: _sizeIcon)
              :Icon(Icons.favorite_border,color: ColorsDefault.colorIcon,size: _sizeIcon),
              text: "",
              onTap:(){
                context.read<PropertiesProvider>().registerPropertyFavorite(context: context, prefs: _prefs, propertyTotal: widget.propertyTotal,favorite: true);
              }
            ),
            IconAccessItem(
              icon: Icon(Icons.share,color: ColorsDefault.colorIcon,size: _sizeIcon),
              text:"",
              onTap:()async{
                var status=await Permission.storage.request();
                if(status.isGranted){
                  Map<String,dynamic> mapImagenesFile={};
                  List imagenesCategoria=[];
                  for(int i=0;i<widget.propertyTotal.property.mapImages["principales"].length;i++){
                    var datetime=DateTime.now();
                    String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
                    final tempDir=await getTemporaryDirectory();
                    final path='${tempDir.path}/$nameFile.jpg';
                    await Dio().download(widget.propertyTotal.property.mapImages["principales"][i], path);
                    final imagen = pw.MemoryImage(
                      (await readFileByte(path))
                    );
                    imagenesCategoria.add(imagen);
                  }
                  mapImagenesFile["principales"]=imagenesCategoria;
                  generarPdfImagesMain(widget.propertyTotal,mapImagenesFile)
                  .then((value) {
                    archivoPdf=value;
                    Printing.sharePdf(
                    bytes: archivoPdf!, filename: 'Documento.pdf')
                    .then((completado){
                      if(completado){
                        print("exportado");
                      }
                    });
                  });
                }
              }, 
            ),
            /*IconAccessItem(
              icon: Icon(Icons.download,color: ColorsDefault.colorIcon,size: _sizeIcon),
              text: "",
              onTap:()async{
                var status=await Permission.storage.request();
                if(status.isGranted){
                  for(int i=0;i<widget.propertyTotal.property.imagesCategories.length;i++){
                    for(int j=0;j<widget.propertyTotal.property.imagesCategories[i].length;j++){
                      var response=await Dio().get(widget.propertyTotal.property.imagesCategories[i][j],options: Options(
                        responseType: ResponseType.bytes
                      ));
                      
                      var datetime=DateTime.now();
                      String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
                      //print(nameFile);
                      final result= await ImageGallerySaver.saveImage(
                        Uint8List.fromList(response.data),
                        quality: 60,
                        name:nameFile
                      );
                      print(result);
                    }
                  }
                }
              }
            ),*/
            IconAccessItem(
              icon: Icon(Icons.person,color: isContacto?ColorsDefault.colorPrimary:ColorsDefault.colorIcon,size: _sizeIcon),
              text: "",
              onTap:(){
                isContacto=!isContacto;
                setState(() {
                  if(isContacto)
                    scrollController!.animateTo(width, duration: Duration(milliseconds: 100), curve: Curves.linear);
                  else
                    scrollController!.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.linear);
                });
              }
            ),
            if(isContacto)
            Row(
              children:[
                IconAccessItem(
                  icon: Icon(Icons.view_agenda,color: ColorsDefault.colorIcon,size: _sizeIcon),
                  text: "",
                  onTap:(){
                  }
                ),
                
                Link(
                  uri: Uri.parse(
                      "https://wa.me/${widget.propertyTotal.propertyOthers.contactLink}?text=hola"),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return IconAccessItem(
                        icon: iconc.FaIcon(iconc.FontAwesomeIcons.whatsapp,color: ColorsDefault.colorIcon,size: _sizeIcon,),
                        text: "",
                        onTap: openLink!
                      );
                  },
                ),
                IconAccessItem(
                  icon: Icon(Icons.phone,color: ColorsDefault.colorIcon,size: _sizeIcon),
                  text: "",
                  onTap:()async{
                    /*String number ="+59175779842"; //set the number here
                                        await FlutterPhoneDirectCaller.callNumber(number);*/
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: "+59175779842",
                    );
                    await launchUrl(launchUri);
                  }
                ),
              ]
            ),
          ],
        ),
    );
  }
}
class IconAccessItem extends StatefulWidget {
  IconAccessItem({Key? key,required this.icon,required this.text,required this.onTap}) : super(key: key);
  final Widget icon;
  final String text;
  final VoidCallback onTap;
  @override
  _IconAccessItemState createState() => _IconAccessItemState();
}

class _IconAccessItemState extends State<IconAccessItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight:Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
      ),

      splashColor: ColorsDefault.colorSplashListTile,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2*SizeDefault.scaleWidth),
        width: widget.text.length>0?40*SizeDefault.scaleWidth:40*SizeDefault.scaleWidth,
        height: 40*SizeDefault.scaleWidth,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight:Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            Text(widget.text,
              style: TextStyle(
                color: ColorsDefault.colorIcon,
                fontWeight:FontWeight.bold
              ),
            )
          ]
        )
      ),
      onTap: 
        widget.onTap
    );
  }
}
