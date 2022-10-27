import 'package:flutter/cupertino.dart';

import '../../common/size_default.dart';
import '../../pages/registration_property/property_data/item_step_property_comunity.dart';
import '../../pages/registration_property/property_data/item_step_property_others.dart';
import '../../pages/registration_property/property_data/item_step_property_general.dart';
import '../../pages/registration_property/property_data/item_step_property_internal.dart';
import 'step_category.dart';

class RegistrationPropertyWidgetProvider extends ChangeNotifier{
  StepRegistrationProperty _stepRegistrationProperty=StepRegistrationProperty.empty();
  List<StepRegistrationProperty> _steps=[];
  ScrollController _scrollController=ScrollController(initialScrollOffset: 0);

  List<StepRegistrationProperty> get steps => _steps;
  
  ScrollController get scrollController => _scrollController;

  List<Widget> _wStepsItems=[];

  Widget get wStepItem => _wStepsItems[_steps.lastIndexWhere((step) => step.selected)];


  void init({bool forceClean=false}){
    if(forceClean||_steps.length==0){
      _scrollController=ScrollController(initialScrollOffset: 0);
      _steps=[];
      _steps.addAll(_stepRegistrationProperty.steps);
    }else{

    }
    _wStepsItems=[ItemStepPropertyGeneral(),ItemStepPropertyInternal(),ItemStepPropertyComunity(),ItemStepPropertyOthers()];
  }

  @override
  void dispose() {
    super.dispose();
  }
  

  void selectStep(int number)async{
    double newPosition=0.0;
    double commonSize=20*SizeDefault.scaleHeight*2+5*SizeDefault.scaleWidth*3+30*SizeDefault.scaleHeight+10*SizeDefault.scaleWidth;
    for(int i=0;i<_steps.length;i++){
      _steps[i]=StepRegistrationProperty.copyWith(srp: _steps[i],select: number==_steps[i].number);
      if(i<number-1){
        newPosition+=_steps[number-1].nameStep.length*9*SizeDefault.scaleHeight;
      }
    }
    newPosition+=commonSize*(number-1);
    newPosition-=SizeDefault.swidth/2-SizeDefault.paddingHorizontalBody;
    notifyListeners();
    await _scrollController.animateTo(newPosition<0?0:newPosition, duration: Duration(milliseconds: 200), curve: Curves.easeInCirc);
  }

  void jumpStep({required bool forward}){
    int position=_steps.lastIndexWhere((step) => step.selected);
    forward?selectStep(_steps[position].number+1):selectStep(_steps[position].number-1);
  }
}