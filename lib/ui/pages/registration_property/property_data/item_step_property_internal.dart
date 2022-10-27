import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/pages/registration_property/property_data/container_images_categories.dart';
import 'package:inmobiliariaapp/ui/pages/registration_property/property_data/container_images_main.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/f_list_tile_switch.dart';
import '../../../common/size_default.dart';
import '../../../common/texts.dart';
import '../../../provider/registration_property/registration_property_provider.dart';
class ItemStepPropertyInternal extends StatefulWidget {
  ItemStepPropertyInternal({Key? key}) : super(key: key);
  @override
  _ItemStepPropertyInternalState createState() => _ItemStepPropertyInternalState();
}

class _ItemStepPropertyInternalState extends State<ItemStepPropertyInternal> {
  PropertyTotal? inmuebleTotal;
  TextEditingController? controllerBedroomsNumber;
  TextEditingController? controllerBathroomsNumber;
  TextEditingController? controllerGaragesNumber;
  TextEditingController? controllerFloorsNumber;
  TextEditingController? controllerRoomsNumber;
  TextEditingController? controllerInternalDetails;
  @override
  void initState() {
    super.initState();
  }
  void _initControllers(PropertyInternal propertyInternal){
    if(controllerBathroomsNumber==null){
      controllerBedroomsNumber=TextEditingController(text: propertyInternal.bedroomsNumber.toString());
      controllerBathroomsNumber=TextEditingController(text: propertyInternal.bathroomsNumber.toString());
      controllerGaragesNumber=TextEditingController(text: propertyInternal.garagesNumber.toString());
      controllerFloorsNumber=TextEditingController(text: propertyInternal.floorsNumber.toString());
      controllerRoomsNumber=TextEditingController(text: propertyInternal.roomsNumber.toString());
      controllerInternalDetails=TextEditingController(text: propertyInternal.internalDetails);
    }
  }
  @override
  Widget build(BuildContext context) {
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final propertyInternal=registrationPropertyProvider.propertyTotalCopy.propertyInternal;
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    final sizedBox=SizedBox(height:7*SizeDefault.scaleHeight);
    _initControllers(propertyInternal);
    return _wData(sizedBox, context, property, propertyInternal, registrationPropertyProvider);
  }

