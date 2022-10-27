import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/widgets/f_list_tile_switch.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import 'drop_down_selectable_data_overlay.dart';
import 'map_registration_property.dart';
class ItemStepPropertyGeneral extends StatefulWidget {
  ItemStepPropertyGeneral({Key? key,
    }) : super(key: key);
  @override
  _ItemStepPropertyGeneralState createState() => _ItemStepPropertyGeneralState();
}

class _ItemStepPropertyGeneralState extends State<ItemStepPropertyGeneral> {
  TextEditingController? _controllerAddress;
  TextEditingController? _controllerLandSurface;
  TextEditingController? _controllerConstructionSurface;
  TextEditingController? _controllerFrontSize;
  TextEditingController? _controllerPrice;
  TextEditingController? _controllerConstructionAntiquity;
  TextEditingController? _controllerOwnersNumber;
  TextEditingController? _controllerGeneralDetails;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _controllerAddress!.dispose();
    _controllerPrice!.dispose();
    _controllerLandSurface!.dispose();
    _controllerConstructionSurface!.dispose();
    _controllerConstructionAntiquity!.dispose();
    _controllerFrontSize!.dispose();
    _controllerOwnersNumber!.dispose();
    _controllerGeneralDetails!.dispose();
    super.dispose();
  }

  void _initControllers(Property property){
    if(_controllerAddress==null){
      _controllerAddress=TextEditingController(text: property.address);
      _controllerPrice=TextEditingController(text: property.price.toString());
      _controllerLandSurface=TextEditingController(text: property.landSurface.toString());
      _controllerConstructionSurface=TextEditingController(text: property.constructionSurface.toString());
      _controllerConstructionAntiquity=TextEditingController(text: property.constructionAntiquity.toString());
      _controllerFrontSize=TextEditingController(text: property.frontSize.toString());
      _controllerOwnersNumber=TextEditingController(text: property.ownersNumber.toString());
      _controllerGeneralDetails=TextEditingController(text: property.generalDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    final sizedBox=SizedBox(height:7*SizeDefault.scaleHeight);
    _initControllers(property);
    return _wData(sizedBox, property, registrationPropertyProvider);
  }

  Container _wData(SizedBox sizedBox, Property property, RegistrationPropertyProvider registrationPropertyProvider) {
    return Container(
      color: ColorsDefault.colorBackgroud,
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              primary: false,
              scrollDirection: Axis.vertical,
              children: [
                sizedBox,
                DropDownSelectableDataOverlay(
                  attribute: "city", text: "Ciudad",dropDownItemsCount: 9,
                ),
                sizedBox,
                DropDownSelectableDataOverlay(
                  attribute: "property_type", text: "Tipo inmueble",dropDownItemsCount: 7,
                ),
                sizedBox,
                DropDownSelectableDataOverlay(
                  attribute: "contract_type", text: "Tipo contrato",
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerPrice!, 
                  labelText: "Precio", 
                  textInputType: TextInputType.number,
                  onChanged: (x){
                    property.price=x!=""?int.parse(x):0;
                  }
                ),
                sizedBox,
                FTextFieldOnTapDisabled(
                  labelText: "Zona", 
                  text: property.zoneName,
                  onTap: ()async{
                    await fShowModalBottomSheet(
                      context: context, 
                      widget:  MapRegistrationProperty()
                    );
                    registrationPropertyProvider.notify();
                  },
                ),
                //InkWellZona(),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerAddress!, 
                  labelText: "Dirección", 
                  onChanged: (x){
                    property.address=x;
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Mascotas permitidas", 
                  value: property.enablePets, 
                  onChanged: (value){
                    property.enablePets=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Sin hipoteca", 
                  value: property.noMortgage, 
                  onChanged: (value){
                    property.noMortgage=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Construcción a estrenar", 
                  value: property.newConstruction, 
                  onChanged: (value){
                    property.newConstruction=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Materiales de primera", 
                  value: property.premiumMaterials, 
                  onChanged: (value){
                    property.premiumMaterials=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerLandSurface!, 
                  labelText: "Superficie del terreno en m2", 
                  textInputType: TextInputType.number,
                  onChanged: (x){
                    property.landSurface=x!=""?int.parse(x):0;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerConstructionSurface!, 
                  labelText: "Superficie de construcción en m2", 
                  textInputType: TextInputType.number,
                  onChanged: (x){
                    property.constructionSurface=x!=""?int.parse(x):0;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerFrontSize!, 
                  labelText: "Tamaño de frente", 
                  textInputType: TextInputType.number,
                  onChanged: (x){
                    property.frontSize=x!=""?int.parse(x):0;
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerConstructionAntiquity!, 
                  labelText: "Antigüedad de construcción", 
                  textInputType: TextInputType.number,
                  onChanged: (x){
                    property.constructionAntiquity=x!=""?int.parse(x):0;
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Proyectos preventa", 
                  value: property.preSaleProject, 
                  onChanged: (value){
                    property.preSaleProject=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Inmueble compartido", 
                  value: property.sharedProperty, 
                  onChanged: (value){
                    property.sharedProperty=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                property.sharedProperty
                ?FTextFieldBasico(
                  controller: _controllerOwnersNumber!, 
                  labelText: "Número de dueños", 
                  textInputType: TextInputType.number,
                  onChanged: (x){
                    property.ownersNumber=x!=""?int.parse(x):0;
                  }
                ):SizedBox(),
                sizedBox,
                FListTileSwitch(
                  title: "Servicios básicos", 
                  value: property.basicServices, 
                  onChanged: (value){
                    property.basicServices=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Gas domiciliario", 
                  value: property.householdGas, 
                  onChanged: (value){
                    property.householdGas=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Wi-Fi", 
                  value: property.wifi, 
                  onChanged: (value){
                    property.wifi=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Medidor independiente", 
                  value: property.independentMeter, 
                  onChanged: (value){
                    property.independentMeter=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Termotanques", 
                  value: property.hotWaterTank, 
                  onChanged: (value){
                    property.hotWaterTank=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Calle asfaltada", 
                  value: property.pavedStreet, 
                  onChanged: (value){
                    property.pavedStreet=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Transporte  (0 - 100m)", 
                  value: property.transport, 
                  onChanged: (value){
                    property.transport=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Preparado para discapacidad", 
                  value: property.disabilityPrepared, 
                  onChanged: (value){
                    property.disabilityPrepared=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Papeles en orden", 
                  value: property.orderPapers,
                  onChanged: (value){
                    property.orderPapers=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FListTileSwitch(
                  title: "Habilitado para crédito de vivienda social", 
                  value: property.enabledCredit, 
                  onChanged: (value){
                    property.enabledCredit=value;
                    registrationPropertyProvider.notify();
                  }
                ),
                sizedBox,
                FTextFieldBasico(
                  controller: _controllerGeneralDetails!, 
                  labelText: "Detalles", 
                  onChanged: (x){
                    property.generalDetails=x;
                  }
                ),
                SizedBox(height:20*SizeDefault.scaleHeight),
              ],
            ),
          )
        ],
      ),
    );
  }
}
