import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

import '../../../../data/services/images_repository.dart';
import '../../../../device/image_utils.dart';
class ContainerPlanImage extends StatefulWidget {
  ContainerPlanImage({Key? key,required this.title,required this.keyImage}) : super(key: key);
  final String keyImage;
  final String title;

  @override
  State<ContainerPlanImage> createState() => _ContainerPlanImageState();
}

class _ContainerPlanImageState extends State<ContainerPlanImage> {
  bool _loading=false;
  bool _activateButtons=false;
  final heightImage=515*SizeDefault.scaleHeight;
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    
    final linkImage=context.watch<RegistrationPropertyPlanProvider>().mapDocumentsPlansImage[widget.keyImage];
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
                child: TextStandard(text: widget.title, fontSize: 14*SizeDefault.scaleHeight,fontWeight: FontWeight.w600,),
              ),
              FXButton()
            ],
          ),
          _loading
          ?_wLoading(height: heightImage)
          :linkImage==""?_wButtonAdd(context: context,height: heightImage):_wImage(context: context, height: heightImage),
        ],
      ),
    );
  }

  Widget _wButtonAdd({required BuildContext context,required double height}) {
    return InkWell(
      onTap: (){
        _onPressed(context: context);
      },
      child: Container(
        width: double.infinity,
        height: heightImage,
        margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight),
        color: ColorsDefault.colorButtonAddImage,
        child: Center(
          child: Icon(Icons.add,size: 60*SizeDefault.scaleHeight,color:ColorsDefault.colorIcon),
        ),
      ),
    );
  }

  Widget _wLoading({required double height}){
    return Container(
      width: double.infinity,
      height: heightImage,
      margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight),
      color: ColorsDefault.colorButtonAddImage,
      child: Center(
        child: CupertinoActivityIndicator(
          radius:SizeDefault.radiusCircularIndicator
        )
      ),
    );
  }

  Widget _wImage({required BuildContext context, required double height}){
    return InkWell(
      onLongPress: (){
        if(!_activateButtons){
           setState(() {
            _activateButtons=true;
          });
        }
      },
      onTap: (){
        if(_activateButtons){
          setState(() {
            _activateButtons=false;
          });
        }
      },
      child: Container(
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
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: NetworkImage(context.read<RegistrationPropertyPlanProvider>().mapDocumentsPlansImage[widget.keyImage])
          ),
        ),
        child: _activateButtons
        ?Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: SizeDefault.swidth*0.92,
                height: 60*SizeDefault.scaleWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40*SizeDefault.scaleWidth,
                      width: 140*SizeDefault.scaleWidth,
                      child: ButtonPrimary(
                        text: "Quitar imágen", 
                        color: ColorsDefault.colorTextError,
                        onPressed: (){
                          _onPressedDelete(context: context);
                        }
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ):SizedBox(),
      ),
    );
  }

  void _onPressed({required BuildContext context}) async{
    try{
      final file=await ImageUtils.uploadImage(ratioX: 21.59,ratioY: 27.94);
      if(file==null) return;
      context.read<RegistrationPropertyProvider>();
      setState(() {
        _loading=true;
      });
      uploadImagen(file).then((linkD){
        _loading=false;
        context.read<RegistrationPropertyPlanProvider>().setMapDocumentPlansImageItem(key: widget.keyImage, value: linkD);
      });
    }catch(e){
    log(e.toString());
    }
  }

  void _onPressedDelete({required BuildContext context}) async{
    try{
      context.read<RegistrationPropertyPlanProvider>().setMapDocumentPlansImageItem(key: widget.keyImage, value: "");
      setState(() {
        _activateButtons=false;
      });
    }catch(e){
      log(e.toString());
    }
  }
}