import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
class SeeMoreButton extends StatefulWidget {
  SeeMoreButton({Key? key,required this.activate,required this.onTap}) : super(key: key);
  final bool activate;
  final VoidCallback onTap;

  @override
  State<SeeMoreButton> createState() => _SeeMoreButtonState();
}

class _SeeMoreButtonState extends State<SeeMoreButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: widget.onTap,
      child: Container(
        width: 120*SizeDefault.scaleHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextStandard(
              text: widget.activate?"Ver menos":"Ver más", 
              fontSize: 16*SizeDefault.scaleHeight,
              color: ColorsDefault.colorPrimary,
            ),
            TextStandard(
              text: widget.activate?"-":"+", 
              fontSize: 22*SizeDefault.scaleHeight,
              fontWeight: FontWeight.w700,
              color: ColorsDefault.colorPrimary,
            )
          ],
        ),
      ),
    );
  }
}