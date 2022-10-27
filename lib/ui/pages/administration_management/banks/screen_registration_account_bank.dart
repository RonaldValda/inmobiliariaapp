import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/services/images_repository.dart';
import 'package:inmobiliariaapp/device/image_utils.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/bank_account_provider.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/f_text_fields.dart';

class ScreenRegistrationAccountBank extends StatefulWidget {
  ScreenRegistrationAccountBank({Key? key}) : super(key: key);

  @override
  State<ScreenRegistrationAccountBank> createState() => _ScreenRegistrationAccountBankState();
}

class _ScreenRegistrationAccountBankState extends State<ScreenRegistrationAccountBank> {
  TextEditingController? _controllerAccountNumber;
  TextEditingController? _controllerOwnerName;
  TextEditingController? _controllerBankName;
  @override
  void initState() {
    super.initState();
    _controllerAccountNumber=TextEditingController(text: "");
    _controllerOwnerName=TextEditingController(text: "");
    _controllerBankName=TextEditingController(text: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bankAccountSelected=context.read<BankAccountProvider>().bankAccountSelected;
      _controllerAccountNumber!.text=bankAccountSelected.accountNumber;
      _controllerOwnerName!.text=bankAccountSelected.owner;
      _controllerBankName!.text=bankAccountSelected.bankName;
    });
  }
  @override
  Widget build(BuildContext context) {
    final bankAccountProvider=context.watch<BankAccountProvider>();
    final bankAccountSelected=bankAccountProvider.bankAccountSelected;
    final newAccount=bankAccountProvider.bankAccountSelected.id=="";
    final mapValidateBankAccount=bankAccountProvider.mapValidateBankAccount;
    final sizedBox=SizedBox(height: 10*SizeDefault.scaleWidth,);
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: newAccount?"Registrando nueva cuenta":"Modificando cuenta",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
        child: SingleChildScrollView(
          child: Column(
            children:[
              FTextFieldBasico(
                controller: _controllerAccountNumber!, 
                labelText: "Número cuenta", 
                errorText: mapValidateBankAccount["account_number"],
                textInputType: TextInputType.number,
                onChanged: (x){
                  bankAccountSelected.accountNumber=x;
                }
              ),
              sizedBox,
              FTextFieldBasico(
                controller: _controllerOwnerName!, 
                labelText: "Número titular cuenta", 
                errorText: mapValidateBankAccount["owner"],
                onChanged: (x){
                  bankAccountSelected.owner=x;
                }
              ),
              sizedBox,
              FTextFieldBasico(
                controller: _controllerBankName!, 
                labelText: "Nombre de la entidad financiera", 
                errorText: mapValidateBankAccount["bank_name"],
                onChanged: (x){
                  bankAccountSelected.bankName=x;
                }
              ),
              sizedBox,
              FListTile(
                title: "Logo del banco", 
                errorText: mapValidateBankAccount["bank_logo"],
                onTap: ()async{
                  await fShowModalBottomSheet(
                    context: context, 
                    widget: _ContainerImageLogo()
                  );
                  setState(() {
                    
                  });
                }, 
                colorText: ColorsDefault.colorText
              ),
              SizedBox(height: 30*SizeDefault.scaleWidth,),
              ButtonPrimary(
                text: newAccount?"Registrar":"Guardar cambios", 
                onPressed: ()async{
                  if(context.read<BankAccountProvider>().validateBankAccount()){
                    bool responseOk=false;
                    if(newAccount){
                      responseOk=await context.read<BankAccountProvider>().registrerBankAccount();
                    }else{
                      responseOk=await context.read<BankAccountProvider>().updateBankAccount();
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
            ]
          ),
        ),
      ),
    );
  }
}

class _ContainerImageLogo extends StatefulWidget {
  _ContainerImageLogo({Key? key}) : super(key: key);

  @override
  State<_ContainerImageLogo> createState() => __ContainerImageLogoState();
}

class __ContainerImageLogoState extends State<_ContainerImageLogo> {
  bool _loading=false;
  final heightImage=355*SizeDefault.scaleHeight;
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final linkImage=context.watch<BankAccountProvider>().bankAccountSelected.logoImageLink;
    return Container(
      width: double.infinity,
      height: 450*SizeDefault.scaleHeight,
      padding: EdgeInsets.all(7*SizeDefault.scaleWidth),
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroud,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25),),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left:10*SizeDefault.scaleWidth),
                child: TextStandard(text: "Logo de la entidad financiera", fontSize: 14*SizeDefault.scaleHeight),
              ),
              FXButton()
            ],
          ),
          _loading
          ?_wLoading(height: heightImage)
          :linkImage==""?_wButtonAdd(context: context,height: heightImage):_wImage(context: context, height: heightImage),
        ],
      ),
    );
  }

  Widget _wButtonAdd({required BuildContext context,required double height}) {
    return InkWell(
      onTap: (){
        _onPressed(context: context);
      },
      child: Container(
        width: double.infinity,
        height: heightImage,
        margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight),
        color: ColorsDefault.colorButtonAddImage,
        child: Center(
          child: Icon(Icons.add,size: 60*SizeDefault.scaleHeight,color:ColorsDefault.colorIcon),
        ),
      ),
    );
  }

  Widget _wLoading({required double height}){
    return Container(
      width: double.infinity,
      height: heightImage,
      margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight),
      color: ColorsDefault.colorButtonAddImage,
      child: Center(
        child: CupertinoActivityIndicator(
          radius:SizeDefault.radiusCircularIndicator
        )
      ),
    );
  }

  Widget _wImage({required BuildContext context, required double height}){
    return Container(
      width: double.infinity,
      height: heightImage,
      margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight),
      padding:EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsDefault.colorBorder,
          width: 0.3*SizeDefault.scaleHeight
        ),
        color: ColorsDefault.colorButtonAddImage,
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(context.read<BankAccountProvider>().bankAccountSelected.logoImageLink)
        ),
      ),
    );
  }

  void _onPressed({required BuildContext context}) async{
    try{
      final file=await ImageUtils.uploadImage();
      if(file==null) return;
      setState(() {
        _loading=true;
      });
      uploadImagen(file).then((linkD){
        _loading=false;
        context.read<BankAccountProvider>().bankAccountSelected.logoImageLink=linkD;
        print(linkD);
      }).whenComplete(() {
        setState(() {
          
        });
      });
    }catch(e){
    log(e.toString());
    }
  }
}