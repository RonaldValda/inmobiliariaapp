import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
class SelectorsButtons extends StatefulWidget {
  SelectorsButtons({Key? key,required this.text,required this.selected,required this.options,required this.onChanged}) : super(key: key);
  final int selected;
  final List<int> options;
  final Function onChanged;
  final String text;

  @override
  State<SelectorsButtons> createState() => _SelectorsButtonsState();
}

class _SelectorsButtonsState extends State<SelectorsButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextStandard(text: widget.text, fontSize: SizeDefault.fSizeStandard,fontWeight: FontWeight.w300,),
          SizedBox(height: 5*SizeDefault.scaleWidth,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.options.map((e) {
              final lastIndex=widget.options.lastIndexOf(e);
              return InkWell(
                onTap: (){
                  widget.onChanged(e);
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 40*SizeDefault.scaleHeight,
                  height: 40*SizeDefault.scaleHeight,
                  margin: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleHeight),
                  decoration: BoxDecoration(
                    color: e==widget.selected?ColorsDefault.colorPrimary:ColorsDefault.colorBackgroud,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 2*SizeDefault.scaleHeight,
                      color: ColorsDefault.colorPrimary
                    )
                  ),
                  alignment: Alignment.center,
                  child: TextStandard(
                    textAlign: TextAlign.center,
                    text: lastIndex==widget.options.length-1?"${e.toString()}+":e.toString(), 
                    fontSize: 16*SizeDefault.scaleHeight,
                    color: e==widget.selected?ColorsDefault.colorBackgroud:ColorsDefault.colorPrimary,
                    fontWeight: e==widget.selected?FontWeight.w700:FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}