import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

Future dialogLowerPrice(
  BuildContext context,
)async{
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            children: [
              Container(
                width: 300*SizeDefault.scaleWidth,
                child: _ContainerLowerPrice()
              )
            ],
          );
        }
      );
    }
  ); 
}
class _ContainerLowerPrice extends StatefulWidget {
  _ContainerLowerPrice({Key? key}) : super(key: key);

  @override
  State<_ContainerLowerPrice> createState() => __ContainerLowerPriceState();
}

class __ContainerLowerPriceState extends State<_ContainerLowerPrice> {
  TextEditingController? _controller;
  int _step=0;
  bool _isVoucher=false;
  String _errorTextPrice="";
  bool _validPaid=true;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final propertyOrigin=context.read<PropertiesProvider>().propertyTotalLast.property;
    if(propertyOrigin.counterUpdate>=propertyOrigin.allowedUpdate){
      _isVoucher=true;
    }
    if(_controller==null){
      _controller=TextEditingController(text: propertyOrigin.price.toString());
    }
    return Container(
      height: 380*SizeDefault.scaleWidth,
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth,vertical: 20*SizeDefault.scaleWidth),
      child: _step==0?_wStepData(context):_step==1?_wStepConfirm(context):_wStepSuccess(),
    );
  }

  Column _wStepData(BuildContext context) {
    final propertyOrigin=context.read<PropertiesProvider>().propertyTotalLast.property;
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    return Column(
      children: [
        TextStandard(
          text: "Rebajar precio", 
          fontSize: SizeDefault.fSizeTitle,
          fontWeight: FontWeight.bold,
          color: ColorsDefault.colorPrimary,
        ),
        SizedBox(height: 20*SizeDefault.scaleWidth,),
        propertyOrigin.pricesHistory.length<2
        ?Padding(
          padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
          child: TextInfo(
            text: "Puede rebajar el precio como máximo en un 10% (por vez única), para rebajas superiores se pedirá autorización al administrador", 
            textAlign: TextAlign.center,
            fontSize: SizeDefault.fSizeStandard
          ),
        )
        :Padding(
          padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
          child: TextInfo(
            text: "El administrador deberá autorizar la rebaja de precio", 
            textAlign: TextAlign.center,
            fontSize: SizeDefault.fSizeStandard
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeDefault.paddingHorizontalText),
          child: Row(
            children: [
              TextStandard(
                text: "Precio actual: ", 
                fontSize: SizeDefault.fSizeStandard,
                fontWeight: FontWeight.w300,
                color: ColorsDefault.colorTextLabel,
              ),
              TextStandard(
                text: "${propertyOrigin.price}"+r"$", 
                fontSize: SizeDefault.fSizeStandard,
                fontWeight: FontWeight.w500,
                color: ColorsDefault.colorText,
              ),
            ],
          ),
        ),
        SizedBox(height: 10*SizeDefault.scaleWidth,),
        FTextFieldBasico(
          controller: _controller!, 
          labelText: "Nuevo precio", 
          textInputType: TextInputType.number,
          errorText: _errorTextPrice,
          onChanged: (x){
            property.price=x!=""?int.parse(x):0;
          }
        ),
        SizedBox(height: 20*SizeDefault.scaleWidth,),
        _isVoucher
        ?Container(
          height: 40*SizeDefault.scaleWidth,
          margin: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
          child: TextInfo(
            text: "No tiene modificaciones permitidas, por favor seleccione un plan", 
            textAlign: TextAlign.center,
            fontSize: SizeDefault.fSizeStandard,
            color: !_validPaid?ColorsDefault.colorTextError:null,
          ),
        )
        :Container(
          height: 40*SizeDefault.scaleWidth,
          margin: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
        ),
        Row(
          children: [
            Expanded(
              child: ButtonOutlinedPrimary(
                text: "Cancelar",
                color: ColorsDefault.colorTextError, 
                onPressed: (){
                  Navigator.pop(context);
                }
              )
            ),
            SizedBox(width: 5*SizeDefault.scaleWidth),
            Expanded(
              child: ButtonPrimary(
                text: "Guardar", 
                onPressed: (){
                  if(property.price>=propertyOrigin.price){
                    _errorTextPrice="Debe ser menor al precio acual";
                  }else{
                    _errorTextPrice="";
                  }
                  if(_isVoucher){
                    if(context.read<RegistrationPropertyPlanProvider>().validatePaid(context: context)){
                      _validPaid=true;
                    }else{
                      _validPaid=false;
                    }
                  }
                  if(_errorTextPrice==""&&_validPaid){
                    _step=1;
                  }
                  setState(() {});
                }
              )
            ),
            if(_isVoucher) _wButtonVoucher(context)
          ],
        )
      ],
    );
  }

  Widget _wStepConfirm(BuildContext context){
    final propertyOrigin=context.read<PropertiesProvider>().propertyTotalLast.property;
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    String textInfo="";
    if(!_isVoucher&&!registrationPropertyProvider.isPriceRequest(context: context)){
      textInfo="Se realizará el cambio de precio de ${propertyOrigin.price} a ${property.price}";
    }else{
       textInfo="Esta solicitud será revisada por el administrador (tome en cuenta que el inmueble no será visible para los usuario hasta su aprobación):";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: 30*SizeDefault.scaleWidth,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.question_mark,
                    color: ColorsDefault.colorPrimary,
                    size: 30*SizeDefault.scaleWidth,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
            Padding(
              padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
              child: TextInfo(
                text: textInfo, 
                textAlign: TextAlign.center,
                fontSize: SizeDefault.fSizeStandard,
                color: ColorsDefault.colorPrimary,
              ),
            ),
            if(_isVoucher)
            Padding(
              padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
              child: Row(
                children: [
                  Expanded(
                    child: TextInfo(
                      text: "- Se validará el comprobante de depósito", 
                      textAlign: TextAlign.start,
                      fontSize: SizeDefault.fSizeStandard
                    ),
                  ),
                ],
              ),
            ),
            if(registrationPropertyProvider.isPriceRequest(context: context))
            Padding(
              padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
              child: Row(
                children: [
                  Expanded(
                    child: TextInfo(
                      text: "- Se validará el cambio de precio de ${propertyOrigin.price} a ${property.price}", 
                      textAlign: TextAlign.start,
                      fontSize: SizeDefault.fSizeStandard
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
              child: TextInfo(
                text: "¿Desea continuar?", 
                textAlign: TextAlign.center,
                fontSize: SizeDefault.fSizeStandard
              ),
            ),
          ],
        ),
        _wButtonsStepConfirm(property, propertyOrigin, context)
      ],
    );
  }

  Widget _wStepSuccess(){
    return Column(
      children: [
        SizedBox(height: 30*SizeDefault.scaleWidth,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.check,
                color: ColorsDefault.colorPrimary,
                size: 30*SizeDefault.scaleWidth,
              ),
            ),
          ],
        ),
        SizedBox(height: 30*SizeDefault.scaleWidth,),
        Padding(
          padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
          child: TextInfo(
            text: "La operación se realizó exitósamente", 
            textAlign: TextAlign.center,
            fontSize: SizeDefault.fSizeStandard,
            color: ColorsDefault.colorPrimary,
          ),
        ),
      ],
    );
  }

  Row _wButtonsStepConfirm(Property property, Property propertyOrigin, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonOutlinedPrimary(
            text: "Atrás",
            color: ColorsDefault.colorTextError, 
            onPressed: (){
              setState(() {
                _step=0;
              });
            }
          )
        ),
        SizedBox(width: 5*SizeDefault.scaleWidth),
        Expanded(
          child: ButtonPrimary(
            text: "Confirmar", 
            onPressed: ()async{
              if(await context.read<RegistrationPropertyProvider>().updatePropertyPrice(context: context)){
                setState(() {
                  _step=2;
                });
              }
            }
          )
        ),
      ],
    );
  }

  Widget _wButtonVoucher(BuildContext context){
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