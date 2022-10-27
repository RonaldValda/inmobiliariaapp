
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/administrator/actions_administrator.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/administrator/fab_administrator.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/buyer/properties_similars.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/seller/fab_seller.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/buyer/icons_access_user.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/common/images_tab_bar.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'widgets/common/features_info_detail.dart';
import 'widgets/common/features_property.dart';
import 'widgets/seller/actions_seller.dart';
class ScreenViewProperty extends StatefulWidget {
  ScreenViewProperty({Key? key}) : super(key: key);

  @override
  _ScreenViewPropertyState createState() => _ScreenViewPropertyState();
}

class _ScreenViewPropertyState extends State<ScreenViewProperty> with TickerProviderStateMixin{
  double minHeightSliding=0.0;
  double maxHeightSliding=0.0;
  double minHeightSlidingDefecto=0.0;
  PanelController panelController=PanelController();
  double imageHeight=SizeDefault.swidth*0.7;
  double imageWidth=SizeDefault.swidth;
  bool isVertical=true;
  @override
  void initState() { 
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final property=context.read<PropertiesProvider>().propertyTotalLast.property;
      context.read<PropertiesWidgetProvider>().init(this,property,imageWidth,imageHeight);
      setState(() {
        
      });
    });
    super.initState();
    
    
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final propertiesWidgetProvider=context.watch<PropertiesWidgetProvider>();
    final propertiesProvider=context.watch<PropertiesProvider>();
    final propertyTotal=propertiesProvider.propertyTotalLast;
    final user=Provider.of<UserProvider>(context);
    if(propertiesWidgetProvider.changeSliding){
      if(propertiesWidgetProvider.featuresSelected>=0){
        if(isVertical){
          minHeightSlidingDefecto=(MediaQuery.of(context).size.height-MediaQuery.of(context).size.width*0.7-250);
          maxHeightSliding=MediaQuery.of(context).size.height-MediaQuery.of(context).size.width*0.7-100;
        }else{
           maxHeightSliding=MediaQuery.of(context).size.height-100;
        }
        minHeightSliding=0;
        int milliseconds=((maxHeightSliding-minHeightSliding)*0.6).toInt();
        if(milliseconds<0){
          milliseconds=0;
        }
        panelController.animatePanelToSnapPoint(duration:Duration(milliseconds: milliseconds));
     }else{
        minHeightSliding=0.0;
        maxHeightSliding=0.0;
      }
    }
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      isVertical=true;
      imageWidth=MediaQuery.of(context).size.width;
      imageHeight=imageWidth*0.7;
    }else{
      isVertical=false;
      imageHeight=MediaQuery.of(context).size.height*.8;
      imageWidth=MediaQuery.of(context).size.width/1.9;
    }
    return WillPopScope(
      onWillPop: ()async{
        if(propertiesProvider.propertiesStack.length<2){
          Navigator.pop(context);
          return false;
        }else{
          propertiesProvider.removePropertiesStack(context: context);
          return false;
        }
      },
      child: _wScaffold(context, propertyTotal, user, propertiesWidgetProvider)
    );
  }

  Scaffold _wScaffold(BuildContext context, PropertyTotal propertyTotal, UserProvider user, PropertiesWidgetProvider propertiesWidgetProvider) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
     floatingActionButton:  propertiesWidgetProvider.featuresSelected<0?user.sessionType=="Vender"?FABSeller():FABAdministrator():SizedBox(),
     body: SafeArea(
       //maintainBottomViewPadding: true,
       top: true,
       bottom: false,
       minimum: EdgeInsets.zero,
       
       child: SlidingUpPanel(
         body: Container(
           padding: EdgeInsets.only(bottom: 25*SizeDefault.scaleWidth),
           child:Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Expanded(
                       child: Column(
                         children: [
                          ImagesTabBar(propertyTotal:propertyTotal),
                            user.sessionType=="Comprar"?IconsAccesUser(propertyTotal:propertyTotal):Container(),
                            if(isVertical)
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  SizedBox(height: 5*SizeDefault.scaleHeight),
                                  FeaturesProperty(),
                                  SizedBox(height: 20*SizeDefault.scaleHeight),
                                  if(MediaQuery.of(context).size.height<1100)
                                    user.sessionType=="Comprar"?
                                    PropertiesSimilars()
                                    :Container(),
                                ],
                              ),
                            ),
                         ],
                       ),
                     ),
                     if(MediaQuery.of(context).size.height>1100)
                     user.sessionType=="Comprar"?
                     PropertiesSimilars()
                     :Container(),
                     user.sessionType=="Administrar"||user.sessionType=="Supervisar"
                     ?Row(
                       mainAxisAlignment:MainAxisAlignment.start,
                       children: [
                         ActionsAdminitrator()
                       ],
                     ):
                     user.sessionType=="Vender"?
                     Row(
                       mainAxisAlignment:MainAxisAlignment.start,
                       children: [
                        ActionsSeller()
                       ],
                     ):Container(),
                     //AccionesSolicitudes(inmuebleTotal: widget.inmuebleTotal)
                   ],
                 ),
               ),
                if(!isVertical)
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width-imageWidth,
                  child: Column(
                    children: [
                      SizedBox(height:MediaQuery.of(context).size.height/60),
                      Expanded(
                        child: ListView(
                          children: [
                            FeaturesProperty(),
                            Divider(),
                            SizedBox(height:MediaQuery.of(context).size.height/30),
                            if(MediaQuery.of(context).size.height<1100)
                              user.sessionType=="Comprar"?
                              PropertiesSimilars()
                              :Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
             ],
           )
         ),
         header: Container(
           height: 20,
           width: isVertical?MediaQuery.of(context).size.width:MediaQuery.of(context).size.width-imageWidth,
           child: Center(
             child: Container(
               width: 30,
               height: 5,
               decoration: BoxDecoration(
                 color: Colors.grey[300],
                 borderRadius:BorderRadius.circular(12)
               ),
             ),
           ),
         ),
         margin: isVertical?EdgeInsets.only(left: 0,right: 0):EdgeInsets.only(left: imageWidth,right: 0),
         parallaxOffset:5,
         snapPoint: .6,
         //defaultPanelState: PanelState.OPEN,
         panelSnapping: true,
         borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
         minHeight: minHeightSliding,
         maxHeight: maxHeightSliding,
         onPanelClosed: (){
           propertiesWidgetProvider.setChangeSliding(false);
           propertiesWidgetProvider.setFeaturesSelected(-1);
         },
         controller: panelController,
         isDraggable: true,
         backdropTapClosesPanel: true,
         panelBuilder: (controller) {
          return Card(
            color: Colors.transparent,
            elevation: 20,
            shadowColor: Colors.white,
            borderOnForeground: true,
            semanticContainer: true,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),),
                color: Colors.white
              ),
              child: ListView(
                controller: controller,
                children: [
                  FeaturesInfoDetail(propertyTotal: propertyTotal)
                ],
              ),
            ),
          );
        },
       ),
     ),
  );
  }
}
