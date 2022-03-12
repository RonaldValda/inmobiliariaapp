import 'package:flutter/material.dart';

class TextFFBasico extends StatefulWidget {
  TextFFBasico({Key? key,required this.controller,required this.labelText,
    required this.onChanged
  }) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  
  final Function onChanged;
  @override
  _TextFFBasicoState createState() => _TextFFBasicoState();
}

class _TextFFBasicoState extends State<TextFFBasico> {
  final color=Colors.black;
  final colorFill=Colors.white12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          
          controller: widget.controller,
          style: TextStyle(color: color.withOpacity(0.8),
            fontSize: 15
          ),
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            //counterText: controllerCII!.text.length.toString(),
            //hintText: "Capacidad de inversión inicial",

            hintStyle: TextStyle(color: color.withOpacity(0.8),fontSize: 15),
            filled: true,
            fillColor: colorFill,
            labelText: widget.labelText,
            labelStyle: TextStyle(
              fontSize: 18
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: color.withOpacity(0.5))
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: color.withOpacity(0.7))
            ),
            
          ),
          onChanged:(x){ widget.onChanged(x);},
    );
  }
  
}
class TextFFOnTap extends StatefulWidget {
  TextFFOnTap({Key? key,required this.controller,required this.label,required this.onTap,this.isEnabled=true}) : super(key: key);
  final TextEditingController controller;
  final String label;
  final bool isEnabled;
  final VoidCallback onTap;
  @override
  _TextFFOnTapState createState() => _TextFFOnTapState();
}

class _TextFFOnTapState extends State<TextFFOnTap> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        enabled: widget.isEnabled,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),
          filled: true,
          fillColor: Colors.transparent,
          labelText: widget.label,
          labelStyle: TextStyle(
            fontSize: 14
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.black.withOpacity(0.7))
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.blue.withOpacity(0.7))
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5))
          ),
        ),
        onTap:widget.onTap
      );
  }
}
class TextFieldIcono extends StatelessWidget {
  const TextFieldIcono({Key? key,required this.color,required this.colorFill,required this.hintText,required this.icono,required this.controller}) : super(key: key);
  final TextEditingController controller;
  final Color color;
  final Color colorFill;
  final String hintText;
  final IconData icono;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style:TextStyle(color: color),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            hintText: hintText,
            hintStyle: TextStyle(color: color),
            prefixIcon: Icon(icono,color: color,),
            filled: true,
            fillColor: colorFill,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: color.withOpacity(0.7))
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: color.withOpacity(0.7))
            ),
          ),
      ),
    );
  }
}