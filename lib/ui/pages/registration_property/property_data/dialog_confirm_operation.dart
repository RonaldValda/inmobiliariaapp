import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';

import '../../../common/size_default.dart';

Future<bool> dialogConfirmOperationProperty(
  BuildContext context,
  String textInfo,
)async{
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            children: [
              Container(
                width: 300*SizeDefault.scaleWidth,
                
                child: _ConfirmationOperation(textInfo: textInfo,)
              )
            ],
          );
        }
      );
    }
  ); 
}

class _ConfirmationOperation extends StatefulWidget {
  _ConfirmationOperation({Key? key,required this.textInfo}) : super(key: key);
  final String textInfo;
  @override
  State<_ConfirmationOperation> createState() => __ConfirmationOperationState();
}

class __ConfirmationOperationState extends State<_ConfirmationOperation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleHeight,vertical: 20*SizeDefault.scaleWidth),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20*SizeDefault.scaleWidth),
            child: TextInfoAlert(
              textAlign: TextAlign.center,
              text: widget.textInfo,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ButtonOutlinedPrimary(
                  text: "Cancelar",
                  onPressed: (){
                    Navigator.pop(context,false);
                  },
                )
              ),
              SizedBox(width: 10*SizeDefault.scaleWidth),
              Expanded(
                child: ButtonPrimary(
                  text: "Aceptar",
                  onPressed: (){
                    Navigator.pop(context,true);
                  },
                )
              )
            ],
          )
        ],
      ),
    );
  }
}