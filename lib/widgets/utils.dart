import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
SnackBar showSnackBar(String texto,{Color? colorText}){
  SnackBar snackBar=SnackBar(
    dismissDirection: DismissDirection.vertical,
    elevation: 5,
    backgroundColor: ColorsDefault.colorText,
    content: TextStandard(
      text:texto,
      fontSize: 11*SizeDefault.scaleWidth,
      color: colorText??ColorsDefault.colorBackgroud,
    ),
    action: SnackBarAction(
      label: 'OK',
      textColor: ColorsDefault.colorBackgroud,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  return snackBar;
}
class IconoNumeroNotificacion extends StatelessWidget {
  const IconoNumeroNotificacion({Key? key,required this.numeroNotificaciones,required this.size}) : super(key: key);
  final String numeroNotificaciones;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffc32c37),
            border: Border.all(color: Colors.white, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Text(
            numeroNotificaciones,
            style: TextStyle(fontSize: 13,color: Colors.white),
          ),
        ),
      ),
      
    );
  }
}