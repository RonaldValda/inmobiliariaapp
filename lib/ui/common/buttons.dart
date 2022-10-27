import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
class ButtonPrimary extends StatefulWidget {
  ButtonPrimary({Key? key,required this.text,required this.onPressed,this.color,this.colorText,this.fontSize}) : super(key: key);
  final String text;
  final Function onPressed;
  final Color? color;
  final Color? colorText;
  final double? fontSize;
  @override
  State<ButtonPrimary> createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55*SizeDefault.scaleHeight,
      decoration: BoxDecoration(
        color: widget.color??ColorsDefault.colorPrimary,
        borderRadius: BorderRadius.circular(20), 
      ),
      child: ElevatedButton(
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(
            color: widget.colorText==null?ColorsDefault.colorBackgroud:widget.colorText,
            fontSize: widget.fontSize??SizeDefault.fSizeButton
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>( 
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          //minimumSize: MaterialStateProperty.all(Size(150, 50)),
          backgroundColor:
          MaterialStateProperty.all(Colors.transparent),
          shadowColor:MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed:()=>widget.onPressed(),
      ),
    );
  }
}

class FButtonPrimaryIcon extends StatefulWidget {
  FButtonPrimaryIcon({Key? key,this.text,required this.onPressed,this.color,this.colorText,this.fontSize,required this.icon}) : super(key: key);
  final String? text;
  final Function onPressed;
  final Color? color;
  final Color? colorText;
  final double? fontSize;
  final Widget icon;
  @override
  State<FButtonPrimaryIcon> createState() => _FButtonPrimaryIconState();
}

class _FButtonPrimaryIconState extends State<FButtonPrimaryIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55*SizeDefault.scaleHeight,
      decoration: BoxDecoration(
        color: widget.color??ColorsDefault.colorPrimary,
        borderRadius: BorderRadius.circular(20), 
      ),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            if(widget.text!=null)
            Text(
              widget.text!,
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                color: widget.colorText==null?ColorsDefault.colorBackgroud:widget.colorText,
                fontSize: widget.fontSize??SizeDefault.fSizeButton
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>( 
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          //minimumSize: MaterialStateProperty.all(Size(150, 50)),
          backgroundColor:
          MaterialStateProperty.all(Colors.transparent),
          shadowColor:MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed:()=>widget.onPressed(),
      ),
    );
  }
}

class ButtonOutlinedPrimary extends StatefulWidget {
  ButtonOutlinedPrimary({Key? key,required this.text,this.color,this.fontSize,required this.onPressed,this.onLongPress}) : super(key: key);
  final String text;
  final Function onPressed;
  final Function? onLongPress;
  final Color? color;
  final double? fontSize;

  @override
  State<ButtonOutlinedPrimary> createState() => _ButtonOutlinedPrimaryState();
}

class _ButtonOutlinedPrimaryState extends State<ButtonOutlinedPrimary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55*SizeDefault.scaleHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), 
      ),
      child: OutlinedButton(
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(
            color: widget.color??ColorsDefault.colorPrimary,
            fontSize: widget.fontSize??SizeDefault.fSizeButton
          ),
        ), 
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          side: BorderSide(
            color: widget.color??ColorsDefault.colorPrimary,
            width: 1*SizeDefault.scaleHeight
          )
        ),
        onPressed:(){widget.onPressed();},
        onLongPress: (){
          if(widget.onLongPress!=null){
            widget.onLongPress!();
          }
        }
      ),
    );
  }
}

class FButtonOutlinedIcon extends StatefulWidget {
  FButtonOutlinedIcon({Key? key,required this.text,this.color,required this.icon,this.isBeforeIcon=false,required this.onPressed}) : super(key: key);
  final String text;
  final Function onPressed;
  final Color? color;
  final IconData icon;
  final bool isBeforeIcon;

  @override
  State<FButtonOutlinedIcon> createState() => _FButtonOutlinedIconState();
}

