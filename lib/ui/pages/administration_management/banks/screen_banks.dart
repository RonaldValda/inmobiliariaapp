
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/services/images_repository.dart';
import 'package:inmobiliariaapp/device/image_utils.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_bank.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/banks/screen_registration_bank.dart';
import 'package:inmobiliariaapp/ui/provider/generals/bank_account_provider.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

class ScreenBanks extends StatefulWidget {
  ScreenBanks({Key? key}) : super(key: key);

  @override
  _ScreenBanksState createState() => _ScreenBanksState();
}

class _ScreenBanksState extends State<ScreenBanks> {
  TextEditingController? controllerBankName;
  TextEditingController? controllerApp;
  TextEditingController? controllerWeb;
  TextEditingController? controllerPreAproval;
  dynamic image="";
  bool isGallery=true;
  bool loadingImage=false;
  int selected=-1;
  Bank selectedBank=Bank.empty();
  UseCaseBank useCaseBank=UseCaseBank();
  @override
  void initState() {
    super.initState();
    controllerBankName=TextEditingController(text: "");
    controllerApp=TextEditingController(text: "");
    controllerWeb=TextEditingController(text: "");
    controllerPreAproval=TextEditingController(text: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BankAccountProvider>().loadBanks();
    });
  }
  @override
  Widget build(BuildContext context) {
    final bankAccountProvider=context.watch<BankAccountProvider>();
    final banks=bankAccountProvider.banks;
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Bancos",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: banks.length,
                separatorBuilder: (context,index){
                  return Container(
                    height: 1*SizeDefault.scaleWidth,
                    color: ColorsDefault.colorSeparated,
                  );
                },
                itemBuilder: (context, index) {
                  Bank bank=banks[index];
                  final selected=bank.id==bankAccountProvider.bankSelected.id;
                  return FListTileFull(
                    onTap: (){
                      context.read<BankAccountProvider>().setBankSelected(bank);
                    }, 
                    colorBackground: selected?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud,
                    widgetLeading: Container(
                      width: 50*SizeDefault.scaleWidth,
                      height: 50*SizeDefault.scaleWidth,
                      margin: EdgeInsets.only(right:10*SizeDefault.scaleWidth),
                      decoration: BoxDecoration(
                        color: ColorsDefault.colorBackgroud,
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: NetworkImage(bank.logoImageLink),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    widgetContent: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStandard(
                            text: bank.bankName, 
                            fontSize: 15*SizeDefault.scaleWidth,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 10*SizeDefault.scaleWidth),
                          _wButtonsLink(bank)
                        ],
                      ),
                    ),
                    widgetTrailing: selected
                    ?SizedBox(
                      width: 50*SizeDefault.scaleWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _wIconButton(
                            icon: Icon(
                              Icons.edit,
                              color: ColorsDefault.colorIcon,
                              size: SizeDefault.sizeIconButton,
                            ), 
                            onPressed: ()async{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return ScreenRegistrationBank();
                                  }
                                )
                              );
                            }
                          ),
                          _wIconButton(
                            icon: Icon(
                              Icons.delete,
                              color: ColorsDefault.colorTextError,
                              size: SizeDefault.sizeIconButton,
                            ), 
                            onPressed: ()async{
                              bool responseOk=await context.read<BankAccountProvider>().deleteBank();
                              if(responseOk){
                                ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Proceso realizado exitósamente"));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Error"));
                              }
                            }
                          ),
                        ],
                      ),
                    ):SizedBox(),
                  );
                },
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FIconButton(
                  icon: Icon(
                    Icons.add,
                    size: SizeDefault.sizeIconButton*1.5,
                    color: ColorsDefault.colorBackgroud,
                  ), 
                  onTap: (){
                    context.read<BankAccountProvider>().setBankSelected(Bank.empty());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return ScreenRegistrationBank();
                        }
                      )
                    );
                  }
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _wButtonsLink(Bank bank){
    return Container(
      width: 200*SizeDefault.scaleWidth,
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children: [
          _wIconButton(
            icon: Icon(
              Icons.apps_outlined,
              color: ColorsDefault.colorIcon,
              size: SizeDefault.sizeIconButton
            ),
            onPressed: (){
    
            }
          ),
          _wIconButton(
            icon: Icon(
              Icons.web,
              color: ColorsDefault.colorIcon,
              size: SizeDefault.sizeIconButton
            ),
            onPressed: (){
    
            }
          ),
          _wIconButton(
            icon: Icon(
              Icons.domain_verification_sharp,
              color: ColorsDefault.colorIcon,
              size: SizeDefault.sizeIconButton
            ),
            onPressed: (){
    
            }
          ),
        ]
      ),
    );
  
  }

   Widget _wIconButton({required Icon icon,required Function onPressed}){
    return IconButton(
      constraints: BoxConstraints(maxWidth: SizeDefault.sizeIconButton,maxHeight: SizeDefault.sizeIconButton),
      padding: EdgeInsets.zero,
      splashRadius: SizeDefault.sizeIconButton,
      onPressed:() => onPressed(), 
      icon: icon
    );
  }

  void onPressedUploadImage() async{
    /*final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );*/

    final file=await ImageUtils.uploadImage();
    if(file==null) return;

    setState(() {
      loadingImage=true;
      //widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=file; 
    });
    uploadImagen(file).then((value){
        image=value;
    }).onError((error, stackTrace) {
      loadingImage=false;
      setState(() {
        
      });
    }).whenComplete(() {
      setState(() {
        loadingImage=false;
      });
    });
  }
}