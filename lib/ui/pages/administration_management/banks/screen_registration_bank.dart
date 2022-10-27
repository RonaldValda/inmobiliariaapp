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
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

class ScreenRegistrationBank extends StatefulWidget {
  ScreenRegistrationBank({Key? key}) : super(key: key);

  @override
  State<ScreenRegistrationBank> createState() => _ScreenRegistrationBankState();
}

class _ScreenRegistrationBankState extends State<ScreenRegistrationBank> {
  TextEditingController? _controllerBankName;
  TextEditingController? _controllerApp;
  TextEditingController? _controllerWeb;
  TextEditingController? _controllerPreAproval;
  final _sizedBox=SizedBox(height: 10*SizeDefault.scaleWidth,);
  @override
  void initState() {
    _controllerBankName=TextEditingController(text: "");
    _controllerApp=TextEditingController(text: "");
    _controllerWeb=TextEditingController(text: "");
    _controllerPreAproval=TextEditingController(text: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bankSelected=context.read<BankAccountProvider>().bankSelected;
      _controllerBankName!.text=bankSelected.bankName;
      _controllerApp!.text=bankSelected.app;
      _controllerWeb!.text=bankSelected.web;
      _controllerPreAproval!.text=bankSelected.preApproval;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final bankAccountProvider=context.watch<BankAccountProvider>();
    final mapValidateBank=bankAccountProvider.mapValidateBank;
    final bankSelected=bankAccountProvider.bankSelected;
    final newBank=bankAccountProvider.bankSelected.id=="";
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: newBank?"Registrando banco":"Modificando banco",
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
                controller: _controllerBankName!, 
                labelText: "Nombre banco", 
                errorText: mapValidateBank["bank_name"],
                onChanged: (x){
                  bankSelected.bankName=x;
                }
              ),
              _sizedBox,
              FTextFieldBasico(
                controller: _controllerWeb!, 
                labelText: "Web", 
                textInputType: TextInputType.url,
                errorText: mapValidateBank["web"],
                onChanged: (x){
                  bankSelected.web=x;
                }
              ),
              _sizedBox,
              FTextFieldBasico(
                controller: _controllerApp!, 
                labelText: "App", 
                textInputType: TextInputType.url,
                errorText: mapValidateBank["app"],
                onChanged: (x){
                  bankSelected.app=x;
                }
              ),
              _sizedBox,
              FTextFieldBasico(
                controller: _controllerPreAproval!, 
                labelText: "Pre aprobación", 
                textInputType: TextInputType.url,
                errorText: mapValidateBank["pre_approval"],
                onChanged: (x){
                  bankSelected.preApproval=x;
                }
              ),
              _sizedBox,
              FListTile(
                title: "Logo del banco", 
                errorText: mapValidateBank["bank_logo"],
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
                text: newBank?"Registrar":"Guardar cambios", 
                onPressed: ()async{
                  if(context.read<BankAccountProvider>().validateBank()){
                    bool responseOk=false;
                    if(newBank){
                      responseOk=await context.read<BankAccountProvider>().registrerBank();
                    }else{
                      responseOk=await context.read<BankAccountProvider>().updateBank();
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
    final linkImage=context.watch<BankAccountProvider>().bankSelected.logoImageLink;
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
          image: NetworkImage(context.read<BankAccountProvider>().bankSelected.logoImageLink)
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
        context.read<BankAccountProvider>().bankSelected.logoImageLink=linkD;
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