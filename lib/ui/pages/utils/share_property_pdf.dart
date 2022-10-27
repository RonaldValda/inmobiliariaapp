import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:io';
 pw.Document? pdf;
Uint8List? archivoPdf;
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
Future<Uint8List> generarPdf1(PropertyTotal inmuebleTotal,Map<String,dynamic> mapImagenesFile) async {
    pdf = pw.Document();
    pdf!.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5,
        margin: pw.EdgeInsets.zero,
        build: (context) => [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20),
            child: pw.Center(
              child: pw.Text(
                '${inmuebleTotal.property.propertyType} en ${inmuebleTotal.property.contractType}',
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
            child: pw.Text("Precio: ${inmuebleTotal.property.price}"+r"$")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Ciudad: ${inmuebleTotal.property.city}, Zona: ${inmuebleTotal.property.zoneName}, Dirección: ${inmuebleTotal.property.address}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Vendedor o agente inmobilicario: ${inmuebleTotal.creator.names} ${inmuebleTotal.creator.surnames}, Email:${inmuebleTotal.creator.email}, Teléfono: ${inmuebleTotal.creator.phoneNumber}")
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Propietario: ${inmuebleTotal.owner.names} ${inmuebleTotal.owner.surnames}, Email:${inmuebleTotal.owner.email}, Teléfono: ${inmuebleTotal.owner.phoneNumber}"),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "${inmuebleTotal.property.enablePets?"Mascotas permitidas, ":""} ${inmuebleTotal.property.noMortgage?"Sin hipoteca, ":""} ${inmuebleTotal.property.newConstruction?"Construcción estrenar, ":""}"
              +"${inmuebleTotal.property.premiumMaterials?"Materiales de primera, ":""}Superficie de terreno en m2: ${inmuebleTotal.property.landSurface}, "
              +"Superficie de construcción en m2: ${inmuebleTotal.property.constructionSurface}, Tamaño de frente en metros: ${inmuebleTotal.property.frontSize}, "
              +"Antigüedad de construcción: ${inmuebleTotal.property.constructionAntiquity}, ${inmuebleTotal.property.preSaleProject?"Proyecto en pre venta, ":""}"
              +"Número de dueños: ${inmuebleTotal.property.ownersNumber}, ${inmuebleTotal.property.basicServices?"Servicios básicos, ":""}"
              +"${inmuebleTotal.property.householdGas?"Gas domiciliario, ":""} ${inmuebleTotal.property.wifi?"Wi-Fi, ":""} ${inmuebleTotal.property.independentMeter?"Medidor independiente, ":""}"
              +"${inmuebleTotal.property.hotWaterTank?"Termotanques, ":""} ${inmuebleTotal.property.pavedStreet?"Calle asfaltada, ":""} ${inmuebleTotal.property.transport?"Transporte (0-100m), ":""}"
              +"${inmuebleTotal.property.disabilityPrepared?"Preparado para discapacidad, ":""} ${inmuebleTotal.property.orderPapers?"Papeles en orden, ":""} ${inmuebleTotal.property.enabledCredit?"Habilitado para crédito de vivienda social":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Detalles: ${inmuebleTotal.property.generalDetails}"),
          ),
          pw.Text("INTERNAS",
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold
            )
          ),
          if(inmuebleTotal.propertyInternal.floorsNumber>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Plantas: ${inmuebleTotal.propertyInternal.floorsNumber}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["plantas"]??[]),
            ]
          ),
          if(inmuebleTotal.propertyInternal.roomsNumber>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Ambientes: ${inmuebleTotal.propertyInternal.roomsNumber}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["ambientes"]??[]),
            ]
          ),
          if(inmuebleTotal.propertyInternal.bedroomsNumber>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Dormitorios: ${inmuebleTotal.propertyInternal.bedroomsNumber}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["dormitorios"]??[]),
            ]
          ),
          if(inmuebleTotal.propertyInternal.bathroomsNumber>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Baños: ${inmuebleTotal.propertyInternal.bathroomsNumber}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["banios"]??[]),
            ]
          ),
          if(inmuebleTotal.propertyInternal.garagesNumber>0)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text("Garaje: ${inmuebleTotal.propertyInternal.garagesNumber}"),
              ),
              widgetImagenesCategoria(mapImagenesFile["garaje"]??[]),
            ]
          ),
          if(inmuebleTotal.propertyInternal.furnished)
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
          if(inmuebleTotal.propertyInternal.laundry)
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
          if(inmuebleTotal.propertyInternal.laundryRoom)
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
          if(inmuebleTotal.propertyInternal.grill)
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
          if(inmuebleTotal.propertyInternal.rooftop)
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
          if(inmuebleTotal.propertyInternal.privateCondominium)
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
          if(inmuebleTotal.propertyInternal.court)
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
          if(inmuebleTotal.propertyInternal.pool)
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
          if(inmuebleTotal.propertyInternal.sauna)
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
          if(inmuebleTotal.propertyInternal.jacuzzi)
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
          if(inmuebleTotal.propertyInternal.studio)
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
          if(inmuebleTotal.propertyInternal.garden)
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
          if(inmuebleTotal.propertyInternal.electricGate)
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
          if(inmuebleTotal.propertyInternal.airConditioning)
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
          if(inmuebleTotal.propertyInternal.heating)
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
          if(inmuebleTotal.propertyInternal.elevator)
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
          if(inmuebleTotal.propertyInternal.warehouse)
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
          if(inmuebleTotal.propertyInternal.basement)
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
          if(inmuebleTotal.propertyInternal.balcony)
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
          if(inmuebleTotal.propertyInternal.store)
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
          if(inmuebleTotal.propertyInternal.landWalled)
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
            child: pw.Text("Detalles: ${inmuebleTotal.propertyInternal.internalDetails}"),
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
              "${inmuebleTotal.propertyCommunity.church?"Iglesia, ":""} ${inmuebleTotal.propertyCommunity.playground?"Parque infantil, ":""}"
              +"${inmuebleTotal.propertyCommunity.school?"Escuela, ":""} ${inmuebleTotal.propertyCommunity.university?"Universidad, ":""} ${inmuebleTotal.propertyCommunity.smallSquare?"Plazuela, ":""}"
              +"${inmuebleTotal.propertyCommunity.policeModule?"Módulo policial, ":""} ${inmuebleTotal.propertyCommunity.publicSaunaPool?"Sauna/piscina pública, ":""}"
              +"${inmuebleTotal.propertyCommunity.publicGym?"Gym público, ":""} ${inmuebleTotal.propertyCommunity.sportCenter?"Centro deportivo, ":""}"
              +"${inmuebleTotal.propertyCommunity.postHealth?"Puesto de salud, ":""} ${inmuebleTotal.propertyCommunity.shoopingZone?"Zona comercial":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Detalles: ${inmuebleTotal.propertyCommunity.communityDetails}"),
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
              "${inmuebleTotal.propertyOthers.judicialAuctions?"Remates judiciales, ":""}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "Link vídeo 2D: ${inmuebleTotal.propertyOthers.video2DLink}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "Tour virtual 360 ${inmuebleTotal.propertyOthers.tourVirtual360Link}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(
              "Vídeo tour 360: ${inmuebleTotal.propertyOthers.videoTour360Link}"
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text("Detalles: ${inmuebleTotal.propertyOthers.othersDetails}"),
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
    _widthImage=170;
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: imagenes.map((e){
        return pw.Image(
          e,
          fit: pw.BoxFit.cover,
          height: _widthImage*0.7,
          width: _widthImage,
        );
      }).toList()
    );
  }
  double _widthImage=190;
  Future<Uint8List> generarPdfImagesMain(PropertyTotal inmuebleTotal,Map<String,dynamic> mapImagenesFile) async {
    double horizontalPadding=40;
    pdf = pw.Document();
    pdf!.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: pw.EdgeInsets.symmetric(vertical:30),
        build: (context) => [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
            child: pw.Center(
              child: pw.Text(
                '${inmuebleTotal.property.propertyType} en ${inmuebleTotal.property.contractType}',
                style: pw.TextStyle(
                  fontSize: 30,
                  color: PdfColors.blue,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
            child: widgetImagenesCategoria(mapImagenesFile["principales"]??[]),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 10,bottom:10),
                  child: pw.Center(
                    child: pw.Text("GENERALES",
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold
                      )
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Precio: ${inmuebleTotal.property.price}"+r"$")
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Ciudad: ${inmuebleTotal.property.city}, Zona: ${inmuebleTotal.property.zoneName}, Dirección: ${inmuebleTotal.property.address}")
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Vendedor o agente inmobilicario: ${inmuebleTotal.creator.names} ${inmuebleTotal.creator.surnames}, Email:${inmuebleTotal.creator.email}, Teléfono: ${inmuebleTotal.creator.phoneNumber}")
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text(
                    "${inmuebleTotal.property.enablePets?"Mascotas permitidas, ":""} ${inmuebleTotal.property.noMortgage?"Sin hipoteca, ":""} ${inmuebleTotal.property.newConstruction?"Construcción estrenar, ":""}"
                    +"${inmuebleTotal.property.premiumMaterials?"Materiales de primera, ":""}Superficie de terreno en m2: ${inmuebleTotal.property.landSurface}, "
                    +"Superficie de construcción en m2: ${inmuebleTotal.property.constructionSurface}, Tamaño de frente en metros: ${inmuebleTotal.property.frontSize}, "
                    +"Antigüedad de construcción: ${inmuebleTotal.property.constructionAntiquity}, ${inmuebleTotal.property.preSaleProject?"Proyecto en pre venta, ":""}"
                    +"Número de dueños: ${inmuebleTotal.property.ownersNumber}, ${inmuebleTotal.property.basicServices?"Servicios básicos, ":""}"
                    +"${inmuebleTotal.property.householdGas?"Gas domiciliario, ":""} ${inmuebleTotal.property.wifi?"Wi-Fi, ":""} ${inmuebleTotal.property.independentMeter?"Medidor independiente, ":""}"
                    +"${inmuebleTotal.property.hotWaterTank?"Termotanques, ":""} ${inmuebleTotal.property.pavedStreet?"Calle asfaltada, ":""} ${inmuebleTotal.property.transport?"Transporte (0-100m), ":""}"
                    +"${inmuebleTotal.property.disabilityPrepared?"Preparado para discapacidad, ":""} ${inmuebleTotal.property.orderPapers?"Papeles en orden, ":""} ${inmuebleTotal.property.enabledCredit?"Habilitado para crédito de vivienda social":""}"
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Detalles: ${inmuebleTotal.property.generalDetails}"),
                ),
              ]
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                  child: pw.Center(
                    child: pw.Text("INTERNAS",
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold
                      )
                    ),
                  )
                ),
                if(inmuebleTotal.propertyInternal.floorsNumber>0)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Plantas: ${inmuebleTotal.propertyInternal.floorsNumber}"),
                ),
                if(inmuebleTotal.propertyInternal.roomsNumber>0)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Ambientes: ${inmuebleTotal.propertyInternal.roomsNumber}"),
                ),
                if(inmuebleTotal.propertyInternal.bedroomsNumber>0)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Dormitorios: ${inmuebleTotal.propertyInternal.bedroomsNumber}"),
                ),
                if(inmuebleTotal.propertyInternal.bathroomsNumber>0)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Baños: ${inmuebleTotal.propertyInternal.bathroomsNumber}"),
                ),
                if(inmuebleTotal.propertyInternal.garagesNumber>0)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Garaje: ${inmuebleTotal.propertyInternal.garagesNumber}"),
                ),
                if(inmuebleTotal.propertyInternal.furnished)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Amoblado"),
                ),
                if(inmuebleTotal.propertyInternal.laundry)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Lavanderia"),
                ),
                if(inmuebleTotal.propertyInternal.laundryRoom)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Cuarto de lavado"),
                ),
                if(inmuebleTotal.propertyInternal.grill)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Churrasquero"),
                ),
                if(inmuebleTotal.propertyInternal.rooftop)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Azotea"),
                ),
                if(inmuebleTotal.propertyInternal.privateCondominium)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("[Club house]-> Condominio privado"),
                ),
                if(inmuebleTotal.propertyInternal.court)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Cancha de fútbol, tenis, etc. en inmueble"),
                ),
                if(inmuebleTotal.propertyInternal.pool)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Piscina"),
                ),
                if(inmuebleTotal.propertyInternal.sauna)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Sauna"),
                ),
                if(inmuebleTotal.propertyInternal.jacuzzi)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Jacuzzi"),
                ),
                if(inmuebleTotal.propertyInternal.studio)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Estudio"),
                ),
                if(inmuebleTotal.propertyInternal.garden)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Jardín"),
                ),
                if(inmuebleTotal.propertyInternal.electricGate)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Portón eléctrico"),
                ),
                if(inmuebleTotal.propertyInternal.airConditioning)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Aire acondicionado"),
                ),
                if(inmuebleTotal.propertyInternal.heating)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Calefacción"),
                ),
                if(inmuebleTotal.propertyInternal.elevator)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Ascensor"),
                ),
                if(inmuebleTotal.propertyInternal.warehouse)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Depósito"),
                ),
                if(inmuebleTotal.propertyInternal.basement)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Sótano"),
                ),
                if(inmuebleTotal.propertyInternal.balcony)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Balcón"),
                ),
                if(inmuebleTotal.propertyInternal.store)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Tienda"),
                ),
                if(inmuebleTotal.propertyInternal.landWalled)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("[Amurallado]-> Terreno"),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Detalles: ${inmuebleTotal.propertyInternal.internalDetails}"),
                ),
              ]
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                  child: pw.Center(
                    child: pw.Text("COMUNIDAD",
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold
                      )
                    ),
                  )
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text(
                    "${inmuebleTotal.propertyCommunity.church?"Iglesia, ":""} ${inmuebleTotal.propertyCommunity.playground?"Parque infantil, ":""}"
                    +"${inmuebleTotal.propertyCommunity.school?"Escuela, ":""} ${inmuebleTotal.propertyCommunity.university?"Universidad, ":""} ${inmuebleTotal.propertyCommunity.smallSquare?"Plazuela, ":""}"
                    +"${inmuebleTotal.propertyCommunity.policeModule?"Módulo policial, ":""} ${inmuebleTotal.propertyCommunity.publicSaunaPool?"Sauna/piscina pública, ":""}"
                    +"${inmuebleTotal.propertyCommunity.publicGym?"Gym público, ":""} ${inmuebleTotal.propertyCommunity.sportCenter?"Centro deportivo, ":""}"
                    +"${inmuebleTotal.propertyCommunity.postHealth?"Puesto de salud, ":""} ${inmuebleTotal.propertyCommunity.shoopingZone?"Zona comercial":""}"
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Detalles: ${inmuebleTotal.propertyCommunity.communityDetails}"),
                ),
              ]
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 20,horizontal: horizontalPadding),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                  child: pw.Center(
                    child: pw.Text("OTROS",
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold
                      )
                    ),
                  )
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text(
                    "${inmuebleTotal.propertyOthers.judicialAuctions?"Remates judiciales, ":""}"
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text(
                    "Link vídeo 2D: ${inmuebleTotal.propertyOthers.video2DLink}"
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text(
                    "Tour virtual 360 ${inmuebleTotal.propertyOthers.tourVirtual360Link}"
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text(
                    "Vídeo tour 360: ${inmuebleTotal.propertyOthers.videoTour360Link}"
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Text("Detalles: ${inmuebleTotal.propertyOthers.othersDetails}"),
                ),
              ]
            )
          ),
        ],
      ),
    );
    return pdf!.save();
  }