  Container _wData(SizedBox sizedBox, BuildContext context, Property property, PropertyInternal propertyInternal, RegistrationPropertyProvider registrationPropertyProvider) {
    return Container(
    color: ColorsDefault.colorBackgroud,
    child: Column(
        children: [
          Expanded(child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,),
            children: [
              sizedBox,
              _wMainImages(context),
              sizedBox,
              _textField(
                nombreCategoria: "Plantas", 
                clave: "plantas", 
                selected: propertyInternal.floorsNumber>0, 
                controller: controllerFloorsNumber!, 
                labelText: "Plantas", 
                onChanged: (x){
                  propertyInternal.floorsNumber=x!=""?int.parse(x):0;
                  setState(() {});
                }
              ),
              sizedBox,
              _textField(
                nombreCategoria: "Ambientes", 
                clave: "ambientes", 
                selected: propertyInternal.roomsNumber>0, 
                controller: controllerRoomsNumber!, 
                labelText: "Ambientes", 
                onChanged: (x){
                  propertyInternal.roomsNumber=x!=""?int.parse(x):0;
                  setState(() {});
                }
              ),
              sizedBox,
              _textField(
                nombreCategoria: "Dormitorios", 
                clave: "dormitorios", 
                selected: propertyInternal.bedroomsNumber>0, 
                controller: controllerBedroomsNumber!, 
                labelText: "Dormitorios", 
                onChanged: (x){
                  propertyInternal.bedroomsNumber=x!=""?int.parse(x):0;
                  setState(() {});
                }
              ),
              sizedBox,
              _textField(
                nombreCategoria: "Baños", 
                clave: "banios", 
                selected: propertyInternal.bathroomsNumber>0, 
                controller: controllerBathroomsNumber!, 
                labelText: "Baños", 
                onChanged: (x){
                  propertyInternal.bathroomsNumber=x!=""?int.parse(x):0;
                  setState(() {});
                }
              ),
              sizedBox,
              _textField(
                nombreCategoria: "Garaje", 
                clave: "garaje", 
                selected: propertyInternal.garagesNumber>0, 
                controller: controllerGaragesNumber!, 
                labelText: "Garaje", 
                onChanged: (x){
                  propertyInternal.garagesNumber=x!=""?int.parse(x):0;
                  setState(() {});
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Amoblado", 
                value: propertyInternal.furnished,
                isLeadingVisible: propertyInternal.furnished,
                leading: ButtonIconUploadImage(
                  categoryName:"Amoblado",
                  keyImage: "amoblado",
                ),
                onChanged: (value){
                  propertyInternal.furnished=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Lavanderia", 
                value: propertyInternal.laundry, 
                isLeadingVisible: propertyInternal.laundry,
                leading: ButtonIconUploadImage(
                  categoryName:"Lavanderia",
                  keyImage: "lavanderia",
                ),
                onChanged: (value){
                  propertyInternal.laundry=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Cuarto de lavado", 
                value: propertyInternal.laundryRoom, 
                isLeadingVisible: propertyInternal.laundryRoom,
                leading: ButtonIconUploadImage(
                  categoryName:"Cuarto de lavado",
                  keyImage: "cuarto_lavado",
                ),
                onChanged: (value){
                  propertyInternal.laundryRoom=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Churrasquero", 
                value: propertyInternal.grill, 
                isLeadingVisible: propertyInternal.grill, 
                leading: ButtonIconUploadImage(
                  categoryName:"Churrasquero",
                  keyImage: "churrasquero",
                ),
                onChanged: (value){
                  propertyInternal.grill=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Azotea", 
                value: propertyInternal.rooftop, 
                isLeadingVisible: propertyInternal.rooftop, 
                leading: ButtonIconUploadImage(
                  categoryName:"Azotea",
                  keyImage: "azotea",
                ),
                onChanged: (value){
                  propertyInternal.rooftop=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "[Club house]-> Condominio privado", 
                value: propertyInternal.privateCondominium, 
                isLeadingVisible: propertyInternal.privateCondominium, 
                leading: ButtonIconUploadImage(
                  categoryName:"[Club house]-> Condominio privado",
                  keyImage: "condominio_privado",
                ),
                onChanged: (value){
                  propertyInternal.privateCondominium=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Cancha de fútbol, tenis, etc. en inmueble", 
                value: propertyInternal.court, 
                isLeadingVisible: propertyInternal.court, 
                leading: ButtonIconUploadImage(
                  categoryName:"Cancha de fútbol, tenis, etc. en inmueble",
                  keyImage: "cancha",
                ),
                onChanged: (value){
                  propertyInternal.court=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Piscina", 
                value: propertyInternal.pool, 
                isLeadingVisible: propertyInternal.pool, 
                leading: ButtonIconUploadImage(
                  categoryName:"Piscina",
                  keyImage: "piscina",
                ),
                onChanged: (value){
                  propertyInternal.pool=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Sauna", 
                value: propertyInternal.sauna, 
                isLeadingVisible: propertyInternal.sauna, 
                leading: ButtonIconUploadImage(
                  categoryName:"Sauna",
                  keyImage: "sauna",
                ),
                onChanged: (value){
                  propertyInternal.sauna=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Jacuzzi", 
                value: propertyInternal.jacuzzi, 
                isLeadingVisible: propertyInternal.jacuzzi, 
                leading: ButtonIconUploadImage(
                  categoryName:"Jacuzzi",
                  keyImage: "jacuzzi",
                ),
                onChanged: (value){
                  propertyInternal.jacuzzi=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Estudio", 
                value: propertyInternal.studio, 
                isLeadingVisible: propertyInternal.studio, 
                leading: ButtonIconUploadImage(
                  categoryName:"Estudio",
                  keyImage: "estudio",
                ),
                onChanged: (value){
                  propertyInternal.studio=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Jardín", 
                value: propertyInternal.garden, 
                isLeadingVisible: propertyInternal.garden, 
                leading: ButtonIconUploadImage(
                  categoryName:"Jardín",
                  keyImage: "jardin",
                ),
                onChanged: (value){
                  propertyInternal.garden=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Portón eléctrico", 
                value: propertyInternal.electricGate, 
                isLeadingVisible: propertyInternal.electricGate, 
                leading: ButtonIconUploadImage(
                  categoryName:"Portón eléctrico",
                  keyImage: "porton_electrico",
                ),
                onChanged: (value){
                  propertyInternal.electricGate=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Aire acondicionado", 
                value: propertyInternal.airConditioning, 
                isLeadingVisible: propertyInternal.airConditioning, 
                leading: ButtonIconUploadImage(
                  categoryName:"Aire acondicionado",
                  keyImage: "aire_acondicionado",
                ),
                onChanged: (value){
                  propertyInternal.airConditioning=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Calefacción",
                value: propertyInternal.heating,  
                isLeadingVisible: propertyInternal.heating, 
                leading: ButtonIconUploadImage(
                  categoryName:"Calefacción",
                  keyImage: "calefaccion",
                ),
                onChanged: (value){
                  propertyInternal.heating=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Ascensor", 
                value: propertyInternal.elevator, 
                isLeadingVisible: propertyInternal.elevator, 
                leading: ButtonIconUploadImage(
                  categoryName:"Ascensor",
                  keyImage: "ascensor",
                ),
                onChanged: (value){
                  propertyInternal.elevator=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Depósito", 
                value: propertyInternal.warehouse, 
                isLeadingVisible: propertyInternal.warehouse, 
                leading: ButtonIconUploadImage(
                  categoryName:"Depósito",
                  keyImage: "deposito",
                ),
                onChanged: (value){
                  propertyInternal.warehouse=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Sótano", 
                value: propertyInternal.basement, 
                isLeadingVisible: propertyInternal.basement, 
                leading: ButtonIconUploadImage(
                  categoryName:"Sótano",
                  keyImage: "sotano",
                ),
                onChanged: (value){
                  propertyInternal.basement=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Balcón", 
                value: propertyInternal.balcony, 
                isLeadingVisible: propertyInternal.balcony, 
                leading: ButtonIconUploadImage(
                  categoryName:"Balcón",
                  keyImage: "balcon",
                ),
                onChanged: (value){
                  propertyInternal.balcony=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "Tienda", 
                value: propertyInternal.store, 
                isLeadingVisible: propertyInternal.store, 
                leading: ButtonIconUploadImage(
                  categoryName:"Tienda",
                  keyImage: "tienda",
                ),
                onChanged: (value){
                  propertyInternal.store=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FListTileSwitch(
                title: "[Amurallado]-> Terreno", 
                value: propertyInternal.landWalled, 
                isLeadingVisible: propertyInternal.landWalled, 
                leading: ButtonIconUploadImage(
                  categoryName:"[Amurallado]-> Terreno",
                  keyImage: "amurallado_terreno",
                ),
                onChanged: (value){
                  propertyInternal.landWalled=value;
                  registrationPropertyProvider.notify();
                }
              ),
              sizedBox,
              FTextFieldBasico(
                controller: controllerInternalDetails!, 
                labelText: "Detalles", 
                onChanged: (x){
                  propertyInternal.internalDetails=x;
                }
              ),
              SizedBox(height:20*SizeDefault.scaleHeight),
            ],
          ),)
        ],
    ),
  );
  }

  Widget _wMainImages(BuildContext context) {
    final List images=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages["principales"];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left:10*SizeDefault.scaleWidth),
          child: TextStandard(
            text: "Imágenes principales", 
            fontSize: 16*SizeDefault.scaleHeight,
            fontWeight: FontWeight.w700,
            color: ColorsDefault.colorText,
          ),
        ),
        InkWell(
          onTap: ()async{
            await fShowModalBottomSheet(
              context:context,
              widget:ContainerImagesMain()
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 10*SizeDefault.scaleHeight,bottom: 20*SizeDefault.scaleHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _wMainImageItem(images[0]),
                _wMainImageItem(images[1]),
                _wMainImageItem(images[2]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _wMainImageItem(String urlImage){
    return Container(
      width: 120*SizeDefault.scaleWidth,
      height: 100*SizeDefault.scaleWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorsDefault.colorShadowCardImage,
            blurRadius: 5,
            offset: Offset(0, 4)
          )
        ],
        color: ColorsDefault.colorBackgroud,
        border: Border.all(
          width: 0.5*SizeDefault.scaleHeight,
          color: ColorsDefault.colorBorder
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      child: urlImage!=""
      ?ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
            
            fit: BoxFit.contain,
            imageUrl: urlImage,
          ),
      ):SizedBox(),
    );
  }

  Widget _textField({
    required String nombreCategoria,
    required String clave, 
    required bool selected, 
    required TextEditingController controller,
    required String labelText,
    required Function onChanged
  }){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ButtonIconUploadImage(
          categoryName: nombreCategoria,
          keyImage: clave,
          selected: selected, 
        ),
        Expanded(
          child: FTextFieldBasico(
            controller: controller, 
            labelText: labelText, 
            textInputType: TextInputType.number,
            onChanged: (x){
              onChanged(x);
            }
          ),
        ),
      ],
    );
  }
}
class ButtonIconUploadImage extends StatefulWidget {
  ButtonIconUploadImage({Key? key,
    required this.categoryName,
    required this.keyImage,
    this.selected=true}) : super(key: key);
  final String categoryName;
  final String keyImage;
  final bool selected;
  @override
  _ButtonIconUploadImageState createState() => _ButtonIconUploadImageState();
}

class _ButtonIconUploadImageState extends State<ButtonIconUploadImage> {
  int i=0;
  @override
  Widget build(BuildContext context) {
    final List images=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property.mapImages[widget.keyImage];
    return InkWell(
      onTap: ()async{
        await fShowModalBottomSheet(
          context:context,
          widget:ContainerImagesCategories(
            title: widget.categoryName,
            keyImage: widget.keyImage
          )
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: SizeDefault.paddingHorizontalText),
        padding:EdgeInsets.zero,
        width: 30*SizeDefault.scaleHeight,
        child: widget.selected?
        Icon(
          Icons.upload,
          color: images.length>0?
            ColorsDefault.colorPrimary:Colors.grey,
        ):SizedBox(),
      ),
    );
  }

  
}