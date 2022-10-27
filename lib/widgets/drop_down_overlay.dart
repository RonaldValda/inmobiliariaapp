import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
class DropDownOverlay{
  OverlayEntry? entry;
  double heightOverlay=0.0;
  double heightDropDownItem=70;

  set sHeightOverlay(double heightOverlay) => this.heightOverlay=heightOverlay;
  set sHeightDropDownItem(double heightDropDownItem) => this.heightDropDownItem=heightDropDownItem;

  void showOverlay({required BuildContext context,required LayerLink layerLink,required VoidCallback onTapBarrierDismissible,required Widget widgetOverlay,double width=0}){
    final overlay=Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size=renderBox.size;
    entry=OverlayEntry(
      builder: (context) => Stack(
        fit: StackFit.expand,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTapBarrierDismissible
            ),
            
          ),
          Positioned(
            width: width==0?size.width:width,
            height: heightOverlay,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: true,
              offset: Offset(0,size.height+SizeDefault.heightSeparatedDropDown),
              /*Offset(0,
              (offset1.dy+size.height+heightOverlay+WidgetDefaults.heightSeparatedDropDown)>WidgetDefaults.sheight
              ?-heightOverlay-WidgetDefaults.heightSeparatedDropDown
              :size.height+WidgetDefaults.heightSeparatedDropDown),*/
              child: buildOverlay(widgetOverlay),
            )
          ),
        ],
      ),
    );
    overlay!.insert(entry!);
  }

  void hideOverlay(){
    entry?.remove();
    entry=null;
  }

  Widget buildOverlay(Widget widgetOverlay) => Material(
    borderRadius: BorderRadius.circular(7),
    color: ColorsDefault.colorBackgroud,
    elevation: 8,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7)
      ),
      padding: EdgeInsets.symmetric(vertical:10*SizeDefault.scaleHeight),
      child: widgetOverlay
    ),
  );
}