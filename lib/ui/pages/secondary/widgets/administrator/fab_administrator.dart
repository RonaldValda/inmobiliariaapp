import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

class FABAdministrator extends StatefulWidget {
  FABAdministrator({Key? key}) : super(key: key);

  @override
  State<FABAdministrator> createState() => _FABAdministratorState();
}

class _FABAdministratorState extends State<FABAdministrator> {
  var isDialOpen = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    
    final propertyTotalLast=context.watch<PropertiesProvider>().propertyTotalLast;
    final property=propertyTotalLast.property;
    return SpeedDial(
      
      icon: Icons.keyboard_double_arrow_up,
      activeIcon: Icons.keyboard_double_arrow_down,
      backgroundColor: ColorsDefault.colorBackgroud,
      foregroundColor: ColorsDefault.colorIcon,

      spacing: 1,
      openCloseDial: isDialOpen,
      childPadding:  EdgeInsets.zero,
      spaceBetweenChildren: 10*SizeDefault.scaleWidth,
      buttonSize: Size(60*SizeDefault.scaleWidth,60*SizeDefault.scaleWidth),
      childrenButtonSize: Size(50*SizeDefault.scaleWidth,50*SizeDefault.scaleWidth),
      visible: true,
      direction: SpeedDialDirection.up,
      childMargin: EdgeInsets.zero,
      switchLabelPosition: false,
      closeManually: false,
      renderOverlay: true,
      overlayColor: Colors.white.withOpacity(0),
      overlayOpacity: 0,
      onOpen: () {},
      onClose: () {},
      useRotationAnimation: true,
      tooltip: 'Más opciones',
      heroTag: 'speed-dial-hero-tag',
      elevation: 2.0,
      animationCurve: Curves.easeInCirc,
      isOpenOnStart: false,
      curve: Curves.easeInCirc,
      animationDuration: const Duration(milliseconds: 500),
      children: [
        _wButtonSDC(
          message: "Dar alta",
          colorIcon: ColorsDefault.colorIcon,
          backgroundColor: ColorsDefault.colorPrimary,
          enabled: property.authorization=="Inactivo"&&property.negotiationStatus!="Vendido",
          assetLink: "assets/icons/icon-likesss.png",
          onTap: (){},
          context: context
        ),
        _wButtonSDC(
          message: "Dar baja",
          colorIcon: ColorsDefault.colorIcon,
          backgroundColor: ColorsDefault.colorPrimary,
          enabled: property.authorization=="Activo"&&property.negotiationStatus!="Vendido",
          assetLink: "assets/icons/icon-dislikessss.png",
          onTap: ()async{
            context.read<RegistrationPropertyProvider>().setPropertyTotalCopy(propertyTotalLast);
          },
          context: context
        ),
        _wButtonSDC(
          message: "Vendido",
          colorIcon: ColorsDefault.colorIcon,
          backgroundColor: ColorsDefault.colorPrimary,
          enabled: property.authorization=="Activo"&&property.negotiationStatus!="Vendido",
          assetLink: "assets/icons/icon-sale.png",
          onTap: ()async{
            
          },
          context: context
        ),
        _wButtonSDC(
          message: "Mantener sólo imágenes principales",
          colorIcon: ColorsDefault.colorIcon,
          backgroundColor: ColorsDefault.colorPrimary,
          enabled: property.negotiationStatus=="Vendido"&&property.authorization=="Activo",
          assetLink: "assets/icons/icon-remove-images.png",
          onTap: ()async{
            context.read<RegistrationPropertyProvider>().setPropertyTotalCopy(propertyTotalLast);
            context.read<RegistrationPropertyProvider>().closeOperationsProperty(context: context);
          },
          context: context
        ),
      ],
    );
  }

  SpeedDialChild _wButtonSDC({required BuildContext context,required String assetLink,Color? backgroundColor,Color? colorIcon,required bool enabled,required Function onTap,required String message}) {
    return SpeedDialChild(
      elevation: 2,
      child: Tooltip(
        message: message,
        child: Container(
          width: 35*SizeDefault.scaleWidth,
          height: 35*SizeDefault.scaleWidth,
          padding: EdgeInsets.all(3*SizeDefault.scaleWidth),
          child: Image.asset(
            assetLink,
            color: enabled?colorIcon??ColorsDefault.colorIcon:ColorsDefault.colorTextDisabled,
            fit: BoxFit.fill,
          ),
        ),
      ),
      backgroundColor: enabled?backgroundColor??ColorsDefault.colorPrimary:ColorsDefault.colorButtonDisabled,
      foregroundColor: ColorsDefault.colorBackgroud,
      onTap: () {
        if(enabled){
          onTap();
        }
        
      },
    );
  }
}