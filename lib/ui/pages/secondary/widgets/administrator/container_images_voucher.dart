
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
class ContainerImagesVoucher extends StatefulWidget {
  ContainerImagesVoucher({Key? key,required this.title,required this.linkImage}) : super(key: key);
  final String title;
  final dynamic linkImage;

  @override
  State<ContainerImagesVoucher> createState() => _ContainerImagesVoucherState();
}

class _ContainerImagesVoucherState extends State<ContainerImagesVoucher> {
  final heightImage=515*SizeDefault.scaleHeight;
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    print("link ${widget.linkImage}");
    return Container(
      width: double.infinity,
      height: 590*SizeDefault.scaleHeight,
      padding: EdgeInsets.all(7*SizeDefault.scaleWidth),
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroud,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25),),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left:10*SizeDefault.scaleWidth),
                child: TextStandard(text: widget.title, fontSize: 14*SizeDefault.scaleHeight,fontWeight: FontWeight.bold,),
              ),
              FXButton()
            ],
          ),
          _wImage(context: context, height: heightImage),
        ],
      ),
    );
  }

  Widget _wImage({required BuildContext context, required double height}){
    return Container(
      width: double.infinity,
      height: heightImage,
      margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight),
      padding:EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsDefault.colorBorder,
          width: 0.3*SizeDefault.scaleHeight
        ),
        color: ColorsDefault.colorButtonAddImage,
      ),
      child: CachedNetworkImage(
        imageUrl: widget.linkImage,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context,text,progress){
          print(text);
          return CupertinoActivityIndicator(
            radius:SizeDefault.radiusCircularIndicator
          );
        },
      ),
    );
  }
}