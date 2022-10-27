import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/pages/registration_property/choise_plan/container_plan_image.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:provider/provider.dart';
class ContainerPlanPaymentFree extends StatefulWidget {
  ContainerPlanPaymentFree({Key? key}) : super(key: key);

  @override
  State<ContainerPlanPaymentFree> createState() => _ContainerPlanPaymentFreeState();
}

class _ContainerPlanPaymentFreeState extends State<ContainerPlanPaymentFree> {
  bool isPropertyDocumentActivate=false;
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final registrationPropertyPlanProvider=context.watch<RegistrationPropertyPlanProvider>();
    final mapDocumentsPlansImage=registrationPropertyPlanProvider.mapDocumentsPlansImage;
    final mapValidatePlanFree=registrationPropertyPlanProvider.mapValidatePlanFree;
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _wInfoPlan(context),
          Column(
            children:[
              Padding(
                padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleHeight),
                child: FListTile(
                  title: "Documento de propiedad", 
                  colorText: ColorsDefault.colorText,
                  widgetTrailing: mapDocumentsPlansImage["document_property_image"]==""?Container():wTrailing(),
                  errorText: mapValidatePlanFree["document_property_image"],
                  onTap: ()async{
                    await fShowModalBottomSheet(
                      context: context, 
                      widget: ContainerPlanImage(title: "Documento de propiedad",keyImage: "document_property_image")
                    );
                  }, 
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleHeight),
                child: FListTile(
                  title: "Documento exclusivo de venta (si hubiere)", 
                  colorText: ColorsDefault.colorText,
                  widgetTrailing: mapDocumentsPlansImage["document_sales_image"]==""?Container():wTrailing(),
                  onTap: ()async{
                    await fShowModalBottomSheet(
                      context: context, 
                      widget: ContainerPlanImage(title: "Documento exclusivo de venta",keyImage: "document_sales_image")
                    );
                  },  
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleHeight),
                child: FListTile(
                  title: "Cédula de identidad del propietario", 
                  colorText: ColorsDefault.colorText,
                  widgetTrailing: mapDocumentsPlansImage["owner_DNI_image"]==""?Container():wTrailing(),
                  errorText: mapValidatePlanFree["owner_DNI_image"],
                  onTap: ()async{
                    await fShowModalBottomSheet(
                      context: context, 
                      widget: ContainerPlanImage(title: "Cédula de identidad del propietario",keyImage: "owner_DNI_image")
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleHeight),
                child: FListTile(
                  title: "Cédula de identidad del agente (si hubiere)", 
                  colorText: ColorsDefault.colorText,
                  widgetTrailing: mapDocumentsPlansImage["agent_DNI_image"]==""?Container():wTrailing(),
                  onTap: ()async{
                    await fShowModalBottomSheet(
                      context: context, 
                      widget: ContainerPlanImage(title: "Cédula de identidad del agente",keyImage: "agent_DNI_image")
                    );
                  },
                ),
              ),
            ]
          ),
          SizedBox(height: 30*SizeDefault.scaleHeight,),
          ButtonPrimary(
            text: "Continuar", 
            onPressed: (){
              if(context.read<RegistrationPropertyPlanProvider>().validateFree(context: context)){
                Navigator.popAndPushNamed(context, '/screen_registration_property');
              }
            }
          )
        ],
      ),
    );
  }

  Container _wInfoPlan(BuildContext context) {
    final registrationPropertyPlanProvider=context.read<RegistrationPropertyPlanProvider>();
    final publicationPlanSelected=registrationPropertyPlanProvider.publicationPlanPayment(context);
    return Container(
      margin: EdgeInsets.only(bottom: 20*SizeDefault.scaleHeight),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10*SizeDefault.scaleHeight,),
          TextInfo(
            text: "Infomación del plan:", 
            fontSize: SizeDefault.fSizeStandard,
            fontWeight: FontWeight.w600,
            color: ColorsDefault.colorTextInfo,
          ),
          SizedBox(height: 10*SizeDefault.scaleHeight,),
          Container(
            //padding: EdgeInsets.all(10*SizeDefault.scaleHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInfo(
                  text: "- Sólo 3 imágenes por inmueble son permitidas.", 
                  fontSize: SizeDefault.fSizeStandard,
                ),
                TextInfo(
                  text: "- No se permiten vídeo 2D, tour virtual 360, vídeo tour 360.", 
                  fontSize: SizeDefault.fSizeStandard,
                ),
                TextInfo(
                  text: "- ${publicationPlanSelected.modificationsAllowed} modificaciones permitidas.", 
                  fontSize: SizeDefault.fSizeStandard,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Container wTrailing() {
    return Container(
      height: 50*SizeDefault.scaleHeight,
      width: 50*SizeDefault.scaleHeight,
      child: Icon(
        Icons.check,
        color: ColorsDefault.colorPrimary,
      ),
    );
  }
}