class _FButtonOutlinedIconState extends State<FButtonOutlinedIcon> {
  @override
  Widget build(BuildContext context) {
    Widget icon=Icon(
      widget.icon,
      color: widget.color??ColorsDefault.colorPrimary,
      size: SizeDefault.sizeIconButton,
    );
    return Container(
      width: double.infinity,
      height: 60*SizeDefault.scaleHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), 
      ),
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.isBeforeIcon?icon:Container(),
            Text(
              widget.text,
              style: GoogleFonts.notoSans(
                color: widget.color??ColorsDefault.colorPrimary,
                fontSize: SizeDefault.fSizeStandard,
                fontWeight: FontWeight.w500
              ),
            ),
            !widget.isBeforeIcon?icon:Container(),
          ],
        ), 
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          primary: widget.color??ColorsDefault.colorPrimary,
          side: BorderSide(
            color: widget.color??ColorsDefault.colorPrimary,
            width: 2*SizeDefault.scaleHeight
          )
        ),
        onPressed:(){widget.onPressed();},
      ),
    );
  }
}

class TextButtonPrimary extends StatefulWidget {
  TextButtonPrimary({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);
  final String text;
  final Function onPressed;

  @override
  State<TextButtonPrimary> createState() => _TextButtonPrimaryState();
}

class _TextButtonPrimaryState extends State<TextButtonPrimary> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 50,
      height: 35*SizeDefault.scaleHeight,
      child: TextButton(
        style: TextButton.styleFrom(
         // minimumSize: Size(double.maxFinite,35)
         padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth)
        ),
        onPressed: (){
          widget.onPressed();
        },
        child: Text(
          widget.text,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.aBeeZee(
            fontSize: 16*SizeDefault.scaleHeight,
            color: ColorsDefault.colorPrimary,
          )
        )
      ),
    );
  }
}

class ButtonColor extends StatefulWidget {
  ButtonColor({Key? key,required this.text,required this.onPressed}) : super(key: key);
  final String text;
  final Function onPressed;
  @override
  State<ButtonColor> createState() => _ButtonColorState();
}

class _ButtonColorState extends State<ButtonColor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60*SizeDefault.scaleHeight,
      decoration: BoxDecoration(
        color: ColorsDefault.colorPrimary,
        borderRadius: BorderRadius.circular(20), 
      ),
      child: ElevatedButton(
        
        child: Text(
          widget.text,
          style: GoogleFonts.aBeeZee(
            color: ColorsDefault.colorBackgroud,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>( 
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          //minimumSize: MaterialStateProperty.all(Size(150, 50)),
          backgroundColor:
          MaterialStateProperty.all(Colors.transparent),
          shadowColor:MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed:()=>widget.onPressed,
      ),
    );
  }
}

class FBackButton extends StatelessWidget {
  const FBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: SizeDefault.sizeIconAppBar,
      splashRadius: SizeDefault.sizeIconAppBar/1.5,
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: ColorsDefault.colorIcon,
        size: 35*SizeDefault.scaleWidth,
      ),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
}

class FXButton extends StatelessWidget {
  const FXButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10*SizeDefault.scaleHeight),
        decoration: BoxDecoration(
          color: ColorsDefault.colorPrimary,
          borderRadius: BorderRadius.circular(50)
        ),
        child: Icon(Icons.close, size: SizeDefault.sizeIconButton,color: ColorsDefault.colorBackgroud,),
      ),
    );
  }
}

class FIconButton extends StatelessWidget {
  const FIconButton({Key? key,required this.icon,this.color,required this.onTap}) : super(key: key);
  final Widget icon;
  final Function onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(10*SizeDefault.scaleHeight),
        decoration: BoxDecoration(
          color: color??ColorsDefault.colorPrimary,
          borderRadius: BorderRadius.circular(50)
        ),
        child: icon,
      ),
    );
  }
}