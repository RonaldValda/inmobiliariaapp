import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';
class BancoItem extends StatefulWidget {
  BancoItem({Key? key,required this.banco}) : super(key: key);
  final CuentaBanco banco;
  @override
  _BancoItemState createState() => _BancoItemState();
}

class _BancoItemState extends State<BancoItem> {
  @override
  Widget build(BuildContext context) {
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
                  image: NetworkImage(widget.banco.linkImagenLogo),
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
                       Text(widget.banco.nombreBanco)
                     ],
                   ),
                   Row(
                     children: [
                       Text("Numero cuenta : "),
                       Text(widget.banco.numeroCuenta)
                     ],
                   ),
                   Row(
                     children: [
                       Text("Titular : "),
                       Text(widget.banco.titular)
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