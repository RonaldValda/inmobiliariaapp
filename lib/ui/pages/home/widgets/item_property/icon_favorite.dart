import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../domain/usecases/property/usecase_property.dart';
import '../../../../../domain/usecases/property/usecase_property_base.dart';
class IconFavorite extends StatefulWidget {
  IconFavorite({Key? key,required this.propertyTotal}) : super(key: key);
  final PropertyTotal propertyTotal;
  @override
  _IconFavoriteState createState() => _IconFavoriteState();
}

class _IconFavoriteState extends State<IconFavorite> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseProperty useCaseInmueble=UseCaseProperty();
  UseCasePropertyBase useCaseInmuebleBase=UseCasePropertyBase();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50*SizeDefault.scaleHeight,
        margin: EdgeInsets.only(right: 10*SizeDefault.scaleWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextStandard(
                  text: widget.propertyTotal.property.favoritesQuantity.toString(), 
                  fontSize: SizeDefault.fSizeStandard,
                  color: ColorsDefault.colorBackgroud,
                ),
                SizedBox(width:5*SizeDefault.scaleWidth),
                Container(
                  child: IconButton(
                    splashRadius: 10,
                    constraints: BoxConstraints(maxWidth:35*SizeDefault.scaleHeight, maxHeight: 35*SizeDefault.scaleHeight,),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.read<PropertiesProvider>().registerPropertyFavorite(context: context, prefs: _prefs, propertyTotal: widget.propertyTotal,favorite: true);
                    },
                    //icon:Icon(Icons.favorite_border,color: Colors.white,size: 30,),
                    icon: !widget.propertyTotal.userPropertyFavorite.favorite
                    ?Icon(Icons.favorite_border,color: ColorsDefault.colorBackgroud,size: 35*SizeDefault.scaleHeight,)
                    :Icon(Icons.favorite,color: ColorsDefault.colorFavorite,size:35*SizeDefault.scaleHeight)
                  )
                )
              ],
            ),
          ],
        ),
      );
  }
}