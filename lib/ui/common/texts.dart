import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
class TextError extends StatelessWidget {
  TextError({Key? key,required this.textLabel,this.lineTextHeight=1}) : super(key: key);
  final String textLabel;
  final double lineTextHeight;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: SizeDefault.paddingHorizontalText,top: SizeDefault.marginTopText),
      child: Text(
        textLabel,
        style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w400,
          fontSize: 13*SizeDefault.scaleHeight,
          color: ColorsDefault.colorTextError
        ),
      ),
    );
  }
} 

class TextTitle extends StatelessWidget {
  const TextTitle({Key? key,required this.text,required this.fontSize}) : super(key: key);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.notoSans(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: ColorsDefault.colorText,
      ),
    );
  }
}

class TextStandard extends StatelessWidget {
  const TextStandard({Key? key,required this.text,this.textAlign=TextAlign.left,required this.fontSize,this.fontWeight=FontWeight.w400,this.color,this.textDecoration,this.textOverflow}) : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow??TextOverflow.visible,
      style: GoogleFonts.notoSans(
        decoration: textDecoration??TextDecoration.none,
        decorationColor: color??ColorsDefault.colorText,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color??ColorsDefault.colorText,
      ),
    );
  }
}

class TextDrawer extends StatelessWidget {
  const TextDrawer({Key? key,required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: GoogleFonts.roboto(
        decorationColor: ColorsDefault.colorText,
        fontSize: 15*SizeDefault.scaleWidth,
        fontWeight: FontWeight.w600,
        color: ColorsDefault.colorText,
      ),
    );
  }
}

class TextInfoAlert extends StatelessWidget {
  const TextInfoAlert({Key? key,required this.text,this.textAlign=TextAlign.left,this.fontWeight=FontWeight.w400,this.color,this.textDecoration,this.textOverflow}) : super(key: key);
  final String text;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow??TextOverflow.visible,
      style: GoogleFonts.notoSans(
        decoration: textDecoration??TextDecoration.none,
        decorationColor: color??ColorsDefault.colorText,
        fontSize: 13*SizeDefault.scaleWidth,
        fontWeight: fontWeight,
        color: color??ColorsDefault.colorText,
        letterSpacing: 0.5,
        height: 1.5
      ),
    );
  }
}

class TextInfo extends StatelessWidget {
  const TextInfo({Key? key,required this.text,this.textAlign=TextAlign.left,required this.fontSize,this.fontWeight=FontWeight.w400,this.color}) : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.shareTech(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color??ColorsDefault.colorTextInfo,
      ),
    );
  }
}

class TextLabel extends StatelessWidget {
  TextLabel({Key? key,required this.textLabel,this.color,this.lineTextHeight=1,this.fontWeight=FontWeight.w300}) : super(key: key);
  final String textLabel;
  final color;
  final double lineTextHeight;
  final FontWeight fontWeight;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: SizeDefault.paddingHorizontalText,bottom: SizeDefault.marginBottomTextLabel),
      child: Text(
        textLabel,
        style: GoogleFonts.notoSans(
          fontSize: SizeDefault.fSizeLabel,
          fontWeight: fontWeight,
          color: color??ColorsDefault.colorTextLabel,
        ),
      ),
    );
  }
} 

class TextHint extends StatelessWidget {
  const TextHint({Key? key,required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'SharpGrotesk-20',
        fontSize: SizeDefault.fSizeHintTextField,
        fontWeight: FontWeight.w300,
        color: ColorsDefault.colorFontHintTextField,
      ),
    );
  }
}