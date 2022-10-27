import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/banks/screen_registration_account_bank.dart';
import 'package:inmobiliariaapp/ui/provider/generals/bank_account_provider.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

class RegistrationAccountsBanks extends StatefulWidget {
  const RegistrationAccountsBanks({Key? key}) : super(key: key);

  @override
  _RegistrationAccountsBanksState createState() => _RegistrationAccountsBanksState();
}

class _RegistrationAccountsBanksState extends State<RegistrationAccountsBanks> {
   TextEditingController? controllerAccountNumber;
   TextEditingController? controllerOwnerName;
   TextEditingController? controllerBankName;
   bool _loading=true;
  @override
  void initState() {
    super.initState();
    controllerAccountNumber=TextEditingController(text: "");
    controllerOwnerName=TextEditingController(text: "");
    controllerBankName=TextEditingController(text: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BankAccountProvider>().init()
      .then((completed){
        if(completed){
          setState(() {
            _loading=false;
          });
        }else{

        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Cuentas de banco",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: _loading? 
      Container(
        color: ColorsDefault.colorBackgroud,
        child: Center(
          child: CupertinoActivityIndicator(
            radius: SizeDefault.radiusCircularIndicator,
          ),
        ),
      ):_wBody(context),
    );

  }

  Container _wBody(BuildContext context) {
    final bankAccounts=context.watch<BankAccountProvider>().bankAccounts;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bankAccounts.length,
              itemBuilder: (context,index){
                final bankAccount=bankAccounts[index];
                final bool selected=bankAccount.id==context.read<BankAccountProvider>().bankAccountSelected.id;
                return FListTileFull(
                  colorBackground: selected?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud,
                  widgetLeading: Container(
                    width: 50*SizeDefault.scaleWidth,
                    height: 50*SizeDefault.scaleWidth,
                    margin: EdgeInsets.only(right:10*SizeDefault.scaleWidth),
                    decoration: BoxDecoration(
                      color: ColorsDefault.colorBackgroud,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(bankAccount.logoImageLink),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  widgetContent: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _wRichTextInfo(label: "Titular: ",data: bankAccount.owner),
                        _wRichTextInfo(label: "Entidad: ",data: bankAccount.bankName),
                        _wRichTextInfo(label: "Nº cuenta: ",data: bankAccount.accountNumber),
                      ],
                    )
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
                                  return ScreenRegistrationAccountBank();
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
                            bool responseOk=await context.read<BankAccountProvider>().deleteBankAccount();
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
                  onTap: (){
                    context.read<BankAccountProvider>().setBankAccountSelected(bankAccount);
                  }
                );
              }
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
                  context.read<BankAccountProvider>().setBankAccountSelected(BankAccount.empty());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return ScreenRegistrationAccountBank();
                      }
                    )
                  );
                }
              )
            ],
          )
        ],
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

  RichText _wRichTextInfo({required String label,required String data}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: GoogleFonts.notoSans(
          color: ColorsDefault.colorText,
          fontSize: 11*SizeDefault.scaleWidth,
          fontWeight: FontWeight.w300
        ),
        children: [
          TextSpan(
            text: data,
              style: GoogleFonts.notoSans(
              color: ColorsDefault.colorText,
              fontSize: 11*SizeDefault.scaleWidth,
              fontWeight: FontWeight.w400
            ),
          )
        ]
      )
    );
  }



  Widget _wAccountItem({required BankAccount bankAccount}){
    return Container(
       width: MediaQuery.of(context).size.width/3,
       child: Card(
         elevation: 2,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               width: MediaQuery.of(context).size.width/3,
               height: MediaQuery.of(context).size.width/3,
               //color: Colors.grey[400],
               decoration: BoxDecoration(
                 image: DecorationImage(
                  image: NetworkImage(bankAccount.logoImageLink),
                  fit: BoxFit.cover
                )
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Text("Entidad : "),
                       Text(bankAccount.bankName)
                     ],
                   ),
                   Row(
                     children: [
                       Text("Numero cuenta : "),
                       Text(bankAccount.accountNumber)
                     ],
                   ),
                   Row(
                     children: [
                       Text("Titular : "),
                       Text(bankAccount.owner)
                     ],
                   ),
                 ],
               ),
             ),
             
           ],
         ),
       ),
    );
  }
}
