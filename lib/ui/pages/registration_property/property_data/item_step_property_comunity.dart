import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/widgets/f_list_tile_switch.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';
class ItemStepPropertyComunity extends StatefulWidget {
  ItemStepPropertyComunity({Key? key}) : super(key: key);
  @override
  _ItemStepPropertyComunityState createState() => _ItemStepPropertyComunityState();
}

class _ItemStepPropertyComunityState extends State<ItemStepPropertyComunity> {
  TextEditingController? _controllerComunityDetails;
  @override
  void initState() {
    super.initState();
    _controllerComunityDetails=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final propertyCommunity=context.watch<RegistrationPropertyProvider>().propertyTotalCopy.propertyCommunity;
    if(_controllerComunityDetails!.text==""){
      _controllerComunityDetails!.text=propertyCommunity.communityDetails;
    }
    final sizedBox=SizedBox(height:7*SizeDefault.scaleHeight);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
      color: ColorsDefault.colorBackgroud,
      child: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height:10*SizeDefault.scaleHeight),
                  FListTileSwitch(
                    title: "Iglesia", 
                    value: propertyCommunity.church, 
                    onChanged: (bool value){
                      propertyCommunity.church=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Parque infantil", 
                    value: propertyCommunity.playground, 
                    onChanged: (bool value){
                      propertyCommunity.playground=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Escuela", 
                    value: propertyCommunity.school, 
                    onChanged: (bool value){
                      propertyCommunity.school=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Universidad", 
                    value: propertyCommunity.university, 
                    onChanged: (bool value){
                      propertyCommunity.university=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Plazuela", 
                    value: propertyCommunity.smallSquare, 
                    onChanged: (bool value){
                      propertyCommunity.smallSquare=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Módulo policial", 
                    value: propertyCommunity.policeModule, 
                    onChanged: (bool value){
                      propertyCommunity.policeModule=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Sauna / piscina pública", 
                    value: propertyCommunity.publicSaunaPool, 
                    onChanged: (bool value){
                      propertyCommunity.publicSaunaPool=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Gym público", 
                    value: propertyCommunity.publicGym, 
                    onChanged: (bool value){
                      propertyCommunity.publicGym=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Centro deportivo", 
                    value: propertyCommunity.sportCenter, 
                    onChanged: (bool value){
                      propertyCommunity.sportCenter=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Puesto salud", 
                    value: propertyCommunity.postHealth, 
                    onChanged: (bool value){
                      propertyCommunity.postHealth=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FListTileSwitch(
                    title: "Zona comercial", 
                    value: propertyCommunity.shoopingZone, 
                    onChanged: (bool value){
                      propertyCommunity.shoopingZone=value;
                      context.read<RegistrationPropertyProvider>().notify();
                    }
                  ),
                  sizedBox,
                  FTextFieldBasico(
                    controller: _controllerComunityDetails!, 
                    labelText: "Detalles", 
                    onChanged: (x){
                      propertyCommunity.communityDetails=x;
                    }
                  ),
                  SizedBox(height:20*SizeDefault.scaleHeight),
                ],
              ),
            )
          ],
      ),
    );
  }
}