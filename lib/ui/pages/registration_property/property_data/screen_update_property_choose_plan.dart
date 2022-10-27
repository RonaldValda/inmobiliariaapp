import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/drop_down_bank_account.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publication_plan_payment_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/f_text_fields.dart';
import '../../../common/buttons.dart';
import '../../../common/f_show_modal_bottom_sheet.dart';
import '../choise_plan/container_plan_image.dart';

class ScreenUpdatePropertyChoosePlan extends StatefulWidget {
  ScreenUpdatePropertyChoosePlan({Key? key}) : super(key: key);

  @override
  State<ScreenUpdatePropertyChoosePlan> createState() => _ScreenUpdatePropertyChoosePlanState();
}

class _ScreenUpdatePropertyChoosePlanState extends State<ScreenUpdatePropertyChoosePlan> {
  TextEditingController? _controllerTransactionNumber;
  TextEditingController? _controllerDepositorName;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsDefault.colorBackgroud,
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Planes de pago para modificar",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: _wBody(context)
    );
  }

  Widget _wBody(BuildContext context){
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final registrationPropertyPlanProvider=context.watch<RegistrationPropertyPlanProvider>();
    final mapValidate=registrationPropertyPlanProvider.mapValidatePlanPaid;
    final publicationPlanSelected=registrationPropertyPlanProvider.publicationPlanPayment(context);
    final propertyVoucher=registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher;
    if(_controllerDepositorName==null){
      _controllerDepositorName=TextEditingController(text: propertyVoucher.depositorName);
      _controllerTransactionNumber=TextEditingController(text: propertyVoucher.transactionNumber);
    }
    return Container(
      width: SizeDefault.swidth,
      color: ColorsDefault.colorBackgroud,
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
      child: ListView(
        padding: EdgeInsets.zero,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
             //color: Colors.amber,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: context.read<PublicationPlanPaymentProvider>().publicationPlansPaymentUpdate.map((plan){
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          TextStandard(
                            text: plan.planName, 
                            fontSize: 14*SizeDefault.scaleHeight,
                            fontWeight: FontWeight.w600,
                            color: ColorsDefault.colorPrimary,
                          ),
                          TextStandard(
                            text: plan.cost.toString()+r" Bs.",
                            fontSize: 17*SizeDefault.scaleHeight,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    
                    Checkbox(
                      value: publicationPlanSelected.planName.toUpperCase()==plan.planName.toUpperCase(), 
                      activeColor: ColorsDefault.colorPrimary,
                      onChanged: (selected){
                        registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher.paymentAmount=plan.cost;
                        registrationPropertyProvider.notify();
                      }
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          TextInfo(
            text: "Infomación del plan:", 
            fontSize: SizeDefault.fSizeStandard,
            fontWeight: FontWeight.w600,
            color: ColorsDefault.colorTextInfo,
          ),
          SizedBox(height: 10*SizeDefault.scaleHeight,),
          TextInfo(
            text: "- Sus modificaciones permitidas aumentarán en ${publicationPlanSelected.modificationsAllowed} .", 
            fontSize: SizeDefault.fSizeStandard,
          ),
          SizedBox(height: 20*SizeDefault.scaleHeight,),
          DropDownBankAccount(
            text: "Cuenta de banco: ", 
            stateProvider: registrationPropertyPlanProvider,
            errorText: mapValidate["bank_account"],
          ),
          SizedBox(height: 10*SizeDefault.scaleHeight,),
          FTextFieldBasico(
            controller: _controllerTransactionNumber!, 
            labelText: "Número de transacción", 
            errorText: mapValidate["transaction_number"],
            onChanged: (x){
              propertyVoucher.transactionNumber=x.toString();
            }
          ),
          SizedBox(height: 10*SizeDefault.scaleHeight,),
          FTextFieldBasico(
            controller: _controllerDepositorName!, 
            labelText: "Nombre depositante", 
            errorText: mapValidate["deposit_name"],
            onChanged: (x){
              propertyVoucher.depositorName=x.toString();
            }
          ),
          Padding(
            padding: EdgeInsets.only(top: 15*SizeDefault.scaleHeight),
            child: FListTile(
              title: "Comprobante de depósito", 
              colorText: ColorsDefault.colorText,
              errorText: mapValidate["deposit_image"],
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerPlanImage(title: "Comprobante de depósito",keyImage: "deposit_image")
                );
              },
              
            ),
          ),
          SizedBox(height: 30*SizeDefault.scaleHeight,),
          ButtonPrimary(
            text: "Continuar", 
            onPressed: (){
              Navigator.pop(context);
            }
          )
        ],
      ),
    );
  }
}