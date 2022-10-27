
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';

import '../ui/common/size_default.dart';
class PopupMenuCuentaBanco extends StatefulWidget {
  PopupMenuCuentaBanco({Key? key,required this.cuentaBanco,required this.bancos,
  required this.heightContainer,
  required this.widthContainer,required this.widthEtiqueta}) : super(key: key);
  final BankAccount cuentaBanco;
  final List<BankAccount> bancos;
  final double heightContainer;
  final double widthContainer;
  final double widthEtiqueta;
  @override
  _PopupMenuCuentaBancoState createState() => _PopupMenuCuentaBancoState();
}

class _PopupMenuCuentaBancoState extends State<PopupMenuCuentaBanco> {
  final color=Colors.black54;
  final colorFill=Colors.white12;
  String cuenta="Seleccione la cuenta";
  @override
  Widget build(BuildContext context) {
    cuenta=widget.cuentaBanco.bankName==""?"":"${widget.cuentaBanco.accountNumber} (${widget.cuentaBanco.bankName})";
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(textLabel: "Cuenta"),
            Container(
                height: widget.heightContainer,
                width: widget.widthContainer,
                padding:EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorsDefault.colorBorder,width: 1*SizeDefault.scaleHeight),
                  borderRadius: BorderRadius.circular(7),
                  color: ColorsDefault.colorTextFieldBackground
                ),
                child: PopupMenuButton(
                  tooltip: "Seleccione cuenta de banco",
                  elevation: 30,
                  offset: const Offset(0, 40),
                  color: Colors.white.withOpacity(0.8),
                  enableFeedback: false,
                  onCanceled: (){
                    setState(() {
                      cuenta="${widget.cuentaBanco.accountNumber} (${widget.cuentaBanco.bankName})";
                    });
                  },
                  //icon:Icon(Icons.more_vert),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      cuenta,
                      style: GoogleFonts.notoSans(
                        color: ColorsDefault.colorText,
                        fontSize: SizeDefault.fSizeStandard
                      ),
                    )
                  ),
                  //icon: iconc.FaIcon(iconc.FontAwesomeIcons.dollarSign,size: 20,),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context){
                    return [
                      PopupMenuItem<int>(
                        padding: EdgeInsets.all(5),
                        value: 0, 
                        child: PopupMenuItemCuentasBancos(bancos: widget.bancos,cuentaBanco: widget.cuentaBanco,)
                      ),
                    ];
                  }
                ),
              ),
          ],
        ),
      );
  }
}
class PopupMenuItemCuentasBancos extends StatelessWidget {
  const PopupMenuItemCuentasBancos({Key? key,required this.cuentaBanco,required this.bancos}) : super(key: key);
  final BankAccount cuentaBanco;
  final List<BankAccount> bancos;
  @override
  Widget build(BuildContext context) {
    print(bancos.length);
    return Container(
      height: bancos.length*60,
      //height: MediaQuery.of(context).size.height/5,
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bancos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextStandard(
                    text: "Nº Cuenta: ${bancos[index].accountNumber}", 
                    fontSize: 18*SizeDefault.scaleHeight,
                    fontWeight: FontWeight.w600,
                  ),
                  //title: Text("Nº Cuenta: ${bancos[index].numeroCuenta}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStandard(
                        text: "Entidad Financiera: ${bancos[index].bankName}", 
                        fontSize: 16*SizeDefault.scaleHeight,
                      ),
                      TextStandard(
                        text: "Titular Cuenta: ${bancos[index].owner}", 
                        fontSize: 16*SizeDefault.scaleHeight,
                      ),
                    ],
                  ),
                  onTap: (){
                    cuentaBanco.cuentaBancoCopy(bancos[index]);
                    Navigator.pop(context);
                  },
                  
                );
              },
            ),
          )
        ],
      ),
    );
  }
}