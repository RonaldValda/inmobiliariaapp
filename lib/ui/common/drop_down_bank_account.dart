import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/bank_account_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/drop_down_overlay.dart';
class DropDownBankAccount extends StatefulWidget {
  DropDownBankAccount({Key? key,required this.text,this.errorText="",required this.stateProvider,this.dropDownItemsCount=3}) : super(key: key);
  final dynamic stateProvider;
  final String text;
  final String errorText;
  final int dropDownItemsCount;

  @override
  State<DropDownBankAccount> createState() => _DropDownBankAccountState();
}

class _DropDownBankAccountState extends State<DropDownBankAccount> {
  DropDownOverlay dropDownOverlay=DropDownOverlay();
  final LayerLink layerLink=LayerLink();
  double heightOverlay=70;
  double heightDropDownItem=70*SizeDefault.scaleHeight;
  Color _colorEnabledBorder=ColorsDefault.colorBorder;

  void _selectConfig(bool selected,String errorText){
    if(selected){
      _colorEnabledBorder=errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
    }else{
      _colorEnabledBorder=errorText==""?ColorsDefault.colorBorder:ColorsDefault.colorTextError;
    }
  }

  void _sizing(int length){
    heightOverlay=length<widget.dropDownItemsCount?heightDropDownItem*length+20:heightDropDownItem*widget.dropDownItemsCount+20;
    dropDownOverlay.sHeightOverlay=heightOverlay;
    dropDownOverlay.sHeightDropDownItem=heightDropDownItem;
  }
  @override
  Widget build(BuildContext context) {
    BankAccount bankAccount=widget.stateProvider.bankAccount(context);
    _selectConfig(bankAccount.id=="", widget.errorText);
    final bankAccountProvider=context.read<BankAccountProvider>();
    //final filterMainProvider=context.watch<widget.stateProvider>();
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(textLabel: widget.text),
          InkWell(
            onTap: (){
              _sizing(bankAccountProvider.bankAccounts.length);
              dropDownOverlay.showOverlay(
                context: context, 
                layerLink: layerLink,
                onTapBarrierDismissible: (){
                  dropDownOverlay.hideOverlay();
                }, 
                widgetOverlay: wOverlay(context)
              );
            },
            child: Container(
              width: double.infinity,
              height: bankAccount.id==""?SizeDefault.heightDropDown:heightDropDownItem,
              decoration: BoxDecoration(
                color:ColorsDefault.colorTextFieldBackground,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  width: 1*SizeDefault.scaleHeight,
                  color: bankAccount.id!=""
                  ?ColorsDefault.colorPrimary:
                  _colorEnabledBorder,
                )
              ),
              //decoration: accountState.selectedValues[widget.attribute]==""?Styles.boxDecorationDropDown2:Styles.boxDecorationDropDownSelected2,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bankAccount.id==""
                  ?TextHint(text: "Seleccione")
                  :Expanded(
                    child: wDropDownItem(bankAccount)
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: ColorsDefault.colorText,
                    size: 30*SizeDefault.scaleHeight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Column wOverlay(BuildContext context) {
    final bankAccountProvider=context.read<BankAccountProvider>();
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            radius: Radius.circular(20),
            trackVisibility: false,
            interactive: true,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              separatorBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15*SizeDefault.scaleWidth),
                  child: Container(
                    width:double.infinity,
                    height: 1*SizeDefault.scaleHeight,
                    color: ColorsDefault.colorSeparatedDropDownItem,
                  ),
                );
              },
              itemCount: bankAccountProvider.bankAccounts.length,
              itemBuilder: (context,index){
                final b=bankAccountProvider.bankAccounts[index];
                return InkWell(
                  onTap: (){
                    dropDownOverlay.hideOverlay();
                    widget.stateProvider.setBankAccount(accountBank:b,context:context);
                    /*setState(() {
                      
                    });*/
                    
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth),
                    child: wDropDownItem(b),
                  )
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Container wDropDownItem(BankAccount bankAccount) {
    return Container(
      width: double.infinity,
      height: heightDropDownItem,
      padding: EdgeInsets.symmetric(vertical:7*SizeDefault.scaleHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          wRichTextInfo(label: "Titular de la cuenta: ",data: bankAccount.owner),
          wRichTextInfo(label: "Entidad financiera: ",data: bankAccount.bankName),
          wRichTextInfo(label: "Número de cuenta: ",data: bankAccount.accountNumber),
        ],
      )
    );
  }

  RichText wRichTextInfo({required String label,required String data}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: GoogleFonts.notoSans(
          color: ColorsDefault.colorText,
          fontSize: SizeDefault.fSizeStandard,
          fontWeight: FontWeight.w300
        ),
        children: [
          TextSpan(
            text: data,
              style: GoogleFonts.notoSans(
              color: ColorsDefault.colorText,
              fontSize: SizeDefault.fSizeStandard,
              fontWeight: FontWeight.w400
            ),
          )
        ]
      )
    );
  }
}