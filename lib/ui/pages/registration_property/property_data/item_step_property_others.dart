import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/f_list_tile_switch.dart';
class ItemStepPropertyOthers extends StatefulWidget {
  ItemStepPropertyOthers({Key? key
  }) : super(key: key);
  
  @override
  _ItemStepPropertyOthersState createState() => _ItemStepPropertyOthersState();
}

class _ItemStepPropertyOthersState extends State<ItemStepPropertyOthers> {
  TextEditingController? _controllerVideo2D;
  TextEditingController? _controllerTourVirtual360;
  TextEditingController? _controllerVideoTour360;
  TextEditingController? _controllerOthersDetails;
  TextEditingController? _controllerContactNumber;
  TextEditingController? _controllerContactLink;
  TextEditingController? _controllerPlatformCitesLink;
  @override
  void initState() {
    super.initState();
  }
  void _initControllers(PropertyOthers propertyOthers){
    if(_controllerVideo2D==null){
      _controllerVideo2D=TextEditingController(text: propertyOthers.video2DLink);
      _controllerTourVirtual360=TextEditingController(text: propertyOthers.tourVirtual360Link);
      _controllerVideoTour360=TextEditingController(text: propertyOthers.videoTour360Link);
      _controllerOthersDetails=TextEditingController(text: propertyOthers.othersDetails);
      _controllerContactNumber=TextEditingController(text: propertyOthers.contactNumber.toString());
      _controllerContactLink=TextEditingController(text: propertyOthers.contactLink);
      _controllerPlatformCitesLink=TextEditingController(text: propertyOthers.platformCitesLink);
    }
  }
  @override
  Widget build(BuildContext context) {
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final propertyOthers=registrationPropertyProvider.propertyTotalCopy.propertyOthers;
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    _initControllers(propertyOthers);
    final sizedBox=SizedBox(height:7*SizeDefault.scaleHeight);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
      color: ColorsDefault.colorBackgroud,
      child: Column(
          children: [
            Expanded(child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height:10*SizeDefault.scaleHeight),
                FListTileSwitch(
                  title: "Remates judiciales", 
                  value: propertyOthers.judicialAuctions, 
                  onChanged: (bool value){
                    propertyOthers.judicialAuctions=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerVideo2D!, 
                  labelText: "Vídeo 2D (Link)", 
                  enabled: property.category.toUpperCase()=="PRO360",
                  onChanged: (x){
                    propertyOthers.video2DLink=x;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerTourVirtual360!, 
                  labelText: "Tour virtual 360 (Link)", 
                  enabled: property.category.toUpperCase()=="PRO360",
                  onChanged: (x){
                    propertyOthers.tourVirtual360Link=x;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerVideoTour360!, 
                  labelText: "Vídeo tour 360 (Link)", 
                  enabled: property.category.toUpperCase()=="PRO360",
                  onChanged: (x){
                    propertyOthers.videoTour360Link=x;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerContactNumber!, 
                  labelText: "Número de contacto", 
                  onChanged: (x){
                    propertyOthers.contactNumber=x!=""?int.parse(x):0;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerContactLink!, 
                  labelText: "Contacto (Link)", 
                  enabled: property.category.toUpperCase()!="GRATUITO",
                  onChanged: (x){
                    propertyOthers.contactLink=x;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerPlatformCitesLink!, 
                  labelText: "Plataforma de citas (Link)", 
                  enabled: property.category.toUpperCase()=="PRO360",
                  onChanged: (x){
                    propertyOthers.platformCitesLink=x;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerOthersDetails!, 
                  labelText: "Detalles", 
                  onChanged: (x){
                    propertyOthers.othersDetails=x;
                  }
                ),
              ],
            ),)
          ],
      ),
    );
  }
}