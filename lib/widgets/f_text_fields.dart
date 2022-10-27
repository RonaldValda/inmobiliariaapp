import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';

class FTextFieldBasico extends StatefulWidget {
  FTextFieldBasico({Key? key,required this.controller,required this.labelText,this.errorText="",this.textInputType=TextInputType.text,this.enabled=true,
    required this.onChanged
  }) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final Function onChanged;
  final String errorText;
  final TextInputType textInputType;
  final bool enabled;
  @override
  _FTextFieldBasicoState createState() => _FTextFieldBasicoState();
}

class _FTextFieldBasicoState extends State<FTextFieldBasico> {
  Color _colorEnabledBorder=ColorsDefault.colorBorder;
  Color _colorFocusedBorder=ColorsDefault.colorPrimary;
  void _selectConfig(){
    _colorFocusedBorder=widget.errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
    if(widget.controller.text.length>0){
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
    }else{
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorBorder:ColorsDefault.colorTextError;
    }
  }
  @override
  Widget build(BuildContext context) {
    _selectConfig();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel(textLabel: widget.labelText),
        Container(
          height: SizeDefault.heightTextField,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            style: GoogleFonts.notoSans(
              color: ColorsDefault.colorText,
              fontSize: SizeDefault.fSizeStandard
            ),
            maxLines: 1,
            enabled: widget.enabled,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
              hintStyle: TextStyle(color: ColorsDefault.colorTextInfo,fontSize: SizeDefault.fSizeHintTextField),
              filled: true,
              fillColor: ColorsDefault.colorTextFieldBackground,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: _colorEnabledBorder,
                  width: SizeDefault.widthBorderTextEnabled
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: _colorFocusedBorder,
                  width: SizeDefault.widthBorderTextFocused
                )
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: ColorsDefault.colorBorderDisabled,
                  width: SizeDefault.widthBorderTextDisabled
                )
              ),
              
            ),
            onChanged:(x){ 
              widget.onChanged(x);
              setState(() {
                
              });
            },
          ),
        ),
        widget.errorText!=""?TextError(textLabel: widget.errorText):Container()
      ],
    );
  }
}
class FTextFieldOnTap extends StatefulWidget {
  FTextFieldOnTap({Key? key,required this.controller,required this.labelText,this.errorText="",this.enabled=true,
    required this.onTap
  }) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final String errorText;
  final bool enabled;
  final onTap;
  @override
  _FTextFieldOnTapState createState() => _FTextFieldOnTapState();
}

class _FTextFieldOnTapState extends State<FTextFieldOnTap> {
  Color _colorEnabledBorder=ColorsDefault.colorBorder;
  Color _colorFocusedBorder=ColorsDefault.colorPrimary;
  double _widthEnableBorder=0.0;
  void _selectConfig(){
    _colorFocusedBorder=widget.errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
    if(widget.controller.text.length>0){
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
      _widthEnableBorder=1.5*SizeDefault.scaleHeight;
    }else{
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorBorder:ColorsDefault.colorTextError;
      _widthEnableBorder=1*SizeDefault.scaleHeight;
    }
  }
  @override
  Widget build(BuildContext context) {
    _selectConfig();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel(textLabel: widget.labelText),
        Container(
          height: 50*SizeDefault.scaleHeight,
          child: TextFormField(
            controller: widget.controller,
            onTap: widget.onTap,
            enabled: widget.enabled,
            style: GoogleFonts.notoSans(
              color: ColorsDefault.colorText,
              fontSize: SizeDefault.fSizeStandard
            ),
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
              hintStyle: TextStyle(color: ColorsDefault.colorTextInfo,fontSize: 15),
              filled: true,
              fillColor: ColorsDefault.colorTextFieldBackground,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),

                borderSide: BorderSide( color: _colorEnabledBorder,width: _widthEnableBorder),
                
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: _colorFocusedBorder,
                  width: 2*SizeDefault.scaleHeight
                )
              ),
              
            ),
          ),
        ),
        widget.errorText!=""?TextError(textLabel: widget.errorText):Container()
      ],
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
   TextFieldIcono({Key? key,
    required this.color,required this.colorFill,required this.hintText,required this.icono,required this.controller,this.onChanged
  }) : super(key: key);
  final TextEditingController controller;
  final Color color;
  final Color colorFill;
  final String hintText;
  final IconData icono;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
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

