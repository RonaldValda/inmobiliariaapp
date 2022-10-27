
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:provider/provider.dart';
class ButtonFlotante extends StatelessWidget {
  const ButtonFlotante({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<WidgetStatusProvider>(context);
    return FloatingActionButton.extended(
      hoverColor: Colors.red,
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      autofocus: false,
     //icon: Icon(Icons.ac_unit),
      //mouseCursor: MouseCursor.uncontrolled,
      
      onPressed: (){
        _estadoWidgets.setSeeMap(!_estadoWidgets.seeMap);
      }, 
      label: Container(
        height: 130,
        width: 80,
        child: Row(
          children: <Widget>[
            Text(_estadoWidgets.seeMap?"Ir Lista":"Ir Mapa"),
            _estadoWidgets.seeMap?Icon(Icons.list,size: 20,):Icon(Icons.public,size: 20,)
          ],
        ),
      )
    );
  }
}