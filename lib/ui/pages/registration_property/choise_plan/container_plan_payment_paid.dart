
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/drop_down_bank_account.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';
import '../../../../domain/usecases/general/usecase_bank.dart';
import '../../../common/buttons.dart';
import '../../../common/colors_default.dart';
import '../../../common/texts.dart';
import '../../../provider/registration_property/registration_property_provider.dart';
import '../../../common/f_list_tile.dart';
import 'container_plan_image.dart';
class ContainerPlanPaymentPaid extends StatefulWidget {
  ContainerPlanPaymentPaid({Key? key}) : super(key: key);
  @override
  _ContainerPlanPaymentPaidState createState() => _ContainerPlanPaymentPaidState();
}

class _ContainerPlanPaymentPaidState extends State<ContainerPlanPaymentPaid> {
  bool uploading=false;
  final picker=ImagePicker();
  double heigthImagen=0;
  double widthImagen=0;
  bool isGallery=true;
  bool loadingImage=false;
  TextEditingController? _controllerDepositNumber;
  TextEditingController? _controllerDepositorName;
  dynamic imagen="";
  UseCaseBank useCaseBanco=UseCaseBank();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final registrationPropertyPlanProvider=context.watch<RegistrationPropertyPlanProvider>();
    final mapValidatePlanPaid=registrationPropertyPlanProvider.mapValidatePlanPaid;
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    final propertyVoucher=registrationPropertyProvider.propertyTotalCopy.administratorRequest.propertyVoucher;
    if(_controllerDepositNumber==null){
      _controllerDepositNumber=TextEditingController(text: propertyVoucher.transactionNumber);
      _controllerDepositorName=TextEditingController(text: propertyVoucher.depositorName);
    }
    return Container(
      child:Expanded(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: Column(
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
                  property.category.toUpperCase()=="PRO"
                  ?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInfo(
                        text: "- Se permiten imágenes ilimitadas.", 
                        fontSize: SizeDefault.fSizeStandard,
                      ),
                      TextInfo(
                        text: "- No se permiten video 2D, tour virtual 360, video tour 360.", 
                        fontSize: SizeDefault.fSizeStandard,
                      ),
                      TextInfo(
                        text: "- Tiene opción a 1 modificación gratuita", 
                        fontSize: SizeDefault.fSizeStandard,
                      ),
                    ],
                  ):Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInfo(
                        text: "- Se permiten imágenes ilimitadas.", 
                        fontSize: SizeDefault.fSizeStandard,
                      ),
                      TextInfo(
                        text: "- Se permiten video 2D, tour virtual 360, video tour 360.", 
                        fontSize: SizeDefault.fSizeStandard,
                      ),
                      TextInfo(
                        text: "- Tiene opción a 3 modificación gratuita", 
                        fontSize: SizeDefault.fSizeStandard,
                      ),
                    ]
                  ),
                  SizedBox(height: 10*SizeDefault.scaleHeight,),
                  DropDownBankAccount(
                    text: "Cuenta de banco: ", 
                    stateProvider: registrationPropertyPlanProvider,
                    errorText: mapValidatePlanPaid["bank_account"],
                  ),
                  SizedBox(height: 10*SizeDefault.scaleHeight,),
                  FTextFieldBasico(
                    controller: _controllerDepositNumber!, 
                    labelText: "Número de transacción", 
                    errorText: mapValidatePlanPaid["transaction_number"],
                    onChanged: (x){
                      propertyVoucher.transactionNumber=x.toString();
                    }
                  ),
                  SizedBox(height: 10*SizeDefault.scaleHeight,),
                  FTextFieldBasico(
                    controller: _controllerDepositorName!, 
                    labelText: "Nombre depositante", 
                    errorText: mapValidatePlanPaid["deposit_name"],
                    onChanged: (x){
                      propertyVoucher.depositorName=x.toString();
                    }
                  ),
                ],
              ),
            ),
            //SizedBox(height: 10*SizeDefault.scaleHeight,),
            Padding(
              padding: EdgeInsets.only(top: 15*SizeDefault.scaleHeight),
              child: FListTile(
                title: "Comprobante de depósito", 
                colorText: ColorsDefault.colorText,
                errorText: mapValidatePlanPaid["deposit_image"],
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
                if(context.read<RegistrationPropertyPlanProvider>().validatePaid(context: context)){
                  Navigator.popAndPushNamed(context, '/screen_registration_property');
                } 
              }
            )
            //wImageVoucher(inmuebleInfo),
          ],
        ),
      )
    );
  }

}