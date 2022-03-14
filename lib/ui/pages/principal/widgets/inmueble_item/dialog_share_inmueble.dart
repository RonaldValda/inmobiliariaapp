import 'package:flutter/material.dart';
Future dialogZoomImagen(
  BuildContext context,
  String imagen
)async{
  double width;
  double height;
  if(MediaQuery.of(context).size.width<MediaQuery.of(context).size.height){
    width=MediaQuery.of(context).size.width-20;
    height=MediaQuery.of(context).size.width-20;
  }else{
    width=MediaQuery.of(context).size.height-20;
    height=MediaQuery.of(context).size.height-20;
  }
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(0),
           //titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            //title: Center(child: Text("Reportar inmueble",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: width,
                height: height,
                //height: MediaQuery.of(context).size.width/1.1,
                //height: 200,
                child: 
                Column(
                  children:[
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //IntectativeViewerImage(imagen: imagen),
                      ],
                    )),
                  ]
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}