import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/colors_default.dart';
import '../../../common/size_default.dart';
import '../../../provider/registration_property/registration_property_widget_provider.dart';
import '../../../provider/registration_property/step_category.dart';
class TabBarRegistrationProperty extends StatelessWidget {
  const TabBarRegistrationProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetProvider=context.read<RegistrationPropertyWidgetProvider>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth),
      color: ColorsDefault.colorBackgroud,
      height: 50*SizeDefault.scaleHeight,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        controller: widgetProvider.scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widgetProvider.steps.length,
        itemBuilder: (context, index) {
          final step=widgetProvider.steps[index];
          return Row(
            children: [
              TabBarItemStep(step: step),
              index<widgetProvider.steps.length-1
              ?_wIconArrowForward():Container(),
            ],
          );
        },
      ),
    );
  }

  Widget _wIconArrowForward() {
    return Container(
      margin: EdgeInsets.only(left: 10*SizeDefault.scaleWidth),
      width: 30*SizeDefault.scaleHeight,
      height: 30*SizeDefault.scaleHeight,
      alignment: Alignment.center,
      child: Icon(
        Icons.arrow_forward_ios,
        color: ColorsDefault.colorText,
        size: 25*SizeDefault.scaleHeight,
      ),
    );
  }
}

class TabBarItemStep extends StatefulWidget {
  TabBarItemStep({Key? key,required this.step}) : super(key: key);
  final StepRegistrationProperty step;
  @override
  _TabBarItemStepState createState() => _TabBarItemStepState();
}

class _TabBarItemStepState extends State<TabBarItemStep> {
  
  @override
  Widget build(BuildContext context) {

    return InkWell(
      splashColor: Colors.green,
      highlightColor: Colors.black,
      customBorder: StadiumBorder(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleHeight,vertical: 2*SizeDefault.scaleWidth),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20*SizeDefault.scaleHeight,
              backgroundColor: ColorsDefault.colorPrimary,
              child: Text(widget.step.number.toString(),
                style: GoogleFonts.notoSans(
                  fontSize: SizeDefault.fSizeStandard,
                  color:ColorsDefault.colorBackgroud,
                  fontWeight: widget.step.selected?FontWeight.bold:FontWeight.normal
                ),
            ),
            ),
            SizedBox(width: 5*SizeDefault.scaleWidth,),
            Text(widget.step.nameStep,
              style: GoogleFonts.notoSans(
                fontSize: SizeDefault.fSizeStandard,
                color:ColorsDefault.colorText,
                fontWeight: widget.step.selected?FontWeight.bold:FontWeight.normal
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: widget.step.selected?ColorsDefault.colorSelectedTab:ColorsDefault.colorBackgroud,
          //border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        ),
      ),
      onTap: (){
        context.read<RegistrationPropertyWidgetProvider>().selectStep(widget.step.number);
      },
    );
  }
}