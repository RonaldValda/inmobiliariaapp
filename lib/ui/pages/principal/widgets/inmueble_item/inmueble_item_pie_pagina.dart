import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:pdf/widgets.dart' as pw;
class PiePagina extends StatefulWidget {
  final InmuebleTotal inmuebleTotal;
  final int index;
  PiePagina({Key? key,required this.inmuebleTotal,required this.index}) : super(key: key);

  @override
  _PiePaginaState createState() => _PiePaginaState();
}

class _PiePaginaState extends State<PiePagina> {
  bool mostrarIcono=false;
  double tamanioTexto=0.0;
  double tamanioTexto2=0.0;
  double tamanioTextoPrecio=0.0;
  double tamanioTextoPrecioRebajado=0.0;
  pw.Document? pdf;
  Uint8List? archivoPdf;
  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    double heightInfo=0;
    double widthInfo=0;
    if(_estadoWidgets.isVerMapa){
        heightInfo=120;
        widthInfo=250;
        mostrarIcono=true;
        tamanioTexto=17;
        tamanioTexto2=14;
        tamanioTextoPrecio=28;
        tamanioTextoPrecioRebajado=20;
    }else{
        tamanioTexto=20;
        tamanioTexto2=16;
        tamanioTextoPrecio=35;
        tamanioTextoPrecioRebajado=25;
        if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
          heightInfo=100;
          widthInfo=MediaQuery.of(context).size.width-35;
          if(MediaQuery.of(context).size.width<400){
            mostrarIcono=true;
          }else{
            mostrarIcono=false;
          }
        }else{
          heightInfo=MediaQuery.of(context).size.height/2;
          widthInfo=MediaQuery.of(context).size.width*0.3;
          mostrarIcono=false;
        }
    }
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final _mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    mostrarIcono=true;
    //print("priamero");
    //print(widget.inmuebleTotal.getInmueble.getHistorialPrecios);
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
       child: Row(
         //crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment:MainAxisAlignment.spaceBetween,
         children: [
           Container(
             //width: widthInfo,
             //height: heightInfo,
             //color: Colors.amber,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Align(
                   alignment: Alignment.centerLeft,
                   child: 
                   widgetPrecios(tamanioTextoPrecio,tamanioTextoPrecioRebajado)
                 ),
                mostrarIcono? Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Text("${widget.inmuebleTotal.getInmuebleInternas.getDormitorios.toString()} ",
                        style: TextStyle(fontSize: tamanioTexto,fontWeight: FontWeight.w600)
                      ),
                      PopupMenuFiltrar(
                        icon: iconc.FaIcon(iconc.FontAwesomeIcons.bed,size:tamanioTexto), 
                        tooltip: "Dormitorios", 
                        mensaje: "Filtrar por dormitorios", 
                        width: 20,
                        height: 20,
                        texto: "",
                        onTap: (){
                          _inmueblesFiltrado.setFiltrar(true);
                          _mapaFiltroInternas.setMapaFiltroItem("dormitorios", widget.inmuebleTotal.inmuebleInternas.dormitorios);
                          
                        }
                      ),
                      Text(" | ${(widget.inmuebleTotal.inmueble.precio/widget.inmuebleTotal.inmueble.superficieTerreno).floor()} ",
                        style: TextStyle(fontSize: tamanioTexto,fontWeight: FontWeight.w600)
                      ),
                      Tooltip(
                        showDuration: Duration(seconds: 1),
                        waitDuration: Duration(milliseconds: 10),
                        message: "Dólares por metro cuadrado",
                        child: Text("DPM",
                          style: TextStyle(
                            fontSize: tamanioTexto,fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      Text(" | ${widget.inmuebleTotal.getInmueble.getSuperficieTerreno.toString()}m2 ",
                        style: TextStyle(fontSize: tamanioTexto,fontWeight: FontWeight.w600)
                      ),
                      PopupMenuFiltrar(
                        icon:  iconc.FaIcon(iconc.FontAwesomeIcons.vectorSquare,size: tamanioTexto),
                        tooltip: "Superficie terreno", 
                        mensaje: "Filtrar por superficie de terreno", 
                        width: 20,
                        height: 20,
                        texto: "",
                        onTap: (){
                          List<int> superficiesTerreno=[0,150,200,250,300];
                          int i=0;
                          for(i=0;i<superficiesTerreno.length;i++){
                            if(i<superficiesTerreno.length-1)
                            if(superficiesTerreno[i]<=widget.inmuebleTotal.inmueble.superficieTerreno&&superficiesTerreno[i+1]>widget.inmuebleTotal.inmueble.superficieTerreno){
                              break;
                            }
                          }
                          print(i);
                          _inmueblesFiltrado.setFiltrar(true);
                          if(i<superficiesTerreno.length-1){
                            _mapaFiltroGenerales.getMapaFiltro["superficie_terreno_min"]=superficiesTerreno[i];
                            _mapaFiltroGenerales.getMapaFiltro["superficie_terreno_max"]=superficiesTerreno[i+1];
                            _mapaFiltroGenerales.setMapaFiltroItem("superficie_terreno_sel", superficiesTerreno[i].toString()+"-"+(superficiesTerreno[i+1]-1).toString());
                          }else{
                            _mapaFiltroGenerales.getMapaFiltro["superficie_terreno_min"]=superficiesTerreno[i-1];
                            _mapaFiltroGenerales.getMapaFiltro["superficie_terreno_max"]=superficiesTerreno[i-1];
                            _mapaFiltroGenerales.setMapaFiltroItem("superficie_terreno_sel", superficiesTerreno[i-1].toString()+" a más");
                          }
                        }
                      ),
                    ],
                  ),
                ):Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      InkWell(
                        onLongPress: ()async{
                          try{
                            bool respuesta=await dialogFiltrar(context, "Filrar por dormitorios");
                            if(respuesta){
                              _inmueblesFiltrado.setFiltrar(true);
                              _mapaFiltroInternas.setMapaFiltroItem("numero_dormitorios", widget.inmuebleTotal.inmuebleInternas.dormitorios);
                            }
                          }catch(e){
                            print(e);
                          }
                        },
                        child: Text("${widget.inmuebleTotal.getInmuebleInternas.getDormitorios.toString()} Dormitorios",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)
                        ),
                      ),
                      Text(" | ${(widget.inmuebleTotal.inmueble.precio/widget.inmuebleTotal.inmueble.superficieTerreno).floor()} DPM",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)
                      ),
                      Text(" | ${widget.inmuebleTotal.getInmueble.getSuperficieTerreno.toString()}m2 terreno",
                        style: TextStyle(fontSize: tamanioTexto2,fontWeight: FontWeight.w600,)
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.inmuebleTotal.getInmueble.direccion} |",
                      style: TextStyle(fontSize: tamanioTexto2,fontStyle: FontStyle.italic)
                      ),
                      PopupMenuFiltrar(
                        icon: Container(), 
                        tooltip: "Zona", 
                        mensaje: "Filtrar por zonas", 
                        width: widget.inmuebleTotal.inmueble.nombreZona.length*9,
                        height: 20,
                        texto: widget.inmuebleTotal.inmueble.nombreZona,
                        onTap: (){
                          _inmueblesFiltrado.setFiltrar(true);
                          _mapaFiltroPrincipales.setMapaFiltroItem("zona", widget.inmuebleTotal.inmueble.nombreZona);
                        }
                      ),
                      Text("| ${widget.inmuebleTotal.getInmueble.getCiudad}",style: TextStyle(fontSize: tamanioTexto2),)
                  ],
                ),
               ],
             ),
           ),
           Container(
             width: 40,
             height: 40,
             child: IconButton(
               iconSize: 20,
               splashRadius: 20,
               onPressed: ()async{
                 var status=await Permission.storage.request();
                  if(status.isGranted){
                      Map<String,dynamic> mapImagenesFile={};
                      widget.inmuebleTotal.inmueble.getImagenesCategorias;
                    for(int i=0;i<widget.inmuebleTotal.getInmueble.getImagenesCategorias.length;i++){
                      List imagenesCategoria=[];
                      for(int j=0;j<widget.inmuebleTotal.inmueble.getImagenesCategorias[i].length;j++){
                        var response=await Dio().get(widget.inmuebleTotal.inmueble.getImagenesCategorias[i][j],options: Options(
                          responseType: ResponseType.bytes
                        ));
                        
                        var datetime=DateTime.now();
                        String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
                        //print(nameFile);
                        final result= await ImageGallerySaver.saveImage(
                          Uint8List.fromList(response.data),
                          quality: 60,
                          name:nameFile
                        );
                        final imagen = pw.MemoryImage(
                          (await readFileByte(result["filePath"]))
                        );
                        imagenesCategoria.add(imagen);
                      }
                      mapImagenesFile[widget.inmuebleTotal.inmueble.categoriasKeys[i]]=imagenesCategoria;
                    }
                    print(mapImagenesFile["Plantas"]);
                    generarPdf1(widget.inmuebleTotal,mapImagenesFile)
                    .then((value) {
                      archivoPdf=value;
                      Printing.sharePdf(
                      bytes: archivoPdf!, filename: 'Documento.pdf')
                      .then((completado){
                        if(completado){
                          print("exportado");
                        }
                      });
                    });
                  }
                 
               }, icon: Icon(Icons.share,size: 20,)
              ),
           )
         ],
       )
    );
  }
  Future<Uint8List> readFileByte(String filePath) async {
    final myUri = Uri.parse(filePath);
    final audioFile = File.fromUri(myUri);
    var bytes=Uint8List(2);
    await audioFile.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value); 
    print('reading of bytes is completed');
  });
  return bytes;
}
Future<Uint8List> generarPdf1(InmuebleTotal inmuebleTotal,Map<String,dynamic> mapImagenesFile) async {
    pdf = pw.Document();

    /*imagen = PdfImage.file(
      pdf!.document,
      bytes: (await rootBundle.load(kGoogleImagePath)).buffer.asUint8List(),
    );*/
    
    /*final imagen = pw.MemoryImage(
      (await readFileByte('file:///storage/emulated/0/Pictures/20211218124155302.jpg'))
    );*/
   // final imageProvider=pw.MemoryImage(bytes);
    pdf!.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5,
        margin: pw.EdgeInsets.zero,
        build: (context) => [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20),
            child: pw.Center(
              child: pw.Text(
                '${inmuebleTotal.inmueble.tipoInmueble} en ${inmuebleTotal.inmueble.tipoContrato}',
                style: pw.TextStyle(
                  fontSize: 30,
                  color: PdfColors.blue,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ),
          pw.Text("GENERALES",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Precio: ${inmuebleTotal.inmueble.precio}"+r"$")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Ciudad: ${inmuebleTotal.inmueble.ciudad}, Zona: ${inmuebleTotal.inmueble.nombreZona}, Dirección: ${inmuebleTotal.inmueble.direccion}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Vendedor o agente inmobilicario: ${inmuebleTotal.creador.nombres} ${inmuebleTotal.creador.apellidos}, Email:${inmuebleTotal.creador.correo}, Teléfono: ${inmuebleTotal.creador.numeroTelefono}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Propietario: ${inmuebleTotal.propietario.nombres} ${inmuebleTotal.propietario.apellidos}, Email:${inmuebleTotal.propietario.correo}, Teléfono: ${inmuebleTotal.propietario.numeroTelefono}"),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "${inmuebleTotal.inmueble.mascotasPermitidas?"Mascotas permitidas, ":""} ${inmuebleTotal.inmueble.sinHipoteca?"Sin hipoteca, ":""} ${inmuebleTotal.inmueble.construccionEstrenar?"Construcción estrenar, ":""}"
              +"${inmuebleTotal.inmueble.materialesPrimera?"Materiales de primera, ":""}Superficie de terreno en m2: ${inmuebleTotal.inmueble.superficieTerreno}, "
              +"Superficie de construcción en m2: ${inmuebleTotal.inmueble.superficieConstruccion}, Tamaño de frente en metros: ${inmuebleTotal.inmueble.tamanioFrente}, "
              +"Antigüedad de construcción: ${inmuebleTotal.inmueble.antiguedadConstruccion}, ${inmuebleTotal.inmueble.proyectoPreventa?"Proyecto en pre venta, ":""}"
              +"Número de dueños: ${inmuebleTotal.inmueble.numeroDuenios}, ${inmuebleTotal.inmueble.serviciosBasicos?"Servicios básicos, ":""}"
              +"${inmuebleTotal.inmueble.gasDomiciliario?"Gas domiciliario, ":""} ${inmuebleTotal.inmueble.wifi?"Wi-Fi, ":""} ${inmuebleTotal.inmueble.medidorIndependiente?"Medidor independiente, ":""}"
              +"${inmuebleTotal.inmueble.termotanque?"Termotanques, ":""} ${inmuebleTotal.inmueble.calleAsfaltada?"Calle asfaltada, ":""} ${inmuebleTotal.inmueble.transporte?"Transporte (0-100m), ":""}"
              +"${inmuebleTotal.inmueble.preparadoDiscapacidad?"Preparado para discapacidad, ":""} ${inmuebleTotal.inmueble.papelesOrden?"Papeles en orden, ":""} ${inmuebleTotal.inmueble.habilitadoCredito?"Habilitado para crédito de vivienda social":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Detalles: ${inmuebleTotal.inmueble.detallesGenerales}"),
          ),
          pw.Text("INTERNAS",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
          if(inmuebleTotal.inmuebleInternas.plantas>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Plantas: ${inmuebleTotal.inmuebleInternas.plantas}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["plantas"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.ambientes>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Ambientes: ${inmuebleTotal.inmuebleInternas.ambientes}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["ambientes"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.dormitorios>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Dormitorios: ${inmuebleTotal.inmuebleInternas.dormitorios}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["dormitorios"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.banios>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Baños: ${inmuebleTotal.inmuebleInternas.banios}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["banios"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.garaje>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Garaje: ${inmuebleTotal.inmuebleInternas.garaje}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["garaje"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.amoblado)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Amoblado"),
              ),
              widgetImagenesCategoria(mapImagenesFile["amoblado"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.lavanderia)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Lavanderia"),
              ),
              widgetImagenesCategoria(mapImagenesFile["lavanderia"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.cuartoLavado)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Cuarto de lavado"),
              ),
              widgetImagenesCategoria(mapImagenesFile["cuarto_lavado"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.churrasquero)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Churrasquero"),
              ),
              widgetImagenesCategoria(mapImagenesFile["churrasquero"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.azotea)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Azotea"),
              ),
              widgetImagenesCategoria(mapImagenesFile["azotea"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.condominioPrivado)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("[Club house]-> Condominio privado"),
              ),
              widgetImagenesCategoria(mapImagenesFile["condominio_privado"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.cancha)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Cancha de fútbol, tenis, etc. en inmueble"),
              ),
              widgetImagenesCategoria(mapImagenesFile["cancha"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.piscina)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Piscina"),
              ),
              widgetImagenesCategoria(mapImagenesFile["piscina"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.sauna)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Sauna"),
              ),
              widgetImagenesCategoria(mapImagenesFile["sauna"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.jacuzzi)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Jacuzzi"),
              ),
              widgetImagenesCategoria(mapImagenesFile["jacuzzi"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.estudio)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Estudio"),
              ),
              widgetImagenesCategoria(mapImagenesFile["estudio"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.jardin)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Jardín"),
              ),
              widgetImagenesCategoria(mapImagenesFile["jardin"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.portonElectrico)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Portón eléctrico"),
              ),
              widgetImagenesCategoria(mapImagenesFile["porton_electrico"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.aireAcondicionado)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Aire acondicionado"),
              ),
              widgetImagenesCategoria(mapImagenesFile["aire_acondicionado"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.calefaccion)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Calefacción"),
              ),
              widgetImagenesCategoria(mapImagenesFile["calefaccion"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.ascensor)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Ascensor"),
              ),
              widgetImagenesCategoria(mapImagenesFile["ascensor"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.deposito)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Depósito"),
              ),
              widgetImagenesCategoria(mapImagenesFile["deposito"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.sotano)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Sótano"),
              ),
              widgetImagenesCategoria(mapImagenesFile["sotano"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.balcon)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Balcón"),
              ),
              widgetImagenesCategoria(mapImagenesFile["balcon"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.tienda)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Tienda"),
              ),
              widgetImagenesCategoria(mapImagenesFile["tienda"]??[]),
            ]
          ),
          if(inmuebleTotal.inmuebleInternas.amuralladoTerreno)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("[Amurallado]-> Terreno"),
              ),
              widgetImagenesCategoria(mapImagenesFile["amurallado_terreno"]??[]),
            ]
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Detalles: ${inmuebleTotal.inmuebleInternas.detallesInternas}"),
          ),
          pw.Text("COMUNIDAD",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "${inmuebleTotal.inmuebleComunidad.iglesia?"Iglesia, ":""} ${inmuebleTotal.inmuebleComunidad.parqueInfantil?"Parque infantil, ":""}"
              +"${inmuebleTotal.inmuebleComunidad.escuela?"Escuela, ":""} ${inmuebleTotal.inmuebleComunidad.universidad?"Universidad, ":""} ${inmuebleTotal.inmuebleComunidad.plazuela?"Plazuela, ":""}"
              +"${inmuebleTotal.inmuebleComunidad.moduloPolicial?"Módulo policial, ":""} ${inmuebleTotal.inmuebleComunidad.saunaPiscinaPublica?"Sauna/piscina pública, ":""}"
              +"${inmuebleTotal.inmuebleComunidad.gymPublico?"Gym público, ":""} ${inmuebleTotal.inmuebleComunidad.centroDeportivo?"Centro deportivo, ":""}"
              +"${inmuebleTotal.inmuebleComunidad.puestoSalud?"Puesto de salud, ":""} ${inmuebleTotal.inmuebleComunidad.zonaComercial?"Zona comercial":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Detalles: ${inmuebleTotal.inmuebleComunidad.detallesComunidad}"),
          ),
          pw.Text("OTROS",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "${inmuebleTotal.inmueblesOtros.rematesJudiciales?"Remates judiciales, ":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "Link vídeo 2D: ${inmuebleTotal.inmueblesOtros.video2DLink}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "Tour virtual 360 ${inmuebleTotal.inmueblesOtros.tourVirtual360Link}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "Vídeo tour 360: ${inmuebleTotal.inmueblesOtros.videoTour360Link}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Detalles: ${inmuebleTotal.inmueblesOtros.detallesOtros}"),
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.SizedBox(
            height: 70,
          ),
        ],
      ),
    );
    return pdf!.save();
  }
  pw.Widget widgetImagenesCategoria(List imagenes){
    return pw.Wrap(
      children: imagenes.map((e){
        return pw.Image(
          e,
          fit: pw.BoxFit.cover,
          height: 140,
          width: 140,
        );
      }).toList()
    );
  }
  Wrap widgetPrecios(double tamanioTextoPrecio,doubleTamanioTextoPrecio) {
    return Wrap(
      verticalDirection: VerticalDirection.down,
      direction: Axis.vertical,
      children: [
        widget.inmuebleTotal.getInmueble.getHistorialPrecios.length>1?
        (widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-1]<
        widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-2]?
        Row(
          children: [
            Text(
            "${widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-1].toString()}"+r"$",
              style: TextStyle(
                fontSize: tamanioTextoPrecio,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(width: 10,),
            Text(
            "${widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-2].toString()}"+r"$",
              style: TextStyle(
                fontSize: tamanioTextoPrecioRebajado,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontFamily: "fonts/Schyler-Regular.ttf",
                decoration:TextDecoration.lineThrough,
                decorationThickness: 2,                     
                decorationColor: Colors.red
              ),  
            ),
          ],
        )
        :
        Text(
          "${widget.inmuebleTotal.getInmueble.getPrecio.toString()}"+r"$",
          style: TextStyle(
                fontSize: tamanioTextoPrecio,
                fontWeight: FontWeight.bold
              )
        )
        ):Text(
          "${widget.inmuebleTotal.getInmueble.getPrecio.toString()}"+r"$",
          style: TextStyle(
                fontSize: tamanioTextoPrecio,
                fontWeight: FontWeight.bold
              )  
        ),
      ],
    );
  }
}
Future<bool> dialogFiltrar(
  BuildContext context,
  String titulo
)async{
  bool respuesta=false;
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            //title: Center(child: Text(titulo,style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: 250,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text("Filtrar por dormitorios"),
                            trailing: Icon(
                              Icons.arrow_forward_ios
                            ),
                            onTap: (){
                              respuesta=true;
                              Navigator.pop(context,respuesta);
                            },
                          )
                        ],
                      ),
                    ),
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

class PopupMenuFiltrar extends StatelessWidget {
  const PopupMenuFiltrar({Key? key,required this.icon,required this.tooltip,required this.mensaje,required this.texto,required this.width,required this.height,required this.onTap}) : super(key: key);
  final Widget icon;
  final double width;
  final double height;
  final String texto;
  final String tooltip;
  final String mensaje;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: PopupMenuButton(
        tooltip: tooltip,
        elevation: 30,
        offset: const Offset(0, 40),
        color: Colors.white.withOpacity(0.8),
        enableFeedback: false,
        icon:texto==""?icon:Text(texto),
        padding: EdgeInsets.zero,
        itemBuilder: (context){
          return [
            PopupMenuItem<int>(
              //padding: EdgeInsets.all(5),
              value: 0, 
              child: Container(
                child:InkWell(
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(mensaje
                      ),
                    ),
                  ),
                  onTap: (){
                    onTap();
                    Navigator.pop(context);
                  },
                ),
              ),

            ),
          ];
        }
      ),
    );
  }
}