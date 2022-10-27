import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/buttons.dart';
import '../../../common/colors_default.dart';
import '../../../common/size_default.dart';
import '../../../common/texts.dart';
import 'container_plans_payment.dart';
class ScreenRegistrationPropertyChoisePlan extends StatefulWidget {
  ScreenRegistrationPropertyChoisePlan({Key? key}) : super(key: key);

  @override
  State<ScreenRegistrationPropertyChoisePlan> createState() => _ScreenRegistrationPropertyChoisePlanState();
}

class _ScreenRegistrationPropertyChoisePlanState extends State<ScreenRegistrationPropertyChoisePlan> {
  bool _loading=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Registro de inmuebles",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      body: _loading? 
      Container(
        color: ColorsDefault.colorBackgroud,
        child: Center(
          child: CupertinoActivityIndicator(
            radius: SizeDefault.radiusCircularIndicator,
          ),
        ),
      ):ContainerPlansPayment(),
    );
  }
}