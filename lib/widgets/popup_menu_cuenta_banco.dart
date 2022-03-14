
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';
class PopupMenuCuentaBanco extends StatefulWidget {
  PopupMenuCuentaBanco({Key? key,required this.cuentaBanco,required this.bancos,
  required this.heightContainer,
  required this.widthContainer,required this.widthEtiqueta}) : super(key: key);
  final CuentaBanco cuentaBanco;
  final List<CuentaBanco> bancos;
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
    cuenta="${widget.cuentaBanco.nombreBanco} | ${widget.cuentaBanco.numeroCuenta}";
    return Container(
        height:widget.heightContainer,
        width: widget.widthContainer,
        //color:Colors.orange,
        child: Column(
          children: [
            Container(
              //color: Colors.red,
              width: widget.widthEtiqueta,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Cuenta ",
                  style: TextStyle(
                    color: color,
                  ),
                )
              ),
            ),
            Expanded(
              child: Container(
                height: widget.heightContainer,
                padding:EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: color,width: 1),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
                ),
                child: PopupMenuButton(
                  tooltip: "Seleccione cuenta de banco",
                  elevation: 30,
                  offset: const Offset(0, 40),
                  color: Colors.white.withOpacity(0.8),
                  enableFeedback: false,
                  onCanceled: (){
                    setState(() {
                      cuenta="${widget.cuentaBanco.nombreBanco} | ${widget.cuentaBanco.numeroCuenta}";
                    });
                  },
                  //icon:Icon(Icons.more_vert),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(cuenta,
                      style:TextStyle(
                        fontSize: 15,
                        color: color.withOpacity(0.8)
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
            ),
          ],
        ),
      );
  }
}
class PopupMenuItemCuentasBancos extends StatelessWidget {
  const PopupMenuItemCuentasBancos({Key? key,required this.cuentaBanco,required this.bancos}) : super(key: key);
  final CuentaBanco cuentaBanco;
  final List<CuentaBanco> bancos;
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
                  title: Text("Nº Cuenta: ${bancos[index].numeroCuenta}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Entidad Financiera: ${bancos[index].nombreBanco}"),
                      Text("Titular Cuenta: ${bancos[index].titular}")
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