class FTextFieldPassword extends StatefulWidget {
  FTextFieldPassword({Key? key,
    required this.textLabel,
    required this.controller,
    this.hintText="",
    this.errorText="",
    this.focusNode,
    this.onChanged
  }) : super(key: key);

  final String textLabel;
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final focusNode;
  final onChanged;

  @override
  State<FTextFieldPassword> createState() => _FTextFieldPasswordState();
}

class _FTextFieldPasswordState extends State<FTextFieldPassword> {

  bool isObscureText=true;
  Color _colorEnabledBorder=ColorsDefault.colorBorder;
  Color _colorFocusedBorder=ColorsDefault.colorPrimary;
  double _widthEnableBorder=0.0;
  void _selectConfig(){
    _colorFocusedBorder=widget.errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
    if(widget.controller.text.length>0){
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
      _widthEnableBorder=1.5*SizeDefault.scaleHeight;
    }else{
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorBorder:ColorsDefault.colorTextError;
      _widthEnableBorder=1*SizeDefault.scaleHeight;
    }
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _selectConfig();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.textLabel==""?Container():TextLabel(textLabel: widget.textLabel),
          Container(
            height: SizeDefault.heightTextField,
            decoration: BoxDecoration(
              color: ColorsDefault.colorTextFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: TextField(
              focusNode: widget.focusNode,
              style: GoogleFonts.notoSans(
                color: ColorsDefault.colorText,
                fontSize: SizeDefault.fSizeStandard
              ),
              controller: widget.controller,
              obscureText: isObscureText,
              onChanged: (x){
                if(widget.onChanged!=null) widget.onChanged(x);
              },
              obscuringCharacter: "*",
              decoration: InputDecoration(
                hintTextDirection: TextDirection.ltr,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                  iconSize: 28*SizeDefault.scaleHeight,
                  icon: isObscureText?Icon(Icons.visibility_off,color: _colorEnabledBorder,):Icon(Icons.visibility,color: _colorEnabledBorder,),
                    onPressed: () =>setState(() => isObscureText=!isObscureText)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _colorEnabledBorder,
                    width: _widthEnableBorder
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _colorFocusedBorder,
                    width: 2*SizeDefault.scaleHeight
                  )
                ),
                border: OutlineInputBorder(),
                contentPadding:EdgeInsets.symmetric(vertical: 0,horizontal: SizeDefault.paddingHorizontalText)
              ),
            ),
          ),
          widget.errorText!=""?TextError(textLabel: widget.errorText):Container()
        ],
      ),
    );
  }
}

class FTextFieldOnTapDisabled extends StatefulWidget {
  FTextFieldOnTapDisabled({
    Key? key,
    required this.text,
    required this.labelText,
    this.errorText="",
    required this.onTap
  }) : super(key: key);
  final String text;
  final String labelText;
  final String errorText;
  final Function onTap;

  @override
  _FTextFieldOnTapDisabledState createState() => _FTextFieldOnTapDisabledState();
}

class _FTextFieldOnTapDisabledState extends State<FTextFieldOnTapDisabled> {
  Color _colorEnabledBorder=ColorsDefault.colorBorder;
  void _selectConfig(){
    if(widget.text.length>0){
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
    }else{
      _colorEnabledBorder=widget.errorText==""?ColorsDefault.colorBorder:ColorsDefault.colorTextError;
    }
  }
  @override
  Widget build(BuildContext context) {
    _selectConfig();
    return  InkWell(
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(textLabel: widget.labelText),
            Container(
              padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
              height: SizeDefault.heightTextField,
              decoration: BoxDecoration(
                border: Border.all(color: _colorEnabledBorder,width: SizeDefault.widthBorderTextEnabled),
                borderRadius: BorderRadius.circular(7),
                color: ColorsDefault.colorTextFieldBackground
              ),
              child:Row(
                children: [
                  Text(
                    widget.text,
                    style: GoogleFonts.notoSans(
                      color: ColorsDefault.colorText,
                      fontSize: SizeDefault.fSizeStandard
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        widget.onTap();
      },
    );
  }
}