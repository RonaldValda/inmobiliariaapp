import 'package:flutter/material.dart';
SnackBar showSnackBar(String texto){
  SnackBar snackBar=SnackBar(
    content: Text(texto),
    action: SnackBarAction(
      label: 'OK',
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