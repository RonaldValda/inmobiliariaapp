
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/registration_property/property_data/dialog_confirm_operation.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';
import '../../../common/buttons.dart';
import '../../../provider/registration_property/registration_property_provider.dart';
import '../../../provider/registration_property/registration_property_widget_provider.dart';
import 'tab_bar_registration_property.dart';
class ScreenRegistrationProperty extends StatefulWidget {
  ScreenRegistrationProperty({Key? key}) : super(key: key);

  @override
  _ScreenRegistrationPropertyState createState() => _ScreenRegistrationPropertyState();
}

class _ScreenRegistrationPropertyState extends State<ScreenRegistrationProperty> {
  bool uploading=false;
  double valorCarga=0.0;
  double porcentajeCarga=0.0;
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RegistrationPropertyProvider>().init();
      context.read<RegistrationPropertyWidgetProvider>().init();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
      ]);
      setState(() {
        _loading=false;
      });
    });
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Registro de inmuebles",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: wBody(context),
    );
  }

  Container wBody(BuildContext context) {
    final widgetProvider=context.watch<RegistrationPropertyWidgetProvider>();
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    final request=registrationPropertyProvider.propertyTotalCopy.administratorRequest;
    if(_loading){
      return Container(
        color: ColorsDefault.colorBackgroud,
        child: Center(
          child: CupertinoActivityIndicator(
            radius: SizeDefault.radiusCircularIndicator,
          ),
        ),
      );
    }
    
    return Container(
      color: ColorsDefault.colorBackgroud,
      child: Column(
        children: [
          if(property.authorization=="Pendiente - Corregir datos")
          Padding(
            padding: EdgeInsets.only(top: 10*SizeDefault.scaleHeight,bottom: 10*SizeDefault.scaleHeight,right: 30*SizeDefault.scaleWidth,left: 30*SizeDefault.scaleWidth),
            child: TextStandard(
              text: request.observations!=""?"${request.observations}":"${request.observationsSuperUser}", 
              fontSize: 12*SizeDefault.scaleWidth,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              color: ColorsDefault.colorTextError,
            ),
          ),
          TabBarRegistrationProperty(),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(child: widgetProvider.wStepItem)
                ],
              ),
            )
          ),
          wButtons(context),
         // wButtonSave(context, inmuebleInfo, usuario, _inmueblesFiltrado, _mapaFiltroOtros)
        ],
      ),
    );
  }

  Container wButtons(BuildContext context) {
    final widgetProvider=context.watch<RegistrationPropertyWidgetProvider>();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 15*SizeDefault.scaleWidth,top: 10*SizeDefault.scaleWidth),
      color: Colors.white,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !widgetProvider.steps[0].selected
          ?SizedBox(
            width: 130*SizeDefault.scaleWidth,
            height: 55*SizeDefault.scaleWidth,
            child: FButtonOutlinedIcon(
              text: "Anterior",
              icon: Icons.arrow_back_ios,
              isBeforeIcon: true,
              onPressed: (){
                widgetProvider.jumpStep(forward: false);
              },
            ),
          ):Container(),
          SizedBox(width: 5*SizeDefault.scaleWidth,),
          !widgetProvider.steps[widgetProvider.steps.length-1].selected
          ?SizedBox(
            width: 130*SizeDefault.scaleWidth,
            height: 55*SizeDefault.scaleWidth,
            child: FButtonOutlinedIcon(
              text: "Siguiente",
              icon: Icons.arrow_forward_ios,
              onPressed: (){
                widgetProvider.jumpStep(forward: true);
              },
            ),
          ):_wButtonsOperations(context),
        ],
      )
    );
  }

  Widget _wButtonsOperations(BuildContext context) {
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    final propertyTotal=registrationPropertyProvider.propertyTotalCopy;
    final property=propertyTotal.property;
    if((property.authorization==""||(property.authorization=="Activo"||property.authorization=="Pendiente - Corregir datos")&&property.negotiationStatus!="Vendido")){
      return SizedBox(
        width: 220*SizeDefault.scaleWidth,
        height: 55*SizeDefault.scaleWidth,
        child: Row(
          children: [
            Expanded(
              child: ButtonPrimary(
                text: property.authorization==""?"Registrar":property.authorization=="Pendiente - Corregir datos"?"Reenviar":"Actualizar",
                onPressed: ()async{
                  bool validatePlan=false;
                  bool validateProperty=false;
                  if(context.read<RegistrationPropertyProvider>().validate()){
                    validateProperty=true;
                    if(property.publicationDate==""){
                      validatePlan=true;
                    }else{
                      if(property.counterUpdate>=property.allowedUpdate){
                        if(context.read<RegistrationPropertyPlanProvider>().validatePaid(context: context)){
                          validatePlan=true;
                        }
                      }else{
                        validatePlan=true;
                      }
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Debe cumplir con todos lo requeridos del inmueble",colorText: ColorsDefault.colorTextError));
                  }

                  if(validateProperty){
                    if(validatePlan){

                    }else{
                      ScaffoldMessenger.of(context)
                      .showSnackBar(showSnackBar("Se agotaron las modificaciones permitidas, debe completar el comprobante",colorText: ColorsDefault.colorTextError));
                    }
                  }

                  /*if(context.read<RegistrationPropertyProvider>().validate()){
                    
                  }*/
                  //String textAlert="Se enviarán los datos del inmueble para su revisión y posterior aprobación, tome en cuenta que no podrá modificar los datos del inmueble hasta obtener una respuesta de los administradores. ¿Desea continuar?";
                  /*if(property.publicationDate==""){
                    textAlert="Se enviarán los datos del inmueble para su revisión y posterior aprobación, tome en cuenta que no podrá modificar los datos del inmueble hasta obtener una respuesta de los administradores. ¿Desea continuar?";
                  }*/
                  if(validateProperty&&validatePlan){
                    bool confirm=await dialogConfirmOperationProperty(context, "Se enviarán los datos del inmueble para su revisión y posterior aprobación, tome en cuenta que no podrá modificar los datos del inmueble hasta obtener una respuesta de los administradores. ¿Desea continuar?");
                    if(confirm){
                      bool responseOk=await context.read<RegistrationPropertyProvider>().registerUpdateProperty(context: context);
                      if(responseOk){
                        ScaffoldMessenger.of(context)
                          .showSnackBar(showSnackBar("Operación completada exitósamente"));
                        Navigator.pop(context);
                      }else{
                        ScaffoldMessenger.of(context)
                          .showSnackBar(showSnackBar("Algo salió mal, inténtelo más tarde",colorText: ColorsDefault.colorTextError));
                      }
                    }
                  }
                },
              ),
            ),
            _wButtonVoucher(context)
          ],
        ),
      );
    }
    return SizedBox();
  }
  
  Widget _wButtonVoucher(BuildContext context){
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    final propertyTotal=registrationPropertyProvider.propertyTotalCopy;
    final property=propertyTotal.property;
    final request=registrationPropertyProvider.propertyTotalCopy.administratorRequest;
    if(property.authorization!=""&&request.requestType!="Publicar"){
      if(property.allowedUpdate<=property.counterUpdate){
        return Container(
          margin: EdgeInsets.only(left: 5*SizeDefault.scaleWidth),
          width: 60*SizeDefault.scaleWidth,
          child: Tooltip(
            message: "Subir comprobante",
            child: FButtonPrimaryIcon(
              onPressed: (){
                Navigator.pushNamed(context, '/screen_update_property_choose_plan');
              }, 
              color: ColorsDefault.colorButtonAddImage,
              icon: Icon(
                Icons.document_scanner,
                color: ColorsDefault.colorIcon,
                size: SizeDefault.sizeIconButton,
              )
            ),
          ),
        );
      }
    }
    return SizedBox();
  }
}