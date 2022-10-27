
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

class FiltersSort extends StatefulWidget {
  FiltersSort({Key? key}) : super(key: key);

  @override
  _FiltersSortState createState() => _FiltersSortState();
}

class _FiltersSortState extends State<FiltersSort> {
  final heightContainerTexto=30.0*SizeDefault.scaleWidth;
  final widthContainerTexto=100.0*SizeDefault.scaleWidth;
  @override
  Widget build(BuildContext context) {
    final filterOthersProvider=context.watch<FilterOthersProvider>();
    final usuarioInfo=Provider.of<UserProvider>(context);
    return Container(
        padding: EdgeInsets.only(left: 10*SizeDefault.scaleWidth),
        alignment: Alignment.center,
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Align(
             alignment: Alignment.centerLeft,
             child: TextStandard(
              text: "Ordenar por:",
              fontSize: SizeDefault.fSizeStandard,
              fontWeight: FontWeight.bold,
             )
            ),
            _wRadioButton(
              text: "Por defecto", 
              groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
              value: GetParameterOrder.defaults.index, 
              onChanged: (value){
                filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
              }
            ),
            _wRadioButton(
              text: "Precio", 
              groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
              value: GetParameterOrder.price.index,
              onChanged: (value){
                filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
              }
            ),
            _wRadioButton(
              text: "Superficie terreno", 
              groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
              value: GetParameterOrder.landSurface.index,
              onChanged: (value){
                filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
              }
            ),
            _wRadioButton(
              text: "Superficie construcción", 
              groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
              value: GetParameterOrder.constructionSurface.index,
              onChanged: (value){
                filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
              }
            ),
            _wRadioButton(
              text: "Tiempo construcción", 
              groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
              value: GetParameterOrder.constructionAntiquity.index,
              onChanged: (value){
                filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
              }
            ),
            _wRadioButton(
              text: "Dormitorios", 
              groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
              value: GetParameterOrder.bedrooms.index,
              onChanged: (value){
                filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
              }
            ),
            if(usuarioInfo.user.userType=="Gerente")
            Column(
              children: [
                _wRadioButton(
                  text: "Vistos", 
                  groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
                  value: GetParameterOrder.viewed.index,
                  onChanged: (value){
                    filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
                  }
                ),
                _wRadioButton(
                  text: "Revisados", 
                  groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
                  value: GetParameterOrder.viewed_double.index,
                  onChanged: (value){
                    filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
                  }
                ),
                _wRadioButton(
                  text: "Favoritos", 
                  groupValue: filterOthersProvider.mapFilterOrder["parameter"], 
                  value: GetParameterOrder.favorite.index,
                  onChanged: (value){
                    filterOthersProvider.setMapFilterOrder("parameter", value,context: context);
                  }
                ),
              ],
            ),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextStandard(
                text: "Orden",
                fontSize: SizeDefault.fSizeStandard,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          _wRadioButton(
            text: "Ascendente", 
            groupValue: filterOthersProvider.mapFilterOrder["order"], 
            value: GetOrder.asc.index,
            onChanged: (value){
              filterOthersProvider.setMapFilterOrder("order", value,context: context);
            }
          ),
          _wRadioButton(
            text: "Descendente", 
            groupValue: filterOthersProvider.mapFilterOrder["order"], 
            value: GetOrder.desc.index,
            onChanged: (value){
              filterOthersProvider.setMapFilterOrder("order", value,context: context);
            }
          ),
         ],
       )
    );
  }

  Container _wRadioButton({required String text,required int groupValue,required int value, required Function onChanged}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3*SizeDefault.scaleWidth),
      height: heightContainerTexto,
      child:Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: heightContainerTexto,
            width: widthContainerTexto,
            child: TextStandard(
              text: text, 
              fontSize: 12*SizeDefault.scaleWidth
            )
          ),
          Container(
            child: Radio<int>(
              activeColor: ColorsDefault.colorPrimary,
              groupValue: groupValue,
              value: value,
              onChanged: (value){
                onChanged(value);
              }
            ),
          ),
        ],
      ),
    );
  }
}