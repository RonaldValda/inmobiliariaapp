import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

Future dialogPropertyDisable(
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
                child: _ContainerPropertyDisable()
              )
            ],
          );
        }
      );
    }
  ); 
}
class _ContainerPropertyDisable extends StatefulWidget {
  _ContainerPropertyDisable({Key? key}) : super(key: key);

  @override
  State<_ContainerPropertyDisable> createState() => __ContainerPropertyDisableState();
}

class __ContainerPropertyDisableState extends State<_ContainerPropertyDisable> {
  int _step=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260*SizeDefault.scaleWidth,
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth,vertical: 20*SizeDefault.scaleWidth),
      child: _step==0?_wStepConfirm(context):_wStepSuccess(),
    );
  }

  Widget _wStepConfirm(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            TextStandard(
              text: "Dar baja", 
              fontSize: SizeDefault.fSizeTitle,
              fontWeight: FontWeight.bold,
              color: ColorsDefault.colorPrimary,
            ),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
            TextInfo(
              text: "Se dará de baja el inmueble, por lo cuál ya no se visualizará en la sección de comprar, también al dar de baja sin reportar solo se le asignará 1 punto para su calificación lo cuál afectará a su reputación como vendedor", 
              fontSize: SizeDefault.fSizeStandard,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5*SizeDefault.scaleWidth,),
            TextInfo(
              text: "¿Desea continuar?", 
              fontSize: SizeDefault.fSizeStandard,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
          ],
        ),
        _wButtonsStepConfirm(context)
      ],
    );
  }

  Row _wButtonsStepConfirm(BuildContext context) {
    return Row(
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
            text: "Confirmar", 
            onPressed: ()async{
              if(await context.read<RegistrationPropertyProvider>().updatePropertyStatus(context: context,actionType: "Dar baja")){
                setState(() {
                  _step=1;
                });
              }
            }
          )
        ),
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
}