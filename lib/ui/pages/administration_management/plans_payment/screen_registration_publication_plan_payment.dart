
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publication_plan_payment_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

class ScreenRegistrationPublicationPlanPayment extends StatefulWidget {
  ScreenRegistrationPublicationPlanPayment({Key? key}) : super(key: key);

  @override
  State<ScreenRegistrationPublicationPlanPayment> createState() => _ScreenRegistrationPublicationPlanPaymentState();
}

class _ScreenRegistrationPublicationPlanPaymentState extends State<ScreenRegistrationPublicationPlanPayment> {
  TextEditingController? _controllerPlanName;
  TextEditingController? _controllerCost;
  TextEditingController? _controllerModificationsAllowed;
  final _sizedBox=SizedBox(height: 10*SizeDefault.scaleWidth,);
  int _group=0;
  @override
  void initState() {
    _controllerPlanName=TextEditingController(text: "");
    _controllerCost=TextEditingController(text: "");
    _controllerModificationsAllowed=TextEditingController(text: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final plan=context.read<PublicationPlanPaymentProvider>().publicationPlanPaymentSelected;
      _controllerPlanName!.text=plan.planName;
      _controllerCost!.text=plan.cost.toString();
      _controllerModificationsAllowed!.text=plan.modificationsAllowed.toString();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final publicationPlanPaymentProvider=context.watch<PublicationPlanPaymentProvider>();
    final mapValidate=publicationPlanPaymentProvider.mapValidatePublication;
    final planSelected=publicationPlanPaymentProvider.publicationPlanPaymentSelected;
    final newBank=planSelected.id=="";
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: newBank?"Registrando plan publicación":"Actualizando plan publicación",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FTextFieldBasico(
                controller: _controllerPlanName!, 
                labelText: "Nombre del plan", 
                errorText: mapValidate["plan_name"],
                onChanged: (x){
                  planSelected.planName=x;
                }
              ),
              _sizedBox,
              Container(
                height: 30*SizeDefault.scaleWidth,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextStandard(
                        text: "Publicar",
                        fontSize: SizeDefault.fSizeStandard,
                      )
                    ),
                    Container(
                      
                      padding: EdgeInsets.zero,
                      child: Radio<int>(
                        splashRadius: 10,
                        activeColor: ColorsDefault.colorPrimary,
                        groupValue: _group,
                        value: planSelected.planType=="Publicar"?0:1,
                        onChanged: (value){
                          planSelected.planType="Publicar";
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                    SizedBox(width: 10*SizeDefault.scaleWidth,),
                    Container(
                      child: TextStandard(
                        text: "Actualizar",
                        fontSize: SizeDefault.fSizeStandard,
                      )
                    ),
                    Container(
                      child: Radio<int>(
                        splashRadius: 10,
                        activeColor: ColorsDefault.colorPrimary,
                        groupValue: _group,
                        value: planSelected.planType=="Publicar"?1:0,
                        onChanged: (value){
                          planSelected.planType="Actualizar";
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
              ),
              _sizedBox,
              FTextFieldBasico(
                controller: _controllerCost!, 
                labelText: "Costo", 
                textInputType: TextInputType.number,
                //errorText: mapValidateBank["web"],
                onChanged: (x){
                  if(x!=""){
                    planSelected.cost=int.parse(x);
                  }else{
                    planSelected.cost=0;
                  }
                }
              ),
              _sizedBox,
              FTextFieldBasico(
                controller: _controllerModificationsAllowed!, 
                labelText: "Modificaciones permitidas", 
                textInputType: TextInputType.number,
                //errorText: mapValidateBank["app"],
                onChanged: (x){
                  if(x!=""){
                    planSelected.modificationsAllowed=int.parse(x);
                  }else{
                    planSelected.modificationsAllowed=0;
                  }
                }
              ),
              SizedBox(height: 30*SizeDefault.scaleWidth,),
              ButtonPrimary(
                text: newBank?"Registrar":"Guardar cambios", 
                onPressed: ()async{
                  if(context.read<PublicationPlanPaymentProvider>().validatePublication()){
                    bool responseOk=false;
                    if(newBank){
                      responseOk=await context.read<PublicationPlanPaymentProvider>().registerPublicactionPlanPayment();
                    }else{
                      responseOk=await context.read<PublicationPlanPaymentProvider>().updatePublicactionPlanPayment();
                    }
                    if(responseOk){
                      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Proceso realizado exitósamente"));
                      Navigator.pop(context);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Error"));
                    }
                  }
                }, 
              ),
            ],
          )
        )
      ),
    );
  }
}