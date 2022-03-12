import "package:flutter/material.dart";
class PageVerificacionEmail extends StatefulWidget {
  PageVerificacionEmail({Key? key}) : super(key: key);

  @override
  _PageVerificacionEmailState createState() => _PageVerificacionEmailState();
}

class _PageVerificacionEmailState extends State<PageVerificacionEmail> {
  TextEditingController? controllerClave;
  @override
  void initState() {
    super.initState();
    controllerClave=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Verificación de Email"),
       ),
       body:Container(
         child: Column(
           children: [
             Container(
               child: Column(
                 children: [
                   Text("Introduzca el código de 6 dígitos que fue enviado a su correo"),
                   TextField(
                     controller: controllerClave,

                   ),
                 ],
               ),
             ),
             ElevatedButton(onPressed: (){}, child: Text("Siguiente"))
           ],
         ),
       ),
    );
  }
}