import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
class ButtonIconNotificationRequests extends StatefulWidget {
  ButtonIconNotificationRequests({Key? key,required this.existsNotification,required this.onTap}) : super(key: key);
  final bool existsNotification;
  final Function onTap;
  @override
  State<ButtonIconNotificationRequests> createState() => _ButtonIconNotificationRequestsState();
}

class _ButtonIconNotificationRequestsState extends State<ButtonIconNotificationRequests> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: EdgeInsets.zero,
        width:50*SizeDefault.scaleHeight,
        height:50*SizeDefault.scaleHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Icon(
              Icons.notifications_rounded,
              color: ColorsDefault.colorIcon,
              size: 40*SizeDefault.scaleHeight,
            ),
            widget.existsNotification
            ?Positioned(
              top: 6*SizeDefault.scaleHeight,
              right: 8*SizeDefault.scaleHeight,
              child: Container(
                width: 12*SizeDefault.scaleHeight,
                height: 12*SizeDefault.scaleHeight,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorsDefault.colorTextError,
                  border: Border.all(width: 1*SizeDefault.scaleHeight,color: ColorsDefault.colorBackgroud)
                ),
                alignment: Alignment.center,
              ),
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}