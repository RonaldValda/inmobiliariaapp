import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_reported_complaint_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/administrator_request.dart';
import '../../../../../domain/entities/property_reported.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../domain/usecases/property/usecase_property_reported.dart';
import '../../../../../domain/usecases/property/usecase_property_sale.dart';
import '../../../../../widgets/f_text_fields.dart';
import '../../../../../widgets/utils.dart';
import '../../../../provider/home/properties_provider.dart';
import '../../../../provider/user/user_provider.dart';

Future dialogReportComplaintProperty(
  BuildContext context,
  String sessionType
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
                child: sessionType=="Vender"?_ComplaintProperty():_ReportProperty()
              )
            ],
          );
        }
      );
    }
  ); 
}

class _ComplaintProperty extends StatefulWidget {
  _ComplaintProperty({Key? key}) : super(key: key);

  @override
  __ComplaintPropertyState createState() => __ComplaintPropertyState();
}

class __ComplaintPropertyState extends State<_ComplaintProperty> {
  int tipo=0;
  String textoBoton="Enviar reporte (imágenes)";
  TextEditingController? controller;
  List<AdministratorRequest> solicitud2es=[AdministratorRequest.empty(),AdministratorRequest.empty(),AdministratorRequest.empty()];
  bool listar=true;
  PropertyComplaint _propertyComplaint=PropertyComplaint.empty();
  UseCasePropertySale useCaseInmuebleVenta=UseCasePropertySale();
  UseCasePropertyReported useCaseInmuebleReportado=UseCasePropertyReported();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PropertyReportedComplaintProvider>().loadReportsProperty(context: context);
    });
    controller=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final property=context.read<PropertiesProvider>().propertyTotalLast.property;
    final propertyReportedComplaintProvider=context.watch<PropertyReportedComplaintProvider>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth,vertical: 20*SizeDefault.scaleWidth),
      child: Column(
        children: [
          TextStandard(
            text: "Reportar", 
            fontSize: SizeDefault.fSizeTitle,
            fontWeight: FontWeight.bold,
            color: ColorsDefault.colorTextRefused,
          ),
          SizedBox(height: 10*SizeDefault.scaleWidth,),
          _wCheckboxListTile(
            title: "Sin respuesta mucho tiempo",
            value: _propertyComplaint.noResponse, 
            onChanged: (value){
              setState(() {
                _propertyComplaint.noResponse=value!;
              });
            }
          ),
          _wCheckboxListTile(
            title: "Rechazado sin justificación valida",
            value: _propertyComplaint.rejectedWithoutJustification,
            onChanged: (value){
              setState(() {
                _propertyComplaint.rejectedWithoutJustification=value!;
              });
            }
          ),
          _wCheckboxListTile(
            title: "Otro",
            value: _propertyComplaint.other, 
            onChanged: (value){
              setState(() {
                _propertyComplaint.other=value!;
              });
            }
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10*SizeDefault.scaleWidth,bottom: 20*SizeDefault.scaleWidth),
                  child: FTextFieldBasico(
                    controller: controller!, 
                    labelText: "Detalles del reporte", 
                    onChanged: (x){
                      _propertyComplaint.requestObservations=x;
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ButtonOutlinedPrimary(
                        text: "Cancelar",
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                    ),
                    SizedBox(width:5*SizeDefault.scaleWidth),
                    Expanded(
                      child: ButtonPrimary(
                        text: "Enviar reporte", 
                        onPressed: ()async{
                          _propertyComplaint.propertyTotal.property.id=property.id;
                          bool responseOk=await propertyReportedComplaintProvider.registerComplaintProperty(_propertyComplaint);
                          Navigator.pop(context);
                          if(responseOk){
                             ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se registró el reporte"));
                          }
                        }
                      ),
                    ),
                    
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum GetTipoReporte{
  imagenes,
  datos,
  otro
}
class _ReportProperty extends StatefulWidget {
  _ReportProperty({Key? key}) : super(key: key);

  @override
  __ReportPropertyState createState() => __ReportPropertyState();
}

class __ReportPropertyState extends State<_ReportProperty> {
  int tipo=0;
  TextEditingController? controller;
  PropertyReported _propertyReported=PropertyReported.empty();
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text: "");
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PropertyReportedComplaintProvider>().loadReportsProperty(context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final property=context.read<PropertiesProvider>().propertyTotalLast.property;
    final user=context.read<UserProvider>().user;
    final propertyReportedComplaintProvider=context.watch<PropertyReportedComplaintProvider>();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth,vertical: 20*SizeDefault.scaleWidth),
      child: Column(
        children: [
          TextStandard(
            text: "Reportar", 
            fontSize: SizeDefault.fSizeTitle,
            fontWeight: FontWeight.bold,
            color: ColorsDefault.colorTextRefused,
          ),
          SizedBox(height: 10*SizeDefault.scaleWidth,),
          _wCheckboxListTile(
            title: "Vendido en más de un lugar",
            value: _propertyReported.soldMultiplePlaces,
            onChanged: (value){
              setState(() {
                _propertyReported.soldMultiplePlaces=value;
              });
            }
          ),
          _wCheckboxListTile(
            title: "Contenido falso imágen",
            value: _propertyReported.fakeContentImage,
            onChanged: (value){
              setState(() {
                _propertyReported.fakeContentImage=value;
              });
            }
          ),
          _wCheckboxListTile(
            title: "Contenido falso texto",
            value: _propertyReported.fakeContentText,
            onChanged: (value){
              setState(() {
                _propertyReported.fakeContentText=value;
              });
            }
          ),
          _wCheckboxListTile(
            title: "Contenido inapropiado",
            value: _propertyReported.inappropriateContent,
            onChanged: (value){
              setState(() {
                _propertyReported.inappropriateContent=value;
              });
            }
          ),
          _wCheckboxListTile(
            title: "Otro",
            value: _propertyReported.other,
            onChanged: (value){
              setState(() {
                _propertyReported.other=value;
              });
            }
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10*SizeDefault.scaleWidth,bottom: 20*SizeDefault.scaleWidth),
                  child: FTextFieldBasico(
                    controller: controller!, 
                    labelText: "Detalles del reporte", 
                    onChanged: (x){
                      _propertyReported.requestObservations=x;
                     //requests[tipo].observations=x;
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ButtonOutlinedPrimary(
                        text: "Cancelar",
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                    ),
                    SizedBox(width:5*SizeDefault.scaleWidth),
                    Expanded(
                      child: ButtonPrimary(
                        text: "Enviar reporte", 
                        onPressed: ()async{
                          _propertyReported.propertyTotal.property.id=property.id;
                          _propertyReported.userRequesting=User.copyWith(user);
                          bool responseOk=await propertyReportedComplaintProvider.reportProperty(_propertyReported);
                          Navigator.pop(context);
                          if(responseOk){
                             ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se registró el reporte"));
                          }
                        }
                      ),
                    ),
                    
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

CheckboxListTile _wCheckboxListTile({required String title,required bool value,required Function onChanged}) {
  return CheckboxListTile(
    title: TextStandard(text: title, fontSize: SizeDefault.fSizeStandard),
    checkColor: ColorsDefault.colorBackgroud,
    activeColor: ColorsDefault.colorPrimary,
    
    value: value, 
    onChanged: (value){
      onChanged(value);
    }
  );
}