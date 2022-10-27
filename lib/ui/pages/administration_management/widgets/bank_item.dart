import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
class BankItem extends StatefulWidget {
  BankItem({Key? key,required this.bank}) : super(key: key);
  final BankAccount bank;
  @override
  _BankItemState createState() => _BankItemState();
}

class _BankItemState extends State<BankItem> {
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
                  image: NetworkImage(widget.bank.logoImageLink),
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
                       Text(widget.bank.bankName)
                     ],
                   ),
                   Row(
                     children: [
                       Text("Numero cuenta : "),
                       Text(widget.bank.accountNumber)
                     ],
                   ),
                   Row(
                     children: [
                       Text("Titular : "),
                       Text(widget.bank.owner)
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