import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/filters/see_more_button.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:intl/intl.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_super_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/f_list_tile_switch.dart';
import 'drop_down_filters.dart';
class FiltersSecondaryOthers extends StatefulWidget {
  FiltersSecondaryOthers({Key? key}) : super(key: key);

  @override
  _FiltersSecondaryOthersState createState() => _FiltersSecondaryOthersState();
}

class _FiltersSecondaryOthersState extends State<FiltersSecondaryOthers> {
 
  bool seeMore=false;
  @override
  Widget build(BuildContext context) {
    final filterOthersProvider=context.watch<FilterOthersProvider>();
    final filterUserProvider=context.watch<FilterUserProvider>();
    return Container(
       child: Column(
         children: [
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Rebajados", 
            value: filterOthersProvider.mapFilter["lowereds"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterItem("lowereds",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Vistos", 
            value: filterUserProvider.mapFilter["viewed"], 
            onChanged: (value){
              filterUserProvider.setMapFilterItem("viewed",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Revisados", 
            value: filterUserProvider.mapFilter["viewed_double"], 
            onChanged: (value){
              filterUserProvider.setMapFilterItem("viewed_double",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Favoritos", 
            value: filterUserProvider.mapFilter["favorites"], 
            onChanged: (value){
              filterUserProvider.setMapFilterItem("favorites",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Verificados", 
            value: filterOthersProvider.mapFilter["verifieds"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterItem("verifieds",value,context: context);
            }
          ),
          SeeMoreButton(
            activate: seeMore, 
            onTap: (){
              setState(() {
                seeMore=!seeMore;
              });
            }
          ),
           seeMore?FiltersSecondaryOthersPlus():Container(),
        ],
      ),
    );
  }
}
class FiltersSecondaryOthersPlus extends StatefulWidget {
  FiltersSecondaryOthersPlus({Key? key}) : super(key: key);

  @override
  _FiltersSecondaryOthersPlusState createState() => _FiltersSecondaryOthersPlusState();
}

class _FiltersSecondaryOthersPlusState extends State<FiltersSecondaryOthersPlus> {
  double widthContainerTexto=180;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  double heightContainerTexto4=100;
  // ignore: non_constant_identifier_names
  List<String> itemsDays360=["Cualquiera","0-9","10-19","20-29","30 a más"];
  // ignore: non_constant_identifier_names
  List<int> days360=[0,0,10,20,30];

  bool dropdownActivate=false;
  DateTime? pickedDate;
  var inputformat=DateFormat("dd-MM-yyyy");
  TextEditingController? _initialDateController;
  TextEditingController? _finalDateController;
  @override
  void initState() {
     pickedDate=DateTime.now();
     _initialDateController = new TextEditingController(text: "${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}");
     _finalDateController = new TextEditingController(text: "${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final filterOthersProvider=context.watch<FilterOthersProvider>();
    final filterUserProvider=context.watch<FilterUserProvider>();
    final userProvider=context.watch<UserProvider>();
    final filterSuperUserProvider=context.watch<FilterSuperUserProvider>();
    return Container(
       child: Column(
         children: [
          userProvider.user.id!=""
          ?FListTileSwitch(
            isLeadingVisible: true,
            title: "Contactados", 
            value: filterUserProvider.mapFilterPlus["contacteds"], 
            onChanged: (value){
              filterUserProvider.setMapFilterPlusItem("contacteds",value,context: context);
            }
          ):Container(),                           
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Negociado inicial", 
            value: filterOthersProvider.mapFilterPlus["initial_negotiated"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterPlusItem("initial_negotiated",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Negociado avanzado", 
            value: filterOthersProvider.mapFilterPlus["avanced_negotiated"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterPlusItem("avanced_negotiated",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Remates judiciales", 
            value: filterOthersProvider.mapFilterPlus["judicial_auctions"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterPlusItem("judicial_auctions",value,context: context);
            }
          ),
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Imágenes 2D", 
            value: filterOthersProvider.mapFilterPlus["images_2D"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterPlusItem("images_2D",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Vídeo 2D", 
            value: filterOthersProvider.mapFilterPlus["video_2D"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterPlusItem("video_2D",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Tour virtual 360", 
            value: filterOthersProvider.mapFilterPlus["tour_virtual_360"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterPlusItem("tour_virtual_360",value,context: context);
            }
          ), 
          FListTileSwitch(
            isLeadingVisible: true,
            title: "Video tour 360", 
            value: filterOthersProvider.mapFilterPlus["video_tour_360"], 
            onChanged: (value){
              filterOthersProvider.setMapFilterPlusItem("video_tour_360",value,context: context);
            }
          ), 
          DropDownFilters(
            dropDownItemsCount: 3,
            attribute: "days_P360", 
            mapData: filterOthersProvider.mapSelectableData, 
            mapFilter: filterOthersProvider.mapFilterPlus, 
            onChanged: (x){
              filterOthersProvider.setMapFilterPlusItem("days_P360", x, selectable: true,context: context);
            }, 
            text: "Días en P360"
          ),
           userProvider.user.userType=="Gerente"?Column(
             children: [
              FListTileSwitch(
                isLeadingVisible: true,
                title: "Vendidos", 
                value: filterSuperUserProvider.mapFilter["sold"], 
                onChanged: (value){
                  filterSuperUserProvider.setMapFilterItem("sold",value,context: context);
                }
              ), 
              FListTileSwitch(
                isLeadingVisible: true,
                title: "No vendidos", 
                value: filterSuperUserProvider.mapFilter["unsold"], 
                onChanged: (value){
                  filterSuperUserProvider.setMapFilterItem("unsold",value,context: context);
                }
              ), 
              TextFFOnTap(
                controller: _initialDateController!,
                label: "Desde",
                onTap:(){
                  _pickDate(_initialDateController!);
                }
              ),
              SizedBox(
                height: 5,
              ),
              TextFFOnTap(
                controller: _finalDateController!,
                label: "Hasta",
                onTap:(){
                  _pickDate(_finalDateController!);
                }
              ),
             ],
           ):Container(),
           
         ],
       ),
    );
  }
  _pickDate(TextEditingController controller) async{
    DateTime? date=await showDatePicker(
      context: context, 
      initialDate: pickedDate!, 
      firstDate: DateTime(DateTime.now().year-5), 
      lastDate: DateTime(DateTime.now().year+5),
      //locale : const Locale("fr","FR")
    ); 
    if(date!=null){
     
      setState(() {
        pickedDate=date;
         controller.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
      });
      
    }
  }
}