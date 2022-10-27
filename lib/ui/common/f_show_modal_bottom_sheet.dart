import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';

Future<void> fShowModalBottomSheet({
  required BuildContext context,
  required Widget widget
})async{
  return showModalBottomSheet(
     shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),),
    ),
    constraints: BoxConstraints(maxWidth: SizeDefault.swidth-SizeDefault.paddingHorizontalBody,maxHeight: 600),
    elevation: 50,
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context){
      return widget;
    }
  